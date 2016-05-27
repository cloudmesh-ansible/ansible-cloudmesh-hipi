Cloudmesh Ansible Hipi
=========================

This role is not yet operational.

Requirements
------------

* Account on a cloud

* [Gradle](http://gradle.org/) for building project


Dependencies
------------

* [BDS](https://github.com/futuresystems/big-data-stack) for setting up 
cluster and installing hadoop

* [JavaCV](https://github.com/bytedeco/javacv)



Prerequisite
===============

Please make sure the following steps are carried out before installation 


1. You're able to ssh into the cloud: india-futuresystems or chameleon 
and join a project. 
2. Load open stack module

      ```
      module load openstack
      ```
      
3. Make sure to start an ssh-agent so you don't need to retype you 
passphrase multiple times.
We've also noticied that if you are running on `india`, Ansible may be 
unable to access the node and complain with something like:

   ```
   master0 | UNREACHABLE! => {
       "changed": false,
       "msg": "ssh cc@129.114.110.126:22 : Private key file is 
encrypted\nTo connect as a different user, use -u <username>.",
       "unreachable": true
   }
   ```

   To start the agent:

   ```
   hru-d@i136 ~$ eval $(ssh-agent)
   hru-d@i136 ~$ ssh-add
   ```
4. Enable a virtual ennvironment (not necessary but recommended)

5. Make sure your public key is added to 
[github.com](https://github.com/settings/keys)

6. Download [BDS](https://github.com/futuresystems/big-data-stack) 
repository using `git clone --recursive`. **IMPORTANT**: make sure you 
specify the `--recursive` option otherwise you will get errors.

     ```
      git clone --recursive 
https://github.com/futuresystems/big-data-stack.git
     ```
     
7. Install the requirements using 

      ```
      cd big-data-stack
      pip install -r requirements.txt
      ```

8. Configure the BDS as per the cloud that you are using. Edit 
`.cluster.py` to define the machines in the cluster.


     E.g. on Chameleon cloud, the following changes should be made:
     ```
     -	‘image’: CC-Ubuntu14.04
     -	‘create_floating_ip’: True
     ```
     
      NOTE: Also Change remote_user from ubuntu to cc in ansible.cfg for 
Chameleon clould

     
9. Clone this repository in the same home directory where you have 
cloned BDS

   ```
   git clone https://github.com/cloudmesh/ansible-cloudmesh-hipi.git
   ```


Example Playbook
----------------

1. Start a number of virtual machines with big-data-stack 

      i. Change directory to big-data-stack 

            cd big-data-stack/

            
      ii. Boot Virtual Machines
      
            vcl boot -p openstack -P $USER-

      iii. Wait atleast 300s for virtual machines to boot
      
2. Install Hadoop n the virtual machines
      
      ```
      ansible-playbook play-hadoop.yml
      ```

3. Install gradle and hipi

      ```
      ansible-playbook ./../ansible-cloudmesh-hipi/tasks/main.yml -i inventory.txt
      ```
List the inventory
      ```
      cat inventory.txt
      ```
or you can view the IPs using following commmand

      ```
      nova list | grep $USER
      ```

4. For frontend node ip do

      i. SSH into the frontend node

      ```
      Eg: ssh -i ~/.ssh/id_rsa 129.114.110.90 -l hadoop
      ```
     
      ii. Execute buildAndLaunch.sh which will 
      
      * download the data
      * distribute it to hadoop 
      * execute mapreduce
      * print out the average pixel intensity in the images.
      
      ```
       bash
       sh buildAndLaunch.sh
      ```

The shell script that you run would display the output on screen 
along with details about the mapreduce job.



License
-------

Apache 2.0


Author Information
------------------

Hrushikesh Dhumal (hrushikesh.dhumal@gmail.com)
