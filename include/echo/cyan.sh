################################################################################
# Echo cyan color
################################################################################
function echo_cyan() {
  echo -en '\033[0;36m'
  echo $2 "${1}"
  echo -en '\033[0m'
}

function echo_cyanBold() {
  echo -en '\033[1;36m'
  echo $2 "${1}"
  echo -en '\033[0m'
}
