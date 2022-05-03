#!/bin/bash

sudo yum clean all
sudo yum update
sudo yum -y -q install net-tools wget
sudo rm -rf /var/cache/yum/*

printf "\n\nInstalling Java...\n"
sudo yum -y -q install java-1.8.0-openjdk-devel

printf "\n\nJava has been installed"

sudo mkdir -p /opt/rest-interface/bin
sudo mkdir -p /opt/rest-interface/log
sudo chown -R vagrant:vagrant /opt/rest-interface
touch /opt/rest-interface/log/output.log
