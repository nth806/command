################################################################################
# Echo blue color
################################################################################
function echo_blue() {
  echo -en '\033[0;34m'
  echo $2 "${1}"
  echo -en '\033[0m'
}

function echo_blueBold() {
  echo -en '\033[1;34m'
  echo $2 "${1}"
  echo -en '\033[0m'
}
