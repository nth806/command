function push2client_sync () {
  cmn_showTitleStep "Synchronize source"

  if [ 'x'`git_currentBranch` != 'xmaster' ]
  then
    git checkout master
    if [ $? -ne 0 ]
    then
      cmn_exitAbnormal 'Checking out branch <master> was failed, please check again'
    fi
  fi

  git pull origin master
  if [ $? -ne 0 ]
  then
    cmn_exitAbnormal 'Pulling master source was failed, please check again'
  fi

  cd ${CLIENT_DIR}
  if [ 'x'`git_currentBranch` != 'x'"${GIT_DEFAULT_BRANCH}" ]
  then
    git checkout master
    if [ $? -ne 0 ]
    then
      cmn_exitAbnormal 'Checking out branch <${GIT_DEFAULT_BRANCH}> (client repository) was failed, please check again'
    fi
  fi

  cd ${BASE_DIR}
}