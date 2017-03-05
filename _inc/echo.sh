###########################################################
# Echo functions
###########################################################
function echo_OK () {
  echo "OK"
}

function echo_NG () {
  echo "NG"
}

function echo_info () {
  echo "  ${1}"
}

function echo_Red () {
  echo -en '\033[0;31m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_RedBold () {
  echo -en '\033[1;31m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_Green () {
  echo -en '\033[0;32m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_GreenBold () {
  echo -en '\033[1;32m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_Yellow () {
  echo -en '\033[0;33m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_YellowBold () {
  echo -en '\033[1;33m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_Blue () {
  echo -en '\033[0;34m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_BlueBold () {
  echo -en '\033[1;34m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_Magenta () {
  echo -en '\033[0;34m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_MagentaBold () {
  echo -en '\033[1;34m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_Magenta () {
  echo -en '\033[0;35m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_MagentaBold () {
  echo -en '\033[1;35m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_Cyan () {
  echo -en '\033[0;36m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_CyanBold () {
  echo -en '\033[1;36m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_Gray () {
  echo -en '\033[0;37m'
  echo $2 $1
  echo -en '\033[0m'
}

function echo_GrayBold () {
  echo -en '\033[1;37m'
  echo $2 $1
  echo -en '\033[0m'
}
