function init_env () {
  comp_show_title_step 'Initialize enviroment'
  rm -rf .git
  git init
  git remote add origin "${TTV_REP_URL}"

  git fetch origin
  if [ $? -ne 0 ] ; then
    cmn_exitAbnormal "Can not fetch remote [${TTV_REP_URL}]"
  fi

  rm -rf bin
  stt=`git branch -r | grep 'origin/master'`
  if [ "x${stt}" != "x" ] ; then
    cmn_exitAbnormal "Can not migrate because branch [master] has already existed on [${TTV_REP_URL}]"
  fi

  git add .
  git add --force ${OUTPUT_DIR}/.gitignore

  local submodule
  if [ "x${1}" = "x" ]; then
    submodule='git@gitlab.com:nth806/std_command.git'
  else
    submodule="${1}"
  fi
  git submodule add "${submodule}" bin

  git commit -m "Add initializing project"
  git push -u origin master
}
