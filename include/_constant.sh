PRI_IFS=$IFS
INDENT_SPACES='  '

if [ "x${COMMAND_DIR}" = "x" ]
then
  COMMAND_DIR=`cd "$(dirname "$(dirname "${BASH_SOURCE[0]}")")" >/dev/null && pwd`
fi
