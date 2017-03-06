function __process_function () {
  local line="${1}"
  local fn=`echo "${line}" | cut -d \@ -f 2`

  cmn_function_exists $fn
  if [ $? -ne 0 ]; then
    echo "${line}"
    return
  fi

  local space=`echo "${line}" | cut -d \@ -f 1`
  local ol
  for ol in `${fn}`
  do
    echo "${space}${ol}"
  done
}

function __process_line () {
  local line=`cmn_rmTrailingSpaces "${1}"`

  if [ ${HELP_MSG_STT} -ne 0 ] ; then
    if [ "x${line:0:1}" != 'x#' ] ; then
      echo "No help for ${COMMAND_HELP}"
      exit
    fi

    HELP_MSG_STT=0
    return
  fi

  if [ "x${line:0:1}" != 'x#' ] || [ "x${line:0:2}" = 'x##' ]; then
    exit
  fi

  if [ "x${line:0:2}" = 'x#&' ]; then
    line=${line:2}
    line='echo "'"${line}"'"'
    eval "${line}"
    return 
  fi

  line=${line:2}
  if [[ x${line} =~ x[[:space:]]*\@[[:alnum:]_]*\@ ]]; then
    __process_function "${line}";
    return
  fi

  echo "${line}"
}

function help_show () {
  COMMAND_HELP_SCRIPT=`find ${BIN_DIR}/cmd -type f -name [[:digit:]][[:digit:]][[:digit:]]_${COMMAND_HELP}`

  if [ "x" = "x${COMMAND_HELP_SCRIPT}" ]
  then
    echo_Red "Not support command '${COMMAND_HELP}'"
    __help_wrong_despatch
  fi

  HELP_MSG_STT=1
  local line=
  PRI_IFS=$IFS
  export IFS=$'\n'
  while read line; do
    __process_line "${line}"
  done < ${COMMAND_HELP_SCRIPT}
  export IFS=$PRI_IFS
}
