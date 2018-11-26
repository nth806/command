################################################################################
# Add indents before echoing
################################################################################
function echo_ind() {
  echo "${INDENT_SPACES}${1}"
}

function echo_2ind() {
  echo "${INDENT_SPACES}${INDENT_SPACES}${1}"
}

function echo_3ind() {
  echo "${INDENT_SPACES}${INDENT_SPACES}${INDENT_SPACES}${1}"
}

function echo_4ind() {
  echo "${INDENT_SPACES}${INDENT_SPACES}${INDENT_SPACES}${INDENT_SPACES}${1}"
}
