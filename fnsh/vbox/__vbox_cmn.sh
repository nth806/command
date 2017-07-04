cmn_bashExists vboxmanage
if [ $? -ne 0 ]
then
  cmn_exitAbnormal "Vbox commands are not included on PATH environment"
fi