################################################################################
# Common help functionality
################################################################################
# Parse function or variable on description if any
function __cpnt_help_process_function() {
  local line="${1}"
  local fn=`echo "${line}" | cut -d \@ -f 2`

  if ! cmn_functionExists ${fn}
  then
    echo "${line}"
    return
  fi

  local ind=`echo "${line}" | cut -d \@ -f 1`
  local prs=`echo "${line}" | cut -d \@ -f 3`
  local cmd=`echo ${fn} ${prs}`
  local ret=`eval "${cmd}"`

  #if [[ "${ret: -1}" =~ $'\r' ]] || [[ "${ret: -1}" =~ $'\n' ]]
  #then
  #  ret=`echo "${ret}" | sed '$ d'`
  #fi

  echo_CMInd "${ret}" "${ind}"
}

# Process every line of file to get description for a command
function __cpnt_help_process_line() {
  local line=`cmn_trimSpaces "${1}"`

  # Start line
  if [ ${HELP_MSG_STT} -eq 3 ]
  then
    if [ "x${line:0:2}" = 'x#!' ]
    then
      return
    elif [ "x${line:0:1}" != 'x#' ]
    then
      HELP_MSG_STT=0
      return
    fi

    HELP_MSG_STT=2
    return
  fi

  # Get short description
  if [ ${HELP_MSG_STT} -eq 2 ]
  then
    # Check for end of short description: end by an empty line or empty comment
    # line
    if [ "x${line}" = 'x' ] || [ "x${line}" = 'x#' ]
    then
      HELP_MSG_STT=1
      return
    fi

    if [ "x${line:0:2}" = 'x##' ]
    then
      HELP_MSG_STT=0
      return
    fi

    # Remove '#' if any
    if [ "x${line:0:1}" = 'x#' ]
    then
      line=${line:2}
    fi

    if [[ x${line} =~ x[[:alnum:]_]*\= ]]
    then
      line=${line#*=}
      line=`cmn_trimWith '"' "$line"`
      line=`cmn_trimWith "'" "${line}"`
    fi

    HELP_SHORT_DESCRIPTION+=${line}$'\n'
    return
  fi

  # Check for end of long description
  if [ "x${line:0:1}" != 'x#' ] || [ "x${line:0:2}" = 'x##' ]
  then
    HELP_MSG_STT=0
    return
  fi

  # Get long description
  if [ "x${line:0:2}" = 'x#&' ]
  then
    # Parse function in the line
    line=${line:2}
    line='echo "'"${line}"'"'
    line=`eval "${line}"`
  else
    line=${line:2}
    if [[ x${line} =~ x[[:space:]]*\@[[:alnum:]_]*\@ ]]
    then
      # Get content from function
      line=`__cpnt_help_process_function "${line}"`
    fi
  fi

  HELP_LONG_DESCRIPTION+=${line}$'\n'
}

####
# Parse help content at a file top
function cpnt_help() {
  HELP_SHORT_DESCRIPTION=
  HELP_LONG_DESCRIPTION=

  HELP_MSG_STT=3
  local line=
  IFS=$'\n'
  while read line; do
    __cpnt_help_process_line "${line}"

    # Check exit
    if [ ${HELP_MSG_STT} -eq 0 ]
    then
      break
    fi
  done < "${1}"

  # Rollback bash settings
  IFS=$PRI_IFS
  unset -f __cpnt_help_process_line __cpnt_help_process_function

  # Show help
  if [ "x${HELP_SHORT_DESCRIPTION}" = "x" ]
  then
    echo 'No help'
    exit
  fi

  echo "${HELP_SHORT_DESCRIPTION}"
  if [ "x${HELP_LONG_DESCRIPTION}" != "x" ]
  then
    echo "${HELP_LONG_DESCRIPTION}"
  fi

  unset HELP_SHORT_DESCRIPTION HELP_LONG_DESCRIPTION
}

##
# Show help with less
function cpnt_helpLess() {
  cpnt_help "$@" | less -r
}

################################################################################
function __cpnt_helpList_showLine() {
  echo_yellow "`printf "%-11s" "${1}"`" -ne
  eval 'echo "$'${2}'"'
}

####
# Get help content from a list of files
#
# Parameters:
#   [1] File list contains variable (COMMAND_ARRAY) which storage commands
#     or folder which contains commands
#   [2] Name of variable which storages description.
##
function cpnt_helpList() {
  local dir="`pwd`"
  local name=
  local help=

  if [ -f "${1}" ]
  then
    # File contains command list
    . "${1}"
    cd "`dirname $1`"

    help+='Usage: '"${EXEC_NAME} <command> [<args>]"$'\n'
    help+=$'\n'
    help+='List of commands:'$'\n'

    for name in "${COMMAND_ARRAY[@]}"
    do
      . "${name}/run.sh"

      help+="${INDENT_SPACES}"`__cpnt_helpList_showLine ${name} ${2}`$'\n'
    done

    help+=$'\n'
    help+='For detailed usage of command, please type:'$'\n'
    help+="  ${EXEC_NAME} help <command>"$'\n'
  elif [ -d "${1}" ]
  then
    # Folder contains commands
    cd "${1}"

    for name in `find . -type f -name '*.sh'`
    do
      . "${name}"

      name=`basename "${name}"`
      name=${name%.sh}

      help+=`__cpnt_helpList_showLine ${name} ${2}`$'\n'
    done
  fi

  cd "${dir}"
  echo "${help}"
}
