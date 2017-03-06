function init_prepocess () {
  cmn_showTitleStep 'Check configuration'

  if [ "x" = "x${PROJECT_ID}" ] || \
     [ "x" = "x${CLIENT_REP_URL}" ] || \
     [ "x" = "x${VAGRANT_BOX_NAME}" ] || \
     [ "x" = "x${VAGRANT_BOX_URL}" ] || \
     [ "x" = "x${VAGRANT_GUESS_IP}" ] || \
     [ "x" = "x${VAGRANT_LOCAL_DOMAIN}" ]  || \
     [ "x" = "x${TTV_REP_URL}" ]  || \
     [ "x" = "x${GIT_DEFAULT_BRANCH}" ] 
  then
    cmn_exitAbnormal "Please configure your setting variables in '${BASE_DIR_SHORT}/config/constant.sh'"
  fi

  cmn_showTitleStep 'Create necessary folders'

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

  rm -rf "${SYNC_TRACKER}"
  mkdir -p "${SYNC_TRACKER}"
  touch "${SYNC_TRACKER}/.gitignore"

  # Make output folder (a temporary folder)
  mkdir -p "${BASE_DIR}/${OUTPUT_DIR}"
  touch "${BASE_DIR}/${OUTPUT_DIR}/.gitignore"
}
