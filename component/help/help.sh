################################################################################
# Common help functionality
################################################################################

# Parse function or variable on description if any
function __process_function() {
  local line="${1}"
  local fn=`echo "${line}" | cut -d \@ -f 2`

  cmn_functionExists $fn
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

# Process every line of file to get description for a command
function __process_line() {
  local line=`cmn_trimSpaces "${1}"`

  # Start line
  if [ ${HELP_MSG_STT} -eq 3 ]
  then
    if [ "x${line:0:1}" != 'x#' ]
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

    HELP_SHORT_DESCRIPTION=${HELP_SHORT_DESCRIPTION}${line}$'\n'
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
      line=`__process_function "${line}"`
    fi
  fi

  HELP_LONG_DESCRIPTION=${HELP_LONG_DESCRIPTION}${line}$'\n'
}

# Main command
################################################################################
function cpnt_help() {
  HELP_SHORT_DESCRIPTION=
  HELP_LONG_DESCRIPTION=

  HELP_MSG_STT=3
  local line=
  export IFS=$'\n'
  while read line; do
    __process_line "${line}"

    # Check exit
    if [ ${HELP_MSG_STT} -eq 0 ]
    then
      break
    fi
  done < $1

  # Rollback bash settings
  export IFS=$PRI_IFS
  unset -f __process_line __process_function

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
}

##
# Show help with less
function cpnt_helpLess() {
  cpnt_help "$@" | less -r
}
