################################################################################
# Common folder functions
################################################################################
# Get base name of file without extension
function cmn_mainBasename () {
  local s=$1
  s=${s##*/}
  echo ${s%.*}
}

function cmn_isEmptyFolder () {
  local fd=$1
  local rt=

  if ! cmn_isStartWith '/' "${1}"
  then
    if [ "x${WORK_DIR}" != "x" ]
    then
      fd="${WORK_DIR}/${1}"
    fi
  fi

  rt=`find "${fd}" -maxdepth 0 -empty -exec echo {} \;`
  if [ "x" = "x${rt}" ]
  then
    return 1
  fi

  return 0
}
