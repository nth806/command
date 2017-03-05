function init_prepocess () {
  if [ "x" = "x${PROJECT_ID}" ] || \
     [ "x" = "x${CLIENT_REP_URL}" ] || \
     [ "x" = "x${VAGRANT_BOX_NAME}" ] || \
     [ "x" = "x${VAGRANT_BOX_URL}" ] || \
     [ "x" = "x${VAGRANT_GUESS_IP}" ] || \
     [ "x" = "x${VAGRANT_LOCAL_DOMAIN}" ]  || \
     [ "x" = "x${GIT_DEFAULT_BRANCH}" ] 
  then
    cmn_exitAbnormal "Please configure your setting variables in 'config/constant.sh'"
  fi

  cmn_showTitleStep "Create folders <${CLIENT_DIR}, ${TTV_SRC}, ${OUTPUT_DIR}>"
  if [ -d "${BASE_DIR}/${CLIENT_DIR}"  ] && [ -d "${BASE_DIR}/${TTV_SRC}"  ] && [ -d "${BASE_DIR}/${OUTPUT_DIR}" ]
  then
    cmn_confirm4Exit 'Folders have already been created!'
  else
    mkdir -p "${BASE_DIR}/${CLIENT_DIR}"
    mkdir -p "${BASE_DIR}/${TTV_SRC}"
    mkdir -p "${BASE_DIR}/${OUTPUT_DIR}"
  fi
}
