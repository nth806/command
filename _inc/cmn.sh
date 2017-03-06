###########################################################
# Common function
###########################################################
function cmn_exitNormal () {
  echo -en '\033[1;32m'
  echo "Done"
  echo -en '\033[0m'
  exit 0
}

function cmn_exitAbnormal () {
  echo -en '\033[1;31m'
  echo "${1}"
  echo "Failed!"
  echo -en '\033[0m'
  exit 255
}

function cmn_showTitleStep () {
  ((CMN_COUNT+=1))
  echo_Green "["'****'" `cmn_padNumber ${CMN_COUNT} 2`. ${1} "'****'"]"
}

function cmn_confirmProcess () {
  echo_Yellow "${1}" -n
  local l_input
  read -p "  ${2}" l_input
  l_input=`cmn_toLower ${l_input}`

  if [ "xy" != "x${l_input}" ] && [ "xyes" != "x${l_input}" ]
  then
    return 1
  fi

  return 0
}

function cmn_confirm4Exit () {
  cmn_confirmProcess "${1}" "Would you like to continue processing (default: no) [yes|y]: "
  if [ $? -ne 0 ]
  then
    cmn_exitNormal
  fi
}

# String functions
###########################################################
function cmn_trimSlash () {
  echo $1 | sed 's:/*$::'
}

function cmn_trimSpaces () {
  echo "${1}" | sed 's,^ *,,; s, *$,,'
}

function cmn_rmLeadingSpaces () {
  echo "${1}" | sed 's,^ *,,'
}

function cmn_rmTrailingSpaces () {
  #local l_value="${1}"
  #l_value=${l_value%% }
  #echo "${l_value}"
  echo "${1}" | sed 's, *$,,'
}

function cmn_rmLeadingWith () {
  echo "${2}" | sed 's,^'"${1}"',,'
}

function cmn_rmTrailingWith () {
  echo "${2}" | sed 's,'"${1}"'$,,'
}

function cmn_escape4Sed () {
  echo $1 | sed  's/\//\\\//g'
}

function cmn_toLower () {
  echo "${1}" | tr '[:upper:]' '[:lower:]'
}

function cmn_toUpper () {
  echo "${1}" | tr '[:lower:]' '[:upper:]'
}

function cmn_isStartWith () {
  local haystack="${1}"
  local needle="${2}"

  if [ "x${haystack}" = "x" ] ; then
    return 1
  fi

  local len1=${#haystack}
  local len2=${#needle}

  if [ $len2 -lt $len1 ] ; then
    return 1
  fi

  local prefix=${needle:0:$len1}
  if [[ "x${prefix}" = "x${haystack}" ]]
  then
    return 0
  fi

  return 1
}

# Integer functions
###########################################################
function cmn_padNumber () {
  printf "%0${2}d\n" $1
}

# File functions
###########################################################
function cmn_replaceVariableInFile () {
  local variable=$1
  local value=${!variable}

  value=`cmn_escape4Sed ${value}`
  sed -i 's/{'${variable}'}/'"${value}"'/g' $2
}

function cmn_replaceVariableMultiLineInFile () {
  local variable=$1
  local value=${!variable}

  echo -e ${value} > tmp.txt
  sed -i '/{'${variable}'}/r tmp.txt' $2
  rm -rf tmp.txt
}

# Folder functions
###########################################################
# Get base name of file without extension
function cmn_mainBasename () {
  local s=$1
  s=${s##*/}
  echo ${s%.*}
}

function cmn_isEmptyFolder () {
  local fd=$1
  local rt=

  cmn_isStartWith '/' "${1}"
  if [ $? -ne 0 ]
  then
    fd="${BASE_DIR}/${1}"
  fi

  rt=`find "${fd}" -maxdepth 0 -empty -exec echo {} \;`
  if [ "x" = "x${rt}" ]
  then
    return 1
  fi

  return 0
}

# Function functions
###########################################################
# Check whether or not function (internal functions only)
function cmn_function_exists () {
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

# Check whether or not function including external function
function cmn_bash_exists () {
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
