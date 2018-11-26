################################################################################
# Common file functions
################################################################################
function cmn_replaceVariableInFile () {
  local variable=$1
  local value=${!variable}

  value=`cmn_escape4Sed ${value}`
  sed -i -- 's/{'${variable}'}/'"${value}"'/g' $2
}

function cmn_replaceVariableMultiLineInFile () {
  local variable=$1
  local value=${!variable}

  echo -e ${value} > tmp.txt
  sed -i -- '/{'${variable}'}/r tmp.txt' $2
  rm -rf tmp.txt
}
