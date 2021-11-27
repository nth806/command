#######
# Utility functions for all machine bashes

# Start SSH Agent
#----------------------------
SSH_ENV="$HOME/.ssh/environment"

function run_ssh_env() {
  . "${SSH_ENV}" > /dev/null
}

function start_ssh_agent {
  echo "Initializing new SSH agent..."
  ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo "succeeded"
  chmod 600 "${SSH_ENV}"

  run_ssh_env;

  ssh-add ~/.ssh/id_rsa;
}

if [ -f "${SSH_ENV}" ]
then
  run_ssh_env

  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_ssh_agent;
  }
else
  start_ssh_agent;
fi

##
# Set project directories for cd
##
function set_project_cd() {
  local count=0
  local posfix_name=
  local project dir subdir name subpath key

  if [ "x${CD_DEFAULT['ws']}" = 'x' ]
  then
    echo Worskspaces has not been set yet.
    return 1
  fi

  for project in "${PROJECT_LIST[@]}"
  do
    dir=${WORKSPACE}/$project
    if [ ! -d $dir ]; then
      echo There is no project $project, $dir directory doesn\'t exist!
      return 
    fi

    name=pj$posfix_name
    CD_DEFAULT[$name]=$dir

    ((count+=1))
    posfix_name=`echo $count`
  done
}
set_project_cd
unset -f set_project_cd

##
# List of projects set
##
function project_list() {
  [ -z ${PROJECT_LIST} ] && return

  local pj
  local i=0
  local idx=
  for pj in "${PROJECT_LIST[@]}"
  do
    [ $i -eq 0 ] && idx=' ' || idx=$i
    echo '  pj'$idx': '$pj
    i=$((i+1))
  done
}

##
# List of indexes of project
##
function project_indexes() {
  local i
  local idx
  for i in "${!PROJECT_INDEXES[@]}"
  do
    idx=`printf %8s ${i}`
    echo "  ${idx}: "${PROJECT_INDEXES[$i]}
  done
}

##
# Configure changing directory to default folders
##
function cd() {
  if [ "x$1" != "x" ] && [ -d "$1" ]; then
    command cd "$@"
    return
  fi


  if [ "x$2" != "x" ] && [ -d "$2" ]; then
    command cd "$@"
    return
  fi

  # CD configured folders
  if [ "x$1" != "x" ] && [ "x${CD_DEFAULT["$1"]}" != "x" ]; then
    command cd ${CD_DEFAULT["$1"]}
    return
  fi

  command cd "$@"
}

##
# List of indexes of project
##
function cd_aliases() {
  local i
  local idx
  for i in "${!CD_DEFAULT[@]}"
  do
    idx=`printf %8s ${i}`
    echo "  ${idx}: "${CD_DEFAULT[$i]}
  done
}
