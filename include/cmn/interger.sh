################################################################################
# Common integer functions
################################################################################
function cmn_padNumber () {
  printf "%0${2}d\n" $1
}

function cmn_isPositiveNumber () {
  if ! [[ $1 =~ ^[0-9]*$ ]] || ! [ $1 -gt 0 ]
  then
    return 1 
  fi

  return 0
}
