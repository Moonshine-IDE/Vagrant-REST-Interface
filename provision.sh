#!/bin/bash

sudo yum clean all
sudo yum update
sudo yum -y -q install net-tools wget
sudo rm -rf /var/cache/yum/*

printf "\n\n\nInstalling Java...\n"
sudo yum -y -q install java-1.8.0-openjdk-devel

sudo mkdir -p /opt/rest-interface/bin

echo 'Java has been installed'

sudo mkdir -p /var/log/rest-interface
sudo touch /var/log/rest-interface/output.log
sudo chmod 777 /var/log/rest-interface/output.log

# Add cron job to monitor and start rest-interface
# This is currently disabled.
# (crontab -l ; echo "* * * * * /opt/rest-interface/StartVagrantRESTInterface.sh >> /var/log/rest-interface/output.log") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -