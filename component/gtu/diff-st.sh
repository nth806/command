################################################################################
CMD_DESC="Show different files (name-status) of a commit (from its parent) or between commits"
#
#&This is alias of `echo_yellow "git diff-tree -r --no-commit-id --name-status [commit_id] [commit_id_2] [<path>...]" -ne`
#&If commit_id isn't not specify, the `echo_yellow HEAD -ne` will be got.
################################################################################
function _run() {
  if [ "x${2}" = "x" ]
  then
    git diff-tree -r --no-commit-id --name-status HEAD
  else
    git ls-tree -r --no-commit-id --name-status "$@"
  fi
}
