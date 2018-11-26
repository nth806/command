# Ensure this script is call from 'pjr -'
if [ "x$WORK_DIR" = "x" ]; then
  echo "Please don't call this script directly. Call 'pjr -' instead!"
  exit
fi

# Initializing function
if [ -d cli ]
then
  for lc_script in `find cli -type f -name '*.sh'`
  do
    . $lc_script
  done
fi

# Run command
if [ "x$1" = "x" ]
then
  echo "Please set function for calling"
  cmn_exitNormal
fi

if ! cmn_isStartWith '-' ${1}
then
  if ! cmn_functionExists ${1}
  then
    cmn_exitAbnormal 'There is no user function `'"${1}"'`'
  fi

  CLI_NAME=${1}
  shift
  ${CLI_NAME} "$@"
  cmn_exitNormal
fi

# Build customized action