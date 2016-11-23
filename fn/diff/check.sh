function __trim_prefix () {
  FILE_PATH=`cmn_trimSpaces "${FILE_PATH}"`

  cmn_isStartWith $CLIENT_DIR/ "${FILE_PATH}"
  if [ $? -eq 0 ] ; then
  	FILE_PATH=`cmn_rmLeadingWith $CLIENT_DIR/ "${FILE_PATH}"`
  	return
  fi

  cmn_isStartWith $TTV_SR/ "${FILE_PATH}"
  if [ $? -eq 0 ] ; then
  	FILE_PATH=`cmn_rmLeadingWith $TTV_SRC/ "${FILE_PATH}"`
  	return
  fi
}

function diff_check () {
  cmn_showTitleStep 'Check Path'

  __trim_prefix
  if [ "x${FILE_PATH}" = "x" ] ; then
    cmn_exitAbnormal "The inputted path is considered as empty"
  fi

  if [ ! -f "${CLIENT_DIR}/${FILE_PATH}" ] ; then
    cmn_exitAbnormal "File [${CLIENT_DIR}/${FILE_PATH}] doesn't exist"
  fi

  if [ ! -f "${TTV_SRC}/${FILE_PATH}" ] ; then
    cmn_exitAbnormal "File [${TTV_SRC}/${FILE_PATH}] doesn't exist"
  fi
}