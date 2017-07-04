###########################################################
# Help common function
###########################################################
function comp_help_command () {
  echo "${DESPATCH_SCRIPT}"' help <command>'
}

function comp_help_wrong_despatch () {
  echo
  echo 'For help command, please try:'
  echo -en '  '
  echo_blue "${DESPATCH_SCRIPT} help"
  echo
  exit 1;
}
