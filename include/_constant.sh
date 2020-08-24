PRI_IFS=$IFS
INDENT_SPACES='  '
EXEC_NAME=`basename "$0"`

# COMMAND_DIR is declared in profile when start bash
if [ "x${COMMAND_DIR}" = "x" ]
then
  COMMAND_DIR=`cd "$(dirname "$(dirname "${BASH_SOURCE[0]}")")" >/dev/null && pwd`

  # Should not use below variable in common functions (cmn_)
  WORK_DIR=`pwd`
fi
