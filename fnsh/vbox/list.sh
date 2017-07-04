function vbox_list () {
  if [ "x" = "x${1}" ]
  then
    echo_red "Please input name of the list which you want to check"
    exit 1;
  fi

  local list_type="${1}"
  local SUB_FUNCTION="_list_${1}"
  cmn_functionExists ${SUB_FUNCTION}
  if [ $? -ne 0 ]
  then
    echo_red "Not support checking list of ${list_type}"
    exit 1;
  fi

  ${SUB_FUNCTION}
}

function _list_vm () {
  PRI_IFS=$IFS
  export IFS=$'\n'
  local line
  for line in `vboxmanage list vms`
  do
    line=${line% *}
    line=${line#\"*}
    line=${line%\"*}
    echo -n "${line}: "
    vboxmanage showvminfo $line | grep '(since'
  done
  export IFS=$PRI_IFS
}