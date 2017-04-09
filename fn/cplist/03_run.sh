function __cpPath () {
  local line=`echo "${1}"`
  local return_status=0
  local rename_old=
  line=`cmn_trimSpaces "${line}"`
  
  if [ ${START_STT} -ne 0 ] ; then
    if [ "x${line}" = "x" ]; then
      return
    fi

    cmn_isStartWith '#' ${line}
    if [ $? -eq 0 ] ; then
      return
    fi

    START_STT=0
  fi

  if [ "x${line}" = "x" ]; then
    return
  fi

  # Synchronize with git status at begging of line
  if [ "x${PREFIX_STATUS}" = "xtrue" ]; then
    line=`git_removePrefixStatus "${line}"`
    return_status=$?
    line=`cmn_rmLeadingWith ${SRC_DIR}/ "${line}"`

    # File deleted case
    if [ $return_status -eq 1 ]; then
      echo "Delete file ${line}"
      rm -f ${DES_DIR}/${line}
      return
    fi

    # File renamed case
    if [ $return_status -eq 2 ]; then
      echo "Renamed ${line}"
      rename_old=`echo ${line% *}`
      rm -f ${DES_DIR}/${rename_old}

      line=`echo ${line#* }`
      line=`cmn_rmLeadingWith ${SRC_DIR}/ "${line}"`
    fi
  fi

  if [ -f ${SRC_DIR}/${line} ]; then
    echo "Copy file ${line}"
    mkdir -p `dirname "${DES_DIR}/${line}"`
    cp -f ${SRC_DIR}/${line} ${DES_DIR}/${line}
    return
  elif [ -d ${SRC_DIR}/${line} ]; then
    echo "Copy directory ${line}"
    mkdir -p "${DES_DIR}/${line}"
    cp -rf ${SRC_DIR}/${line}/* ${DES_DIR}/${line}/
    return
  fi

  echo
  echo "Path ${line} doesn't exist"
  rm -f ${FILELIST_PATH}
  cmn_exitAbnormal
}

function cplist_run () {
  comp_show_title_step "Copy files"

  echo 'START ----------------'
  START_STT=1
  while read line; do
    __cpPath "${line}"
  done < ${FILELIST_PATH}
  __cpPath "${line}"
  echo 'END ------------------'

  rm -f ${FILELIST_PATH}
}
