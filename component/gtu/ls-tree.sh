################################################################################
CMD_DESC="Show file list of a commit"
#
#&This is alias of `echo_yellow "git ls-tree -r --name-only [commit_id]" -ne`
#&If commit_id isn't specified, the `echo_yellow HEAD -ne` will be got.
################################################################################
function _run() {
  if [ "x${2}" = "x" ]
  then
    git ls-tree -r --name-only HEAD
  else
    git ls-tree -r --name-only "${1}"
  fi
}
