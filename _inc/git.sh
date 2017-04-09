###########################################################
# Git function
###########################################################
function git_currentBranch () {
  local branch_name=$(git symbolic-ref -q HEAD)
  branch_name=${branch_name##refs/heads/}
  branch_name=${branch_name:-HEAD}

  echo ${branch_name}
}

function git_statusBranch () {
  local l_UPSTREAM='@{u}'
  local l_LOCAL=$(git rev-parse @)
  local l_REMOTE=$(git rev-parse "$l_UPSTREAM")
  local l_BASE=$(git merge-base @ "$l_UPSTREAM")

  if [ "x$l_LOCAL" = "x$l_REMOTE" ]; then
    # "Up-to-date"
    return 0
  elif [ "x$l_LOCAL" = "x$l_BASE" ]; then
    # Need to pull
    return 1
  elif [ "x$l_REMOTE" = "x$l_BASE" ]; then
    # Need to push
    return 2
  fi

  return -1
}

##
# This function will remove status of update files from the output line when use
# git commands
##
function git_removePrefixStatus () {
  local line="${1}"

  # Checking for added and modifided case
  if [[ $line =~ ^[A|M][[:space:]]{1,}[^[:space:]] ]]; then
    echo ${line:1}
    return
  fi

  # Checking for deleted case
  if [[ $line =~ ^D[[:space:]]{1,}[^[:space:]] ]]; then
    echo ${line:1}
    return 1
  fi

  # Checking for deleted case
  if [[ $line =~ ^R[[:digit:]]{1,}[[:space:]]{1,}[^[:space:]] ]]; then
    echo ${line#* }
    return 2
  fi

  echo $line
}
