function __comp_add_email_list () {
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

function comp_get_email_list () {
  local line=
  EMAIL_LIST=()
  if [ ! -f "${EMAIL_LIST_FILE}" ] ; then
    cmn_exitAbnormal "Does not exist email file <${EMAIL_LIST_FILE}>"
  fi

  export IFS=$'\n'
  while read line; do
    __comp_add_email_list "${line}"
  done < ${EMAIL_LIST_FILE}
  __comp_add_email_list "${line}"
  export IFS=$PRI_IFS

  if [ ${#EMAIL_LIST[@]} -eq 0 ] ; then
    cmn_exitAbnormal 'Have not set email list yet'
  fi
}

function comp_show_title_step () {
  ((CMN_COUNT+=1))
  echo_green "["'****'" `cmn_padNumber ${CMN_COUNT} 2`. ${1} "'****'"]"
}

function comp_check_config () {
  if [ ! -f 'config/constant.sh' ]; then
    cmn_exitAbnormal "There is no configuration file 'config/constant.sh'"
  fi

  if [ "x" = "x${PROJECT_ID}" ] || \
     [ "x" = "x${CLIENT_REP_URL}" ] || \
     [ "x" = "x${VAGRANT_BOX_NAME}" ] || \
     [ "x" = "x${VAGRANT_GUESS_IP}" ] || \
     [ "x" = "x${VAGRANT_LOCAL_DOMAIN}" ]  || \
     [ "x" = "x${TTV_REP_URL}" ]
  then
    cmn_exitAbnormal "Please configure your setting variables in 'config/constant.sh'"
  fi

  if [ ! "x${TOOL_VCS}" = "xgit" ]; then
    return
  fi

  if [ "x" = "x${GIT_CLIENT_BRANCH}" ]; then
    cmn_exitAbnormal "Please set value for GIT_CLIENT_BRANCH in 'config/constant.sh'"
  fi
}

function comp_input_list () {
  echo "###############################################################################" > ${FILELIST_PATH}
  echo "# We are using vi for inputting list of files or directories" >> ${FILELIST_PATH}
  echo "#" >> ${FILELIST_PATH}
  echo "# Sequentially input line by line for files or directories following" >> ${FILELIST_PATH}
  echo "#   explanation." >> ${FILELIST_PATH}
  echo "###############################################################################" >> ${FILELIST_PATH}
  echo >> ${FILELIST_PATH}
  vi + -c 'startinsert' ${FILELIST_PATH}
}
