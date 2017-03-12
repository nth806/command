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