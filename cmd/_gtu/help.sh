################################################################################
CMD_DESC="Help command"
################################################################################

function _run() {
  cd $BASE_DIR
  inc_helpComponent

  if [ "x${1}" != "x" ] && [ "${1}" != "help" ] && [ -f "${1}.sh" ]
  then
    CMD_NAME=${1}
    cpnt_help "${CMD_NAME}.sh"
    return $?
  fi

  if [ "x$ERROR_HELP" = "x" ] && [ "x${1}" != "x" ]
  then
    ERROR_HELP='There is no command `'${1}'`.'
  fi

  # Help content
  if [ "x$ERROR_HELP" != "x" ];
  then
    echo_errorParam "${ERROR_HELP}"
  fi

  cpnt_helpList order CMD_DESC
}