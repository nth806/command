function init_getsource () {
  cmn_showTitleStep 'Get source'

  cmn_isEmptyFolder ${CLIENT_DIR}
  if [ $? -eq 0 ]
  then
    cmn_echoInfo 'Clone client repository'
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
         cmn_exitAbnormal "Cant't checkout branch [${GIT_DEFAULT_BRANCH}]"
      fi
    fi
  else
    cmn_confirm4Exit "Client repository is not empty!"
  fi

  cd ${BASE_DIR}
  local is_cp=0
  cmn_isEmptyFolder ${TTV_SRC}
  if [ $? -ne 0 ]
  then
    cmn_confirmProcess 'TTV source is not empty!' 'Would you like to force to copy (default: no) [yes|y]: '
    if [ $? -ne 0 ]
    then
      is_cp=1
    fi
  fi

  if [ $is_cp -eq 0 ]
  then
    cmn_echoInfo 'Copy to ttv source'
    cp -rf ${CLIENT_DIR}/* ${TTV_SRC}/
  fi
}