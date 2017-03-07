function fetch_run () {
  git clone ${CLIENT_REP_URL} ${CLIENT_DIR}
  if [ $? -ne 0 ]
  then
    cmn_exitAbnormal "Clone client source failed"
  fi
}