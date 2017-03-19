function synctime_run () {
  date +'%Y-%m-%d %H:%M:%S %z' > ${SYNC_TRACKER_DIR}/${GIT_CLIENT_BRANCH}
}