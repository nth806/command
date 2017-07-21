if [ "x$STD_COMMAND_DIR" != "x" ]; then
  for lc_script in `find $STD_COMMAND_DIR -type f`
  do
    if [ -x "$lc_script" ]; then
      alias `basename $lc_script`=$lc_script
    fi
  done
fi