function fetch_check () {
  cmn_showTitleStep "Check folder ${CLIENT_DIR}"

  if [ "x${CLIENT_REP_URL}" = "x" ]; then
    echo_Red 'The project has not been initialized yet'
    echo 'Please try'
    cmn_exitAbnormal "  $(help_cmn_command)"
  fi

  if [ ! -d ${CLIENT_DIR} ]; then
    mkdir ${CLIENT_DIR}
    return
  fi

  cmn_isEmptyFolder ${CLIENT_DIR}
  if [ $? -eq 0 ]; then
    return
  fi

  if [ -e  "${CLIENT_DIR}/.git" ]; then
    cmn_confirm4Exit "'${CLIENT_DIR}' folder is a git repository. We will delete it!"
  else
    cmn_confirm4Exit "'${CLIENT_DIR}' folder is not empty, we will clear it!"
  fi

  rm -rf ${CLIENT_DIR}
  mkdir ${CLIENT_DIR}
}