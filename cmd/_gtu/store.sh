################################################################################
CMD_DESC="Store/Restore to .git/tmp/gtu/store files modified(edited/added) of last commit"
#
#&`echo_green "${EXEC_NAME} ${CMD_NAME} <commit>" -ne` Store modified files
#&`echo_green "${EXEC_NAME} ${CMD_NAME} ls|list" -ne` Show storaged files list.
#&`echo_green "${EXEC_NAME} ${CMD_NAME} apply" -ne` Apply stored files
#&`echo_green "${EXEC_NAME} ${CMD_NAME} clear" -ne` Delete stored files
#
#&Add argument `echo_green "-a" -ne` to set not to confirm for every file.
#&Add argument `echo_green "-p" -ne` to set store permanent folder
################################################################################
_STORE_TMP_DIR=.git/tmp/gtu/store
_STORE_CONFIRM=0
_STORE_COMMAND=

####
 # $1: file path
 # $2: source directory
 # $3: destination directory
 ####
function _copyFile()
{
  if [ ! -f ${1} ]
  then
    # Git file deleted
    return
  fi

  local ldir=`dirname $1`
  if [ $_STORE_CONFIRM -eq 0 ]
  then
    cmn_confirmProcess "Are you sure to ${_STORE_COMMAND} file ${1}? (Y):OK (N):exit (*):continue"
    l_status=$?
    if [ $l_status -ne 0 ]
    then
      if [ $l_status -eq 2 ]
      then
        exit
      fi

      return
    fi
  fi

  if [ ! -d "${3}/${ldir}" ]
  then
    mkdir -p "${3}/${ldir}"
  fi

  cp -f "${2}/${1}" "${3}/${1}"
}

function _run() {
  if [ ! -d $_STORE_TMP_DIR ]
  then
    mkdir -p $_STORE_TMP_DIR
  fi

  if [ "x${1}" = "xclear" ]
  then
    cmn_isEmptyFolder $_STORE_TMP_DIR
    if [ $? -ne 0 ]
    then
      if ! cmn_confirmProcess "Are you sure to wish to clear storaged files? (Y/n)"
      then
        return
      fi

      rm -rf $_STORE_TMP_DIR
      mkdir -p $_STORE_TMP_DIR
      cmn_exitNormal 'Cleared storaged files successfully.'
    fi

    cmn_exitNormal 'The storage is empty.'
  fi
  
  if [ "x${1}" = "xls" ] || [ "x${1}" = "xlist" ]
  then
    cd $_STORE_TMP_DIR
    for lfile in `find . -type f`
    do
      cmn_trimWith './' "${lfile}"
    done

    exit
  fi

  if [ "x${1}" = "x-a" ]
  then
    _STORE_CONFIRM=1
    shift
  fi

  local lfile=
  if [ "x${1}" = "xapply" ]
  then
    shift
    if [ "x${1}" = "x-a" ]
    then
      _STORE_CONFIRM=1
      shift
    fi

    _STORE_COMMAND=apply
    cmn_isEmptyFolder $_STORE_TMP_DIR
    if [ $? -eq 0 ]
    then
      cmn_exitAbnormal 'The storage is empty.'
    fi

    cd $_STORE_TMP_DIR
    for lfile in `find . -type f`
    do
      lfile=`cmn_trimWith './' "${lfile}"`
      _copyFile $lfile . "${WORK_DIR}"
    done

    cmn_exitNormal 'Apply storaged files successfully.'
  fi

  local lcommit='HEAD'
  _STORE_COMMAND=store
  cmn_isEmptyFolder $_STORE_TMP_DIR
  if [ $? -ne 0 ]
  then
    if ! cmn_confirmProcess "The storage is not empty, do you wish to clear it? (Y/n)"
    then
      return
    fi

    rm -rf $_STORE_TMP_DIR
    mkdir -p $_STORE_TMP_DIR
  fi

  if [ "x${1}" != "x" ]
  then
    lcommit=$1
  fi

  for lfile in `git diff-tree --no-commit-id --name-only -r ${lcommit}~ ${lcommit}`
  do
    if [ "x${lfile}" == "x" ]
    then
      continue
    fi

    _copyFile $lfile . "${_STORE_TMP_DIR}"
  done
}
