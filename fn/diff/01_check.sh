function __trim_prefix () {
  FILE_DIFF_PATH=`cmn_trimSpaces "${FILE_DIFF_PATH}"`

  cmn_isStartWith "${CLIENT_DIR}/" "${FILE_DIFF_PATH}"
  if [ $? -eq 0 ] ; then
    FILE_DIFF_PATH=`cmn_rmLeadingWith $CLIENT_DIR/ "${FILE_DIFF_PATH}"`
    return
  fi

  cmn_isStartWith "${TTV_SRC}/" "${FILE_DIFF_PATH}"
  if [ $? -eq 0 ] ; then
    FILE_DIFF_PATH=`cmn_rmLeadingWith ${TTV_SRC}/ "${FILE_DIFF_PATH}"`
    return
  fi
}

function diff_check () {
  comp_show_title_step 'Check Path'

  __trim_prefix
  if [ "x${FILE_DIFF_PATH}" = "x" ] ; then
    cmn_exitAbnormal "The inputted path is considered as empty"
  fi

  if [ ! -f "${CLIENT_DIR}/${FILE_DIFF_PATH}" ] ; then
    cmn_exitAbnormal "File [${CLIENT_DIR}/${FILE_DIFF_PATH}] doesn't exist"
  fi

  if [ ! -f "${TTV_SRC}/${FILE_DIFF_PATH}" ] ; then
    cmn_exitAbnormal "File [${TTV_SRC}/${FILE_DIFF_PATH}] doesn't exist"
  fi
}
