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
  if [ "x${1}" != 'x' ]
  then
    echo_red "$1"
    echo '----------------'$'\n'
  fi

  inc_helpComponent
  cpnt_help "${BASH_SOURCE[1]}"

  exit
}
