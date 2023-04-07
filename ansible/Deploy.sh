######## ENVIRONMENT ###########################################################

#!/usr/bin/env bash

######## ABOUT #################################################################

# Repository      : https://github.com/wrassis84/<REPO>
# Author          : William Ramos de Assis Rezende
# Maintainer      : William Ramos de Assis Rezende
#
# DataTex.sh      : List, Add and Remove users from DataTex systems.
# Requirements    : LibTex.sh
# Usage           : DataTex.sh [ list | add | remove ]

######## TESTING ENVIRONMENT ###################################################

######## TESTS/VALIDATIONS #####################################################

######## VARIABLES #############################################################

######## FUNCTIONS #############################################################
clean_ssh () {
  for i in $(seq 0 2); do
    ssh-keygen -f '/home/william/.ssh/known_hosts' \
               -R '192.168.0.23$i' > /dev/null 2>&1;
  done           
}
######## MAIN CODE - START #####################################################
#echo "Configuring environment..."
#source ../../.env
echo "Configuring ssh hosts..."
clean_ssh
echo "Playing setup_ubuntu.yaml..."
ansible-playbook setup_ubuntu.yaml -u sysadmin -b > /dev/null
echo "Playing setup_docker.yaml"
ansible-playbook setup_docker.yaml -u sysadmin -b > /dev/null
######## MAIN CODE - END #######################################################