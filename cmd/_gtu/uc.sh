################################################################################
CMD_DESC="Set/unset assume unchange of file"
#
#&This is alias of `echo_yellow "git update-index --assume-unchanged|--no-assume-unchanged <file>" -ne`
#
#&`echo_green "${EXEC_NAME} ${CMD_NAME} [-n] <file>" -ne`
#&  If `echo_green "[-n]" -ne`, set `echo_green "no-assume-unchanged" -ne`, otherwise, set `echo_green "assume-unchanged" -ne`
################################################################################
function _run() {
  if [ "x${1}" = "x-n" ]
  then
    git update-index --no-assume-unchanged "${2}"
  else
    git update-index --assume-unchanged "${1}"
  fi
}
