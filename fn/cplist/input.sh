function cplist_input () {
  cmn_showTitleStep "Input list of files or directories"

  echo "###############################################################################" > ${FILELIST_PATH}
  echo "# We are using vi for inputting list of files or directories" >> ${FILELIST_PATH}
  echo "#" >> ${FILELIST_PATH}
  echo "# Sequentially input line by line for files or directories following" >> ${FILELIST_PATH}
  echo "#   explanation." >> ${FILELIST_PATH}
  echo "###############################################################################" >> ${FILELIST_PATH}
  echo >> ${FILELIST_PATH}
  vi + -c 'startinsert' ${FILELIST_PATH}

}