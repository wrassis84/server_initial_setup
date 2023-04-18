######## ENVIRONMENT ###########################################################

#!/usr/bin/env bash

######## ABOUT #################################################################

# Repository      : https://github.com/wrassis84/<REPO>
# Author          : William Ramos de Assis Rezende
# Maintainer      : William Ramos de Assis Rezende
#
# Deploy.sh       : Executes Ansible Playbooks to Deploy Servers.
# Requirements    : bash, ansible
# Usage           : ./Deploy.sh

######## TESTING ENVIRONMENT ###################################################

######## TESTS/VALIDATIONS #####################################################

######## VARIABLES #############################################################

######## FUNCTIONS #############################################################
CleanSSH () {
  for i in $(seq 0 2); do
    ssh-keygen -f "$HOME/.ssh/known_hosts"         \
               -R "192.168.0.23$i" > /dev/null 2>&1;
  done           
}
######## MAIN CODE - START #####################################################
echo "Configuring ansible environment..."
cd $PWD/ansible
source ansible.env > /dev/null

echo "Configuring ssh hosts..."
CleanSSH

echo "Playing setup_ubuntu.yml..."
ansible-playbook setup_ubuntu.yml -u sysadmin -b #> /dev/null

echo "Playing setup_docker.yml"
ansible-playbook setup_docker.yml -u sysadmin -b #> /dev/null
cd ../
######## MAIN CODE - END #######################################################
# TODO:
# Test if ansible is installed;
# Checks that servers are running and reachable;