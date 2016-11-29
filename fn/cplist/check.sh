function cplist_check () {
  cmn_showTitleStep "Check parameters"

  if [ "x${DES_DIR}" = "x" ]
  then
    cmn_exitAbnormal "Please input destination directory."
  fi
  DES_DIR=`cmn_trimSlash ${DES_DIR}`
  mkdir -p ${DES_DIR}

  cmn_isEmptyFolder ${DES_DIR}
  if [ $? -ne 0 ]
  then
    cmn_confirm4Exit "Destination directory <${DES_DIR}> is not empty!"
  fi

  SRC_DIR=`cmn_trimSlash ${SRC_DIR}`
  if [ ! -d "$SRC_DIR" ]
  then
    cmn_confirm4Exit "Source directory <${SRC_DIR}> does not exist!"
  fi
}