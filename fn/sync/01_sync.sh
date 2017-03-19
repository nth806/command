function sync_sync () {
  cmn_showTitleStep "Synchronize source"

  if [ 'x'`git_currentBranch` != 'x'"${GIT_TTV_BRANCH}" ]
  then
    git checkout "${GIT_TTV_BRANCH}"
    if [ $? -ne 0 ]
    then
      cmn_exitAbnormal 'Checking out branch <'"${GIT_TTV_BRANCH}"'> was failed, please check again'
    fi
  fi

  git pull origin "${GIT_TTV_BRANCH}"
  if [ $? -ne 0 ]
  then
    cmn_exitAbnormal 'Pulling '"${GIT_TTV_BRANCH}"' source was failed, please check again'
  fi

  local lc_msg=`git stash -u`

  comp_git_verify_client_repo
}
