################################################################################
# Common function functions
################################################################################
# Check whether function (not command, alias)
function cmn_functionExists () {
  if [ "x" = "x${1}" ]
  then
    return 1
  fi

  local fn_name=${1}
  if [ -n "$(type -t ${fn_name})" ] && [ "$(type -t ${fn_name})" = function ]
  then
    return 0
  fi

  return 1
}

# Check whether command (not function, alias)
function cmn_commandExists () {
  if [ "x" = "x${1}" ]
  then
    return 1
  fi

  local fn_name=${1}
  if [ -n "$(type -t ${fn_name})" ]
  then
    if [ "$(type -t ${fn_name})" = "file" ] || [ "$(type -t ${fn_name})" = "builtin" ]
    then
      return 0
    fi
  fi

  return 1
}

# Check whether or not executed names (function, alias, command)
function cmn_bashExists () {
  if [ "x" = "x${1}" ]
  then
    return 1
  fi

  local fn_name=${1}
  if [ -n "$(type -t ${fn_name})" ]
  then
    return 0
  fi

  return 1
}
