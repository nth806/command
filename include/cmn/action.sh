################################################################################
# Common action functions
################################################################################
function cmn_exitNormal () {
  echo -en '\033[1;32m'
  [ "x${1}" = "x" ] && echo "Done" || echo "${1}"
  echo -en '\033[0m'
  exit 0
}

function cmn_exitAbnormal () {
  echo -en '\033[1;31m'
  [ "x${1}" != "x" ] &&  echo "${1}"
  echo "Failed!"
  echo -en '\033[0m'
  exit 255
}

function cmn_confirmProcess () {
  if [ "x${2}" != "x" ]
  then
    echo_yellow "${2} "
  fi

  read -p "${1} " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    return 0
  fi

  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    return 2
  fi

  return 1
}

function cmn_confirm4Exit () {
  if ! cmn_confirmProcess "Would you like to continue processing (default: no) [yes|y]: " "${1}"
  then
    cmn_exitNormal
  fi
}
