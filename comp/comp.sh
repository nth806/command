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

  PRI_IFS=$IFS
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