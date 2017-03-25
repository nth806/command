function __add_ignore_list () {
  local line=`echo ${1} | sed -e 's/\r//g'`
  line=`cmn_trimSpaces "${line}"`

  cmn_isStartWith '#' ${line}
  if [ $? -eq 0 ] ; then
    return
  fi

  if [ "x${line}" = "x" ]; then
    return
  fi

  IS_IGNORE=0
  IGNORE_LIST+=("${line}")
}

function __is_in_ignore () {
  if [ ${IS_IGNORE} -ne 0 ] ; then
    return 1
  fi

  local ignore_path=
  for ignore_path in "${IGNORE_LIST[@]}"
  do
    if [ ${ignore_path:0:1} = '!' ]; then
      ignore_path=${ignore_path:1}

      cmn_isStartWith "$ignore_path" "$1/"
      if [ $? -eq 0 ] ; then
        return 1
      fi
    fi

    cmn_isStartWith "$ignore_path" "$1/"
    if [ $? -eq 0 ] ; then
      return 0
    fi
  done

  return 1
}

function __process_line_diff () {
  if [ "x${1}" = "x" ]
  then
    return 0
  fi
  local line="${1}"

  prefix="Only in ${TTV_SRC}"
  cmn_isStartWith "${prefix}" "${line}"
  if [ $? -eq 0 ]
  then
    line=${line#$prefix}
    line=`echo "${line}" | sed -e "s/: /\//"`
    line=${line:1}

    __is_in_ignore "${line}"
    if [ $? -eq 0 ] ; then
      return 0
    fi

    cd ${TTV_SRC}
    git ls-files "${line}" --error-unmatch 1>/dev/null 2>/dev/null
    if [ $? -ne 0 ] ; then
      cd "${BASE_DIR}"
      return 0
    fi
    cd "${BASE_DIR}"

    if [ -f "${TTV_SRC}/${line}" ]
    then
      echo "Add file ${line}"
      echo "+ ${line}" >> ${OUTPUT_TMP}
    else
      echo "Add directory ${line}"
      echo "+d${line}" >> ${OUTPUT_TMP}
    fi
    return 0
  fi

  prefix="Files ${TTV_SRC}"
  cmn_isStartWith "${prefix}" "${line}"
  if [ $? -eq 0 ]
  then
    line=${line#$prefix}
    line=`echo ${line} | sed -n 's/\(.*\)\ and\ .*/\1/p'`
    line=${line:1}

    __is_in_ignore "${line}"
    if [ $? -eq 0 ] ; then
      return 0
    fi

    git ls-files "${TTV_SRC}/${line}" --error-unmatch 1>/dev/null 2>/dev/null
    if [ $? -ne 0 ] ; then
      return 0
    fi

    echo "Update file ${line}"
    echo "+ ${line}" >> ${OUTPUT_TMP}
    return 0
  fi

  prefix="Only in ${CLIENT_DIR}"
  cmn_isStartWith "${prefix}" "${line}"
  if [ $? -eq 0 ]
  then
    line=${line#$prefix}
    line=`echo "${line}" | sed -e "s/: /\//"`
    line=${line:1}

    __is_in_ignore "${line}"
    if [ $? -eq 0 ] ; then
      return 0
    fi

    cd ${CLIENT_DIR}
    git ls-files "${line}" --error-unmatch 1>/dev/null 2>/dev/null
    if [ $? -ne 0 ] ; then
      cd "${BASE_DIR}"
      return 0
    fi
    cd "${BASE_DIR}"

    if [ -f "${CLIENT_DIR}/${line}" ]
    then
      echo "Remove file ${line}"
      echo "- ${line}" >> ${OUTPUT_TMP}
    else
      echo "Remove directory ${line}"
      echo "-d${line}" >> ${OUTPUT_TMP}
    fi
    return 0
  fi
}

function __process_line_ci () {
  local path=`echo ${1} | sed -e 's/\r//g'`
  local prefix=
  local vc=
  if [ "x${path}" = "x" ]; then
    return
  fi

  prefix=${path:0:1}
  if [ "x${prefix}" = 'x+' ]; then
    vc=2
  elif [ "x${prefix}" = 'x-' ]; then
    vc=0
  else
    cmn_exitAbnormal 'Line ['"${path}"'] does not start with [+|-]'
  fi
  path=${path:1}

  prefix=${path:0:1}
  if [ "x${prefix}" = 'xd' ]; then
    vc=$((vc + 1))
  elif [ "x${prefix}" != 'x ' ]; then
    cmn_exitAbnormal 'Line ['"${path}"'] does not start with [d| ]'
  fi
  path=${path:1}

  cd $CLIENT_DIR
  case $vc in
    0) # Delete file
      git rm $path
      ;;
    1) # Delete folder
      git rm -r $path
      ;;
    2) # Add file
      cp -rf "$BASE_DIR/$TTV_SRC/$path" "$BASE_DIR/$CLIENT_DIR/$path"
      git add $path
      ;;
    3)
      mkdir -p "$BASE_DIR/$CLIENT_DIR/$path"
      cp -rf "$BASE_DIR/$TTV_SRC/$path"/* "$BASE_DIR/$CLIENT_DIR/$path"/
      cd $path
      git add *
      cd $BASE_DIR/$CLIENT_DIR
      ;;
    *) # Error
      cmn_exitAbnormal 'Value for committing ['"${vc}"'] is not valid'
      ;;
  esac

  cd $BASE_DIR
  rm -rf ${OUTPUT_TMP}
}

function sync_check () {
  cmn_showTitleStep 'Check source preparing for pushing'
  local line=
  local PRI_IFS

  rm -rf ${OUTPUT_TMP}

  # Read ignore list
  IS_IGNORE=1
  IGNORE_LIST=()
  if [ -f "${IGNORE_FILE}" ] ; then
    PRI_IFS=$IFS
    export IFS=$'\n'
    while read line; do
      __add_ignore_list "${line}"
    done < ${IGNORE_FILE}
    __add_ignore_list "${line}"
    export IFS=$PRI_IFS
  fi

  # Add to tmp files
  PRI_IFS=$IFS
  export IFS=$'\n'
  echo -n 'START ----------------'
  echo -e '\033[1;35m'

  local ARR_SYN_PATHS
  local SYN_PATH
  local IS_SUBPATH

  if [ "x${SYN_PATHS}" = "x" ]; then
    ARR_SYN_PATHS=('')
    IS_SUBPATH=1
  else
    IFS=',;:' read -r -a ARR_SYN_PATHS <<< "${SYN_PATHS}"
    IS_SUBPATH=0
  fi

  for SYN_PATH in "${ARR_SYN_PATHS[@]}"
  do
    SYN_PATH=`cmn_trimSpaces "${SYN_PATH}"`

    if [ $IS_SUBPATH -eq 0 ] && [ "x${SYN_PATH}" = "x" ]; then
      continue
    fi

    if [ ! -d "${TTV_SRC}/${SYN_PATH}" ]; then
      mkdir -p "${TTV_SRC}/${SYN_PATH}"
    fi

    if [ ! -d "${CLIENT_DIR}/${SYN_PATH}" ]; then
      mkdir -p "${CLIENT_DIR}/${SYN_PATH}"
    fi

    for line in `diff -rq -X "${BIN_DIR}/cfg/sync_ignore" -X config/sync_ignore_diff "${TTV_SRC}/${SYN_PATH}" "${CLIENT_DIR}/${SYN_PATH}"`
    do
      __process_line_diff "${line}"
    done
  done

  export IFS=$PRI_IFS
  echo -e -n '\033[0m'
  echo 'END ------------------'

  if [ ! -f ${OUTPUT_TMP} ] ; then
    echo_Yellow "There is no updated file"
    cmn_exitNormal
  fi

  cmn_confirm4Exit "Start to copy to client repository!"
  PRI_IFS=$IFS
  export IFS=$'\n'
  while read line; do
    __process_line_ci "${line}"
  done < ${OUTPUT_TMP}
  __process_line_ci "${line}"
  export IFS=$PRI_IFS
}
