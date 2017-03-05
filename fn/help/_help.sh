function help_help_command () {
  echo "${DESPATCH_SCRIPT}"' help <command>'
}

function help_help_list_command () {
  local script
  local cmd
  local is_start
  local line
  for script in `find ${BIN_DIR}/cmd -type f -name [[:digit:]][[:digit:]][[:digit:]]_[[:alnum:]_]*`
  do
    cmd=`basename ${script}`
    cmd=${cmd:4}
    is_start=2
    while read line;
    do
      line=`cmn_rmTrailingSpaces "${line}"`
      # First line '#...'
      if [ $is_start -eq 2 ]; then
        if [ "x${line:0:1}" != 'x#' ] ; then
          echo "${cmd}: --No help--"
          break
        fi

        is_start=1
        continue
      fi

      if [ $is_start -eq 1 ]; then
        is_start=0
        if [ "x${line:0:1}" != 'x#' ] ; then
          echo "${cmd}: --No help--"
          break
        fi

        line=${line:2}
        echo "${cmd}: ${line}"
        continue
      fi

      if [ "x${line:0:1}" != 'x#' ] || [ "x${line}" = 'x#' ] || [ "x${line:0:2}" = 'x##' ]; then
        break
      fi

      line=${line:2}
      echo "${line}"
    done < $script
  done
}
