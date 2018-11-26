################################################################################
# Common action functions
################################################################################
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

function cmn_confirmProcess () {
  echo_yellow "${1}" -n
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
  if ! cmn_confirmProcess "${1}" "Would you like to continue processing (default: no) [yes|y]: "
  then
    cmn_exitNormal
  fi
}
