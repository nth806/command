function diff_run () {
  comp_show_title_step 'Run diff'

  local is_tool=1
  for i; do
    if [ "x${i}" = "x-t" ]; then
      is_tool=0
      break
    fi
  done

  if [ $is_tool -eq 0 ]; then
    which sgdm 2> /dev/null 1> /dev/null
    if [ $? -eq 0 ]; then
      sgdm "${TTV_SRC}/${FILE_DIFF_PATH}" "${CLIENT_DIR}/${FILE_DIFF_PATH}"
      return
    elif [ -x /Applications/DiffMerge.app/Contents/MacOS/DiffMerge ]; then
      /Applications/DiffMerge.app/Contents/MacOS/DiffMerge "${TTV_SRC}/${FILE_DIFF_PATH}" "${CLIENT_DIR}/${FILE_DIFF_PATH}"
      return
    fi
  fi

  diff $@ "${TTV_SRC}/${FILE_DIFF_PATH}" "${CLIENT_DIR}/${FILE_DIFF_PATH}"
}
