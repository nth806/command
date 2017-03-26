function fetch_run () {
  comp_show_title_step "Retrieve source from client repository"

  cd  ${CLIENT_DIR}
  git init
  git remote add origin ${CLIENT_REP_URL}
  git fetch origin
  git checkout master

  local sync_time=`comp_git_sync_time`
  local email=
  if [ "x${GIT_CLIENT_BRANCH}" = 'xmaster' ]; then
    cd  ${BASE_DIR}
    return
  fi

  if [ "x${sync_time}" != 'x' ]; then
    comp_get_email_list
    for email in `git log --pretty=format:'%ae' origin/${GIT_CLIENT_BRANCH} --since="${sync_time}"`
    do
      if [[ ! " ${EMAIL_LIST[@]} " =~ " ${email} " ]]; then
        cmn_exitAbnormal "There is a commit by <${email}> on remote repository. Please ask your leader how to solve this."
      fi
    done
  else
    git checkout "${GIT_CLIENT_BRANCH}"
  fi
  cd  ${BASE_DIR}
}
