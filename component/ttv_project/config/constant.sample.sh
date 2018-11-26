##############################################################################
# Configuration
##############################################################################
: '
Change depending on every project
Need to declare all of following variables
'

TOOL_VCS=git # git/svn
TOOL_ENV=vagrant # vagrant/docker/vagrant_docker

PROJECT_ID=test
TTV_REP_URL=git@gitlab.com:nth806/test.git
CLIENT_REP_URL=git@gitlab.com:nth806/std_source.git
VAGRANT_BOX_NAME=hello
VAGRANT_BOX_URL=tesat/hello
VAGRANT_GUESS_IP=192.168.8.10
VAGRANT_LOCAL_DOMAIN=test.lc
VAGRANT_SSH_PORT=22015

GIT_CLIENT_BRANCH=tmp
SYN_PATHS=

# Vagrant
VAGRANT_CHEF= # is true or not

# Docker


# CONSTANTS (Please don't change if you do not completely catch all of its effect)
CLIENT_DIR=client_repository
TTV_SRC=ttv_source
OUTPUT_DIR=output
