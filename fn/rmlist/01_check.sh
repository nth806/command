function rmlist_check () {
  cmn_showTitleStep "Check parameters"

  REMOVE_BASE_DIR=`cmn_trimSlash ${REMOVE_BASE_DIR}`
  if [ ! -d "${REMOVE_BASE_DIR}" ]
  then
    cmn_exitAbnormal "Removed base directory <${REMOVE_BASE_DIR}> does not exist!"
  fi

  cmn_isEmptyFolder "${REMOVE_BASE_DIR}"
  if [ $? -eq 0 ]
  then
    cmn_confirm4Exit "Removed base directory <${REMOVE_BASE_DIR}> is empty!"
  fi
}
