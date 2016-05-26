Problem
=========

In this project, we are trying to solve a problem in image processing over a distributed environment. We have built an application that calculates the average pixel intensity in images.We are using [INRIA image dataset](http://pascal.inrialpes.fr/data/human/) for this project. Each image comprises of pixels, which are described in three dimensional RGB color space. So each pixel has three components R-Red, G-Green and B-Blue. Each image in INRIA dataset contains `594 X 720`pixels. So to describe an image we need `594 X 720 X 3` data points for R, G and B. We focus on calculating the average pixel intensity as it is necessary for normalization of images. Normalization is a technique where we subtract average pixel intensity from all pixel in all images to bring images to same scale. It is usually observed that after normalization machine learning algorithms perform better and faster. So we choose average pixel intensity as metric for evaluating distributed system performance.


Software Stack
===============

      Image processing application
      Hipi Library
      Hadoop
      Virtual Machines


Prerequisite
===============

Please make sure the following steps are carried out before installation - 

1. You're able to ssh into the cloud: india-futuresystems or chameleon and join a project. 
2. ``module load openstack``
3. Make sure to start an ssh-agent so you don't need to retype you passphrase multiple times.
We've also noticied that if you are running on `india`, Ansible may be unable to access the node and complain with something like:

   ```
   master0 | UNREACHABLE! => {
       "changed": false,
       "msg": "ssh cc@129.114.110.126:22 : Private key file is encrypted\nTo connect as a different user, use -u <username>.",
       "unreachable": true
   }
   ```


   To start the agent:

   ```
   hru-d@i136 ~$ eval $(ssh-agent)
   hru-d@i136 ~$ ssh-add
   ```
4. Enable a virtual ennvironment (not necessary but recommended)

5. Make sure your public key is added to [github.com](https://github.com/settings/keys)

6. Download [BDS](https://github.com/futuresystems/big-data-stack) repository using `git clone --recursive`. **IMPORTANT**: make sure you specify the `--recursive` option otherwise you will get errors.

     ```
      git clone --recursive https://github.com/futuresystems/big-data-stack.git
     ```
     
7. Install the requirements using `pip install -r requirements.txt`

8. Configure the BDS as per the cloud that you are using. Edit `.cluster.py` to define the machines in the cluster.


     E.g. on Chameleon cloud, the following changes should be made:
     ```
     -	‘image’: CC-Ubuntu14.04
     -	‘create_floating_ip’: True
     ```
     
      NOTE: Also Change remote_user from ubuntu to cc in ansible.cfg for Chameleon clould

     
9. Clone this repository in the same home directory where you have cloned BDS

   ```
   git clone https://github.com/cloudmesh/ansible-cloudmesh-hipi.git
   ```

10. Change directory to ansible-cloudmesh-hipi/src

Installation
===============

1. Run command ``sh launch.sh`` and wait until completion. This will set up 3 Virtual Machines with Hadoop cluster as follows

   i.   Frontend node: Master node in hadoop cluster.
   
   ii.  Data nodes: Where hdfs exists.
   
   iii. Zookeeper nodes: Where zookeeper coordination service for distributed applications exists.
   
   iv.  Hadoopnodes nodes: Where hadoop is installed.
   
   v.   Resourcemanager nodes: Slaves in hadoop.

The IP address allocated to the nodes can be found in big-data-stack/inventory.txt or you can view the IPs using following commmand

   ```
   nova list | grep $USER-master0
   ```


2. This will also install gradle and hipi and build hipi module. The shell script calls an ansible playbook which is written in such a way that it takes care of maximum steps in itself and you don't have to run anything in separate. The ansible script will do the following changes in the frontend node.

      i.   Give root acess
      
      ii.  Install prerequsite for gradle.
      
      iii.  Install gradle.

      iv. Download and build hipi.
   
      v. Copy the project files from src folder to the frontend node.


3. Towards the end, please follow the following commands to execute our project on the deployed system -

   i. SSH into the frontend node 
      
      ```
         Eg: ssh -i ~/.ssh/id_rsa 129.114.110.90 -l hadoop
      ```
   ii. Execute build.sh which will 
   
   * download the data
   * distribute it to hadoop 
   * execute mapreduce
   * print out the average pixel intensity in the images.
   
      ```
       bash
       sh buildAndLaunch.sh
      ```

The shell script that you run would display the output on screen along with details about the mapreduce job.


License
===============

BSD

