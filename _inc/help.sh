###########################################################
# Help common function
###########################################################
function help_command () {
  echo "${DESPATCH_SCRIPT}"' help <command>'
}

function help_wrong_despatch () {
  echo
  echo 'For help command, please try:'
  echo -en '  '
  echo_Blue "${DESPATCH_SCRIPT} help"
  echo
  exit 1;
}
