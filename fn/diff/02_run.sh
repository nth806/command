function diff_run () {
  comp_show_title_step 'Run diff'

  DIFF_FUNCTION=diff
  DIFF_MERGE=sgdm

  which ${DIFF_MERGE} 2> /dev/null 1> /dev/null
  if [ $? -eq 0 ] ; then
    DIFF_FUNCTION=$DIFF_MERGE
  fi

  $DIFF_FUNCTION "${TTV_SRC}/${FILE_DIFF_PATH}" "${CLIENT_DIR}/${FILE_DIFF_PATH}"
}
