Problem
=========

In this project, we are trying to solve a problem of image processing over a distributed environment. We have built an application that calculates the average pixel intensity in images that could be useful in normalization of images which is computationally intensive. 


We are using [INRIA image dataset](http://pascal.inrialpes.fr/data/human/) for this project. Each image comprises of pixels, which are described in three dimensional RGB color space. So each pixel has three components R-Red, G-Green and B-Blue. Each image in INRIA dataset contains `594 X 720`pixels. So to describe an image we need `594 X 720 X 3` data points for R, G and B. We focus on calculating the average pixel intensity as it is necessary for normalization of images. Normalization is a technique where we subtract average pixel intensity from all pixel in all images to bring images to same scale. It is usually observed that after normalization machine learning algorithms perform better and faster. So we choose average pixel intensity as metric for evaluating distributed system performance.

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
     
* Configure the BDS as per the cloud that you are using. Please follow the [link](https://github.com/futuresystems/class-admin-tools/blob/master/chameleon/big-data-stack.org>) to configure BDS for Chameleon
* ``git clone https://github.com/cloudmesh/ansible-cloudmesh-hipi.git`` in the same home directory
* cd into ansible-cloudmesh-hipi/src

Installation
===============

* run ``sh launch.sh`` and wait until completion. This will set up 3 VMs with Hadoop cluster. This will also install gradle and hipi and build hipi module. The shell script is taking care of an ansible playbook which is written in such a way that it takes care of maximum steps in itself and you don't have to run anything in separate . Towards the end, please follow the following commands to execute our project on the deployed system - ::

    Please do following:
    ssh -i ~/.ssh/id_rsa <master0-ip-address> -l hadoop
    bash
    sh buildAndLaunch.sh

  To find ``<master0-ip-address>``, use ``nova list`` command or find it in big-data-stack/inventory.txt.
 
* The shell script that you run would display the output on screen along with details about the mapreduce job.
NOTE: Please make sure that the floating ip is set to TRUE and execute on chameleon since it is tested to be running on it but Future systems had issues running the same.


License
===============

BSD

