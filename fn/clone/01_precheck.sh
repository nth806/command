function clone_precheck () {
  comp_show_title_step 'Precheck for getting source'

  cmn_isEmptyFolder "${BASE_DIR}/${CLIENT_DIR}"
  if [ $? -ne 0 ]; then
    cmn_exitAbnormal "'${BASE_DIR}/${CLIENT_DIR}' is not an empty folder!"
  fi

  if [ "x${1}" = "x-f" ]; then
    return
  fi

  cmn_isEmptyFolder "${BASE_DIR}/${TTV_SRC}"
  if [ $? -ne 0 ]; then
    cmn_exitAbnormal "'${BASE_DIR}/${TTV_SRC}' is not an empty folder!"
  fi

  cmn_isEmptyFolder "${SYNC_TRACKER_DIR}"
  if [ $? -ne 0 ]; then
    cmn_exitAbnormal "'${SYNC_TRACKER_DIR}' is not an empty folder!"
  fi
  touch "${SYNC_TRACKER_DIR}/.gitignore"

  if [ "x${VAGRANT_BOX_URL}" = "x" ]; then
    VAGRANT_BOX_URL="${VAGRANT_BOX_NAME}"
  fi
}
