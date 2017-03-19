function __cpPath () {
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
  cmn_showTitleStep "Copy files"

  echo 'START ----------------'
  START_STT=1
  while read line; do
    __cpPath $line
  done < ${FILELIST_PATH}
  __cpPath $line
  echo 'END ------------------'

  rm -f ${FILELIST_PATH}
}
