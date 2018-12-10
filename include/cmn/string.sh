################################################################################
# Commong string functions
################################################################################
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

function cmn_trimWith () {
  local tmp=`cmn_rmLeadingWith "$1" "$2"`
  cmn_rmTrailingWith "$1" "$tmp"
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

function cmn_numMatch() {
  local ret=0
  printf -v ret '%d\n' `echo "${2}" | awk -F"${1}" '{print NF-1}'` 2> /dev/null

  return $ret
}
