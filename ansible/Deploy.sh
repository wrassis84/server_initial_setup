######## ENVIRONMENT ###########################################################

#!/usr/bin/env bash

######## ABOUT #################################################################

# Repository      : https://github.com/wrassis84/<REPO>
# Author          : William Ramos de Assis Rezende
# Maintainer      : William Ramos de Assis Rezende
#
# Deploy.sh       : Executes Ansible Playbooks to Deploy Servers.
# Requirements    : bash, ansible
# Usage           : DataTex.sh [ list | add | remove ]

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
echo "Configuring environment..."
cd ../ && source .env && cd - > /dev/null

echo "Configuring ssh hosts..."
CleanSSH

echo "Playing setup_ubuntu.yaml..."
ansible-playbook setup_ubuntu.yaml -u sysadmin -b #> /dev/null

echo "Playing setup_docker.yaml"
ansible-playbook setup_docker.yaml -u sysadmin -b #> /dev/null
######## MAIN CODE - END #######################################################
# TODO:
# Test if ansible is installed;
# Checks that servers are running and reachable;