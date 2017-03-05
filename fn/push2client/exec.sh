function __process_line_msg () {
  local line=`cmn_rmTrailingSpaces "${1}"`

  if [ ${MSG_STT} -ne 0 ] ; then
    if [ "x${line}" = "x" ]; then
      return
    fi

    if [ "x${line:0:1}" = 'x#' ] ; then
      return
    fi

    CI_MSG=${line}
    MSG_STT=0
    return
  fi

  CI_MSG="${CI_MSG}"$'\n'"${line}"
}

function push2client_exec () {
  cmn_showTitleStep 'Push source to client repository'
  cd $CLIENT_DIR
  echo_Yellow "Please comfirm status before commiting:"
  echo 'START ----------------'
  echo
  git status
  echo 'END ------------------'
  echo

  echo "###############################################################################" > ${INPUT_TMP}
  echo "# We are using vi for inputting commit message." >> ${INPUT_TMP}
  echo "#" >> ${INPUT_TMP}
  echo "# Please input your commit message" >> ${INPUT_TMP}
  echo "#   Or let empty if you would like to commit manually." >> ${INPUT_TMP}
  echo "###############################################################################" >> ${INPUT_TMP}
  echo >> ${INPUT_TMP}
  vi + -c 'startinsert' ${INPUT_TMP}

  CI_MSG=
  MSG_STT=1
  local line=
  PRI_IFS=$IFS
  export IFS=$'\n'
  while read line; do
    __process_line_msg "${line}"
  done < ${INPUT_TMP}
  if [ 'x'`cmn_trimSpaces "${line}"` != 'x' ] ; then
    __process_line_msg "${line}"
  fi
  export IFS=$PRI_IFS

  if [ "x${CI_MSG}" = "x" ]
  then
    echo_Yellow "Please commit manually"
    cmn_exitNormal
  fi

  git commit -m "${CI_MSG}"

  cmn_confirm4Exit "Branch which is push to be <${GIT_DEFAULT_BRANCH}>"
  git push origin "${GIT_DEFAULT_BRANCH}"
  cd "${BASE_DIR}"
}
