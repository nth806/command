################################################################################
# Echo functions
################################################################################
function echo_ok() {
  echo "OK"
}

function echo_ng() {
  echo "NG"
}

function echo_errorParam() {
  echo_red "${1}"
  echo '----------------'$'\n'
}
