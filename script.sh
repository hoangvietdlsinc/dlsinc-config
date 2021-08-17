#!/bin/bash
sudo yum makecache
sudo yum update -y
sudo yum install epel-release -y
sudo yum install ansible -y
cp /vagrant/.vagrant/machines/webserver01/vmware_desktop/private_key /home/vagrant/webserver01_key && chmod 400 /home/vagrant/webserver01_key 
#cp /vagrant/.vagrant/machines/database01/vmware_desktop/private_key /home/vagrant/database01_key && chmod 400 /home/vagrant/database01_key 
chown vagrant:vagrant webserver01_key #&& chown vagrant:vagrant database01_key 
