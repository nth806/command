################################################################################
# Echo yellow color
################################################################################
function echo_yellow() {
  echo -en '\033[0;33m'
  echo $2 "${1}"
  echo -en '\033[0m'
}

function echo_yellowBold() {
  echo -en '\033[1;33m'
  echo $2 "${1}"
  echo -en '\033[0m'
}
