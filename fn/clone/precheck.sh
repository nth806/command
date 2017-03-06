function clone_precheck () {
  cmn_showTitleStep 'Precheck for getting source'

  cmn_isEmptyFolder "${BASE_DIR}/${CLIENT_DIR}"
  if [ $? -ne 0 ]; then
    cmn_exitAbnormal "'${BASE_DIR}/${CLIENT_DIR}' is not an empty folder!"
  fi

  cmn_isEmptyFolder "${BASE_DIR}/${TTV_SRC}"
  if [ $? -ne 0 ]
  then
    cmn_exitAbnormal "'${BASE_DIR}/${TTV_SRC}' is not an empty folder!"
  fi

  cmn_isEmptyFolder "${SYNC_TRACKER}"
  if [ $? -ne 0 ]
  then
    cmn_exitAbnormal "'${SYNC_TRACKER}' is not an empty folder!"
  fi
}
