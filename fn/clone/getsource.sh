function clone_getsource () {
  cmn_showTitleStep 'Get source'

  echo_info 'Clone client repository'
  git clone ${CLIENT_REP_URL} ${CLIENT_DIR}
  if [ $? -ne 0 ]
  then
    cmn_exitAbnormal "Clone client source failed"
  fi
  cd ${CLIENT_DIR}
  local cur_branch=`git_currentBranch`
  if [ "x${GIT_DEFAULT_BRANCH}" != "x${cur_branch}" ]
  then
    git checkout "${GIT_DEFAULT_BRANCH}"
    if [ $? -ne 0 ]
    then
       cmn_exitAbnormal "Cann't checkout branch [${GIT_DEFAULT_BRANCH}]"
    fi
  fi

  cd ${BASE_DIR}
  echo_info 'Copy client-source to ttv-source'
  if [ "x${SYN_PATHS}" = "x" ]; then
    cp -rf ${CLIENT_DIR}/* ${TTV_SRC}/
    return
  fi

  local ARR_SYN_PATHS
  local SYN_PATH
  IFS=',;:' read -r -a ARR_SYN_PATHS <<< "${SYN_PATHS}"
  for SYN_PATH in "${ARR_SYN_PATHS[@]}"
  do
    SYN_PATH=`cmn_trimSpaces "${SYN_PATH}"`
    # SYN_PATH=`echo ${SYN_PATH}`
    if [ "x${SYN_PATH}" = "x" ]; then
      echo_yellow "There is empty path on SYN_PATH"
      continue
    fi

    if [ ! -d "${CLIENT_DIR}/${SYN_PATH}" ]; then
      continue
    fi

    echo_info "  Copy folder ${SYN_PATH}"
    mkdir -p "${TTV_SRC}/${SYN_PATH}"
    cp -rf ${CLIENT_DIR}/${SYN_PATH}/* ${TTV_SRC}/${SYN_PATH}/
  done
}
