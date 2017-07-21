###########################################################
# Echo functions
###########################################################
function echo_ok () {
  echo "OK"
}

function echo_ng () {
  echo "NG"
}

function echo_info () {
  echo "  ${1}"
}

function echo_red () {
  echo -en '\033[0;31m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_redBold () {
  echo -en '\033[1;31m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_green () {
  echo -en '\033[0;32m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_greenBold () {
  echo -en '\033[1;32m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_yellow () {
  echo -en '\033[0;33m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_yellowBold () {
  echo -en '\033[1;33m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_blue () {
  echo -en '\033[0;34m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_blueBold () {
  echo -en '\033[1;34m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_magenta () {
  echo -en '\033[0;34m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_magentaBold () {
  echo -en '\033[1;34m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_magenta () {
  echo -en '\033[0;35m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_magentaBold () {
  echo -en '\033[1;35m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_cyan () {
  echo -en '\033[0;36m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_cyanBold () {
  echo -en '\033[1;36m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_gray () {
  echo -en '\033[0;37m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_grayBold () {
  echo -en '\033[1;37m'
  echo $2 $1
  echo -en '\033[0m'
}
