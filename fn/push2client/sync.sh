function __add_email_list () {
  local line=`echo ${1} | sed -e 's/\r//g'`
  line=`cmn_trimSpaces "${line}"`

  cmn_isStartWith '#' ${line}
  if [ $? -eq 0 ] ; then
    return
  fi

  if [ "x${line}" = "x" ]; then
    return
  fi

  EMAIL_LIST+=("${line}")
}


function __verify_client_repo () {
  if [ 'x'`git_currentBranch` != 'x'"${GIT_DEFAULT_BRANCH}" ]
  then
    git checkout "${GIT_DEFAULT_BRANCH}"
    if [ $? -ne 0 ]
    then
      cmn_exitAbnormal 'Checking out branch <'${GIT_DEFAULT_BRANCH}'> (client repository) was failed, please check again'
    fi
  fi

  git fetch origin "${GIT_DEFAULT_BRANCH}"
  if [ $? -ne 0 ]
  then
    cmn_exitAbnormal 'Fetching <'${GIT_DEFAULT_BRANCH}'> (client repository) was failed, please check again'
  fi

  git_statusBranch
  local stt=$?
  if [ $stt -eq 0 ] ; then
    # Up to date
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
  local line=
  local email=
  EMAIL_LIST=()
  if [ ! -f "${EMAIL_FILE}" ] ; then
    cmn_exitAbnormal "Does not exist email file <${EMAIL_FILE:3}>"
  fi

  PRI_IFS=$IFS
  export IFS=$'\n'
  while read line; do
    __add_email_list "${line}"
  done < ${EMAIL_FILE}
  __add_email_list "${line}"
  export IFS=$PRI_IFS

  if [ ${#EMAIL_LIST[@]} -eq 0 ] ; then
    cmn_exitAbnormal 'Have not set email list yet'
  fi

  for email in `git log --pretty=format:'%ae' HEAD..origin/${GIT_DEFAULT_BRANCH}`
  do
    if [[ ! " ${EMAIL_LIST[@]} " =~ " ${email} " ]]; then
      cmn_exitAbnormal "There is a commit by <${email}> on remote repository. Please ask your leader how to solve this."
    fi
  done

  git pull origin "$GIT_DEFAULT_BRANCH"
}

function push2client_sync () {
  cmn_showTitleStep "Synchronize source"

  if [ 'x'`git_currentBranch` != 'x'"${GIT_TTV_DEFAULT_BRANCH}" ]
  then
    git checkout "${GIT_TTV_DEFAULT_BRANCH}"
    if [ $? -ne 0 ]
    then
      cmn_exitAbnormal 'Checking out branch <'"${GIT_TTV_DEFAULT_BRANCH}"'> was failed, please check again'
    fi
  fi

  git pull origin "${GIT_TTV_DEFAULT_BRANCH}"
  if [ $? -ne 0 ]
  then
    cmn_exitAbnormal 'Pulling '"${GIT_TTV_DEFAULT_BRANCH}"' source was failed, please check again'
  fi

  local lc_msg=`git stash`

  cd ${CLIENT_DIR}
  __verify_client_repo
  cd ${BASE_DIR}
}
