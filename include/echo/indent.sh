################################################################################
# Add indents before echoing
################################################################################
function echo_Ind() {
  echo -e "${INDENT_SPACES}${1}"
}

function echo_2Ind() {
  echo -e "${INDENT_SPACES}${INDENT_SPACES}${1}"
}

function echo_3Ind() {
  echo -e "${INDENT_SPACES}${INDENT_SPACES}${INDENT_SPACES}${1}"
}

function echo_4Ind() {
  echo -e "${INDENT_SPACES}${INDENT_SPACES}${INDENT_SPACES}${INDENT_SPACES}${1}"
}

function echo_MInd() {
  echo -e "${1}" | sed 's/^/'"${INDENT_SPACES}"'/'
}

function echo_2MInd() {
  echo -e "${1}" | sed 's/^/'"${INDENT_SPACES}${INDENT_SPACES}"'/'
}

function echo_3MInd() {
  echo -e "${1}" | sed 's/^/'"${INDENT_SPACES}${INDENT_SPACES}${INDENT_SPACES}"'/'
}

function echo_4MInd() {
  echo -e "${1}" | sed 's/^/'"${INDENT_SPACES}${INDENT_SPACES}${INDENT_SPACES}${INDENT_SPACES}"'/'
}

# echo custom indent for multilines
function echo_CMInd() {
  echo -e "${1}" | sed 's/^/'"${2}"'/'
}