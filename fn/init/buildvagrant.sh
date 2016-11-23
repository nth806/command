function init_buildvagrant () {
  cmn_showTitleStep 'Build README.md and VagrantFile'

  local path=README.md
  local vagrant_file=vagrant/Vagrantfile
  local PRI_IFS=

  cmn_replaceVariableInFile VAGRANT_BOX_URL "${path}"
  cmn_replaceVariableInFile VAGRANT_BOX_NAME "${path}"
  cmn_replaceVariableInFile VAGRANT_GUESS_IP "${path}"
  cmn_replaceVariableInFile VAGRANT_LOCAL_DOMAIN "${path}"

  cmn_replaceVariableInFile PROJECT_ID "${vagrant_file}"
  cmn_replaceVariableInFile VAGRANT_BOX_URL "${vagrant_file}"
  cmn_replaceVariableInFile VAGRANT_BOX_NAME "${vagrant_file}"
  cmn_replaceVariableInFile VAGRANT_GUESS_IP "${vagrant_file}"
  cmn_replaceVariableInFile VAGRANT_SSH_PORT "${vagrant_file}"
  cmn_replaceVariableInFile TTV_SRC "${vagrant_file}"

  VAGRANT_CHEF=`cmn_toLower ${VAGRANT_CHEF}`
  if [ "xtrue" = "x${VAGRANT_CHEF}" ]
  then

    PRI_IFS=$
    IFS=$'\n'
    read -r -d '' VAGRANT_CHEF << EOM
### Install chef
※ Do this test if you have not done it in your system yet
#### Install ruby
* http://rubyinstaller.org/

#### Install chef-DK\n
* https://downloads.chef.io/chef-dk/

#### Install chef-solo with chef-DK
* Run command
    \`\`\`
    \$ chef gem install knife-solo knife-zero
    \`\`\`
EOM

    IFS=$PRI_IFS
    cmn_replaceVariableMultiLineInFile VAGRANT_CHEF "${path}"

    mkdir -p vagrant/site-cookbooks
    PRI_IFS=$
    IFS=$'\n'
    read -r -d '' VAGRANT_PROVISION << EOM
  # for chef (knife-solo)
  config.omnibus.chef_version = :latest
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "./site-cookbooks"
    chef.run_list = [ ]
  end
EOM

   IFS=$PRI_IFS
  else

    touch vagrant/provision.sh
    PRI_IFS=$
    IFS=$'\n'
    read -r -d '' VAGRANT_PROVISION << EOM
  config.vm.provision :shell, path: "provision.sh"
EOM

    IFS=$PRI_IFS
  fi

  VAGRANT_CHEF=
  cmn_replaceVariableInFile VAGRANT_CHEF "${path}"

  cmn_replaceVariableMultiLineInFile VAGRANT_PROVISION "${vagrant_file}"
  VAGRANT_PROVISION=
  cmn_replaceVariableInFile VAGRANT_PROVISION "${vagrant_file}"
}