#######
# Utility functions

##
# Check memory used
##
function _free () {
  top -l 1 | head -n 10 | grep PhysMem | sed -e $'s/, /\\\n        /g';
}

##
# Configure changing directory to default folders
##
function cd () {
  if [ "x$1" != "x" ] && [ -d "$1" ]; then
    command cd "$@"
    return
  fi


  if [ "x$2" != "x" ] && [ -d "$2" ]; then
    command cd "$@"
    return
  fi

  # CD configured folders
  if [ "x$1" != "x" ] && [ "x${CD_DEFAULT["$1"]}" != "x" ]; then
    command cd ${CD_DEFAULT["$1"]}
    return
  fi
  
  command cd "$@"
}

##
# Change to hidden file
##
function change2Hidden () {
  if [ "x$1" == "x" ]; then
    echo "No file pattern inputted"
  fi
  
  for file in `find . -type f -name "${1}"`
  do
     mv "${file}" `dirname "${file}"`/.`basename "${file}"`
  done  
}

##
# Find process id by port
function getPidbyPort () {
  ##
  if [ "x$1" = "x" ]
  then
    #echo 'Please input port number!'
    exit 255
  fi

  cmn_isPositiveNumber $1
  if [ $? -gt 0 ]
  then
    #echo 'Please input port number which is positive integer!'
    exit 255
  fi

  PORT=$1

  TERM_OUT=`sudo lsof -i:${PORT} | grep '(LISTEN)'`

  if [ "x${TERM_OUT}" = "x" ]
  then
    #echo "Port: ${PORT} is not listened"
    exit 1
  fi

  #echo ${TERM_OUT}
  echo ${TERM_OUT} | cut -f2 -d" "
}