#######
# Utility functions for all machine bashes

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