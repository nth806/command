function synctime_check () {
  if [ ! -f ${SYNC_TRACKER_DIR}/${GIT_CLIENT_BRANCH} ]; then
    cmn_exitAbnormal "The client branch [${GIT_CLIENT_BRANCH}] has never been synchronized"
  fi
}