################################################################################
CMD_DESC="Show list of files is set assume unchanged"
#
#&This is alias of `echo_yellow "git ls-files -v | grep '^[[:lower:]]'" -ne`
################################################################################
function _run() {
  git ls-files -v | grep '^[[:lower:]]'
}