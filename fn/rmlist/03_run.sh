function __rmPath () {
  local line=`echo ${1}`
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

  echo "${line}"
  if [ -f "${REMOVE_BASE_DIR}/${line}" ]; then
    rm -f "${REMOVE_BASE_DIR}/${line}"
    return
  elif [ -d "${REMOVE_BASE_DIR}/${line}" ]; then
    rm -rf "${REMOVE_BASE_DIR}/${line}"
    return
  fi

  echo_Red "Path ${line} doesn't exist"
}

function rmlist_run () {
  cmn_showTitleStep "Remove files"

  echo 'START ----------------'
  START_STT=1
  while read line; do
    __rmPath $line
  done < ${FILELIST_PATH}
  __rmPath $line
  echo 'END ------------------'

  rm -f ${FILELIST_PATH}
}
