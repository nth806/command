################################################################################
# Include utilities
################################################################################
function inc_helpComponent() {
  local lc_script

  for lc_script in `find ${COMMAND_DIR}/component/help -type f -name '*.sh'`
  do
    . $lc_script
  done

  if [ -f help.sh ]
  then
    . help.sh
  fi
}
