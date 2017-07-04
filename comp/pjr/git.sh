function comp_git_sync_time () {
  local sync_time
  if [ -f "${SYNC_TRACKER_DIR}/${GIT_CLIENT_BRANCH}" ]; then
    sync_time=`cat "${SYNC_TRACKER_DIR}/${GIT_CLIENT_BRANCH}" | egrep '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}( [+|-]?\d{4})?$'`
  fi
  echo "${sync_time}"
}

function comp_git_verify_client_repo () {
  cd ${CLIENT_DIR}

  if [ 'x'`git_currentBranch` != 'x'"${GIT_CLIENT_BRANCH}" ]
  then
    git checkout "${GIT_CLIENT_BRANCH}"
    if [ $? -ne 0 ]
    then
      cmn_exitAbnormal 'Checking out branch <'${GIT_CLIENT_BRANCH}'> (client repository) was failed, please check again'
    fi
  fi

  git fetch origin "${GIT_CLIENT_BRANCH}"
  if [ $? -ne 0 ]
  then
    cmn_exitAbnormal 'Fetching <'${GIT_CLIENT_BRANCH}'> (client repository) was failed, please check again'
  fi

  git_statusBranch
  local stt=$?
  if [ $stt -eq 0 ] ; then
    # Up to date
    cd ${BASE_DIR}
    return 0
  fi

  if [ $stt -eq 2 ] ; then
    # Go ahead remote branch
    cmn_exitAbnormal 'You need to push souce to client repository before continuing'
  fi

  if [ $stt -ne 1 ] ; then
    cmn_exitAbnormal 'Your local repository is deverged'
  fi

  # Email
  comp_get_email_list

  local sync_time=`comp_git_sync_time`
  sync_time=${sync_time:-1970-01-01 00:00:00 +0000}
  local email=
  for email in `git log --pretty=format:'%ae' HEAD..origin/${GIT_CLIENT_BRANCH} --since="${sync_time}"`
  do
    if [[ ! " ${EMAIL_LIST[@]} " =~ " ${email} " ]]; then
      cmn_exitAbnormal "There is a commit by <${email}> on remote repository. Please ask your leader how to solve this."
    fi
  done

  git pull origin "$GIT_CLIENT_BRANCH"
  cd ${BASE_DIR}
}
