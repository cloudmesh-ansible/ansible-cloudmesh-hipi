#!/bin/bash

mypwd=$(pwd)

# STEP 1: Launch VM instances
cd "./../../big-data-stack/"
vcl boot -p openstack -P $USER-
echo "Waiting for VM to boot - 300s"
sleep 300s #for chameleon
ansible-playbook play-hadoop.yml

# STEP 3: Install gradle and hipi
ansible-playbook ./../ansible-cloudmesh-hipi/src/site.yaml -i inventory.txt

# STEP 4: Echo steps to follow
echo
echo "Follow the steps to deploy on system"
echo "ssh to front end node. You can find the front end nodes using nova list command or in big-data-stack/inventory.txt"
echo "ssh -i ~/.ssh/id_rsa <master0-ip-address> -l hadoop"
echo "bash"
echo "sh buildAndLaunch.sh"
cd ${mypwd}


