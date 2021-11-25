################################################################################
CMD_DESC="Show different files (name-only) of a commit (from its parent) or between commits"
#
#&This is alias of `echo_yellow "git diff-tree -r --no-commit-id --name-only [commit_id] [commit_id_2] [<path>...]" -ne`
#&If commit_id isn't not specify, the `echo_yellow HEAD -ne` will be got.
################################################################################
function _run() {
  if [ "x${1}" = "x" ]
  then
    git diff-tree -r --no-commit-id --name-only HEAD~ HEAD
  else
    local commitBase="${1}~"
    local commitCheck="${1}"
    if [ "x${2}" != "x" ]
    then
      commitBase="${1}"
      commitCheck="${2}"
    fi
    git diff-tree -r --no-commit-id --name-only "${commitBase}" "${commitCheck}"
  fi
}
