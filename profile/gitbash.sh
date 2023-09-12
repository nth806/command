#######
# Utility functions for windows 10
. $COMMAND_DIR/profile/all_$SHELL_NAME

function lsPort() {
  netstat -ano | grep ":${1} " | grep -i LISTENING
}

##
# Find process id by port
function pidPort() {
  if [ "x$1" = "x" ]
  then
    echo 'Please input port number!'
    return 1
  fi

  local TERM_OUT=`netstat -ano | grep ":${1} " | grep -i 'LISTENING'`

  if [ "x${TERM_OUT}" = "x" ]
  then
    echo "Port $1 is not listened"
    return 1
  fi

  #echo ${TERM_OUT}
  echo ${TERM_OUT} | cut -f5 -d" "
}
