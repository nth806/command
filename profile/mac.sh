#######
# Utility functions for MAC-OS
. "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/all.sh

##
# Check memory used
##
function ramFree () {
  top -l 1 | head -n 10 | grep PhysMem | sed -e $'s/, /\\\n        /g';
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
    echo 'Please input port number!'
    return 255
  fi

  cmn_isPositiveNumber $1
  if [ $? -gt 0 ]
  then
    echo 'Please input port number which is positive integer!'
    return 255
  fi

  PORT=$1

  TERM_OUT=`sudo lsof -i:${PORT} | grep '(LISTEN)'`

  if [ "x${TERM_OUT}" = "x" ]
  then
    echo "Port ${PORT} is not listened"
    return 1
  fi

  #echo ${TERM_OUT}
  echo ${TERM_OUT} | cut -f2 -d" "
}