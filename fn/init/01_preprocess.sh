function init_prepocess () {
  comp_show_title_step 'Create necessary folders'

  mkdir -p "${BASE_DIR}/${CLIENT_DIR}"
  cmn_isEmptyFolder "${BASE_DIR}/${CLIENT_DIR}"
  if [ $? -ne 0 ]
  then
    if [ -e "${BASE_DIR}/${CLIENT_DIR}/.git" ]
    then
      cmn_exitAbnormal "'${BASE_DIR}/${CLIENT_DIR}' folder has alredy been configured to git repository"
    fi
    cmn_confirm4Exit "'${BASE_DIR}/${CLIENT_DIR}' folder is not empty, we will clear it!"
    rm -rf "${BASE_DIR}/${CLIENT_DIR}"
    mkdir -p "${BASE_DIR}/${CLIENT_DIR}"
  fi

  mkdir -p "${BASE_DIR}/${TTV_SRC}"
  cmn_isEmptyFolder "${BASE_DIR}/${TTV_SRC}"
  if [ $? -ne 0 ]
  then
    cmn_confirm4Exit "'${BASE_DIR}/${TTV_SRC}' folder is not empty, we will clear it!"
    rm -rf "${BASE_DIR}/${TTV_SRC}"
    mkdir -p "${BASE_DIR}/${TTV_SRC}"
  fi

  rm -rf "${SYNC_TRACKER_DIR}"
  mkdir -p "${SYNC_TRACKER_DIR}"
  touch "${SYNC_TRACKER_DIR}/.gitignore"

  # Make output folder (a temporary folder)
  mkdir -p "${BASE_DIR}/${OUTPUT_DIR}"
  touch "${BASE_DIR}/${OUTPUT_DIR}/.gitignore"
}
