#######
# Utility functions for all machine bashes

##
# Set project directories for cd
##
function set_project_cd() {
  local count=0
  local posfix_name=
  local project dir subdir name subpath key
  declare -A subpath_list
  subpath_list['rp']=repo
  subpath_list['fr']=front
  subpath_list['api']=api
  subpath_list['app']=app
  subpath_list['po']=portal

  if [ "x${CD_DEFAULT['ws']}" = 'x' ]
  then
    echo Worskspaces has not been set yet.
    return 1
  fi

  for project in "${PROJECT_LIST[@]}"
  do
    dir=${CD_DEFAULT["ws"]}/$project
    if [ ! -d $dir ]; then
      echo There is no project $project, $dir directory doesn\'t exist!
      return 
    fi

    name=pj$posfix_name
    CD_DEFAULT[$name]=$dir

    for key in "${!subpath_list[@]}"
    do
      name=$key$posfix_name
      subdir=$dir/${subpath_list[$key]}
      if [ -d $subdir ]; then
        CD_DEFAULT[$name]=$subdir
      fi
    done

    ((count+=1))
    posfix_name=`echo $count`
  done
}

##
# Configure changing directory to default folders
##
function cd () {
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