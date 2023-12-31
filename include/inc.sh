################################################################################
# Include utilities
################################################################################

# Include help component
function inc_helpComponent() {
  local lc_script

  for lc_script in `find ${COMMAND_DIR}/component/help -type f -name '*.sh'`
  do
    . $lc_script
  done
}

# Show help content written on itself (unless this file)
function inc_itselfHelp() {
  inc_helpComponent
  cpnt_help "${BASH_SOURCE[1]}"

  exit
}

# Show help content written on a file (The first parameter)
function inc_fileHelp() {
  #if [ "x${2}" != 'x' ]
  #then
  #  echo_errorParam "${2}"
  #fi

  inc_helpComponent
  cpnt_help "${1}"

  exit
}