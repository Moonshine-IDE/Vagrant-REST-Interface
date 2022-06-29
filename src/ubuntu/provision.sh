#!/bin/bash

ARTIFACT_NAME="rest-interface.jar"
APP_HOME_DIR=$1

sudo apt install -y -q net-tools

which java > /dev/null 2>&1;
COMMAND_RESULT=$?

if [ -n "$JAVA_HOME" ] || [ $COMMAND_RESULT -eq 0 ];then
   printf "\n\nJava already installed\n"
else
   printf "\n\nInstalling Java...\n"
   sudo add-apt-repository ppa:openjdk-r/ppa -y >/dev/null 2>&1
   sudo apt-get update >/dev/null 2>&1
   sudo apt-get install -y openjdk-8-jdk >/dev/null 2>&1;
   
   printf "\nJava has been installed"
fi

sudo mkdir -p $APP_HOME_DIR/bin
sudo mkdir $APP_HOME_DIR/log
sudo mkdir $APP_HOME_DIR/config
sudo touch $APP_HOME_DIR/log/output.log

sudo mv /home/vagrant/rest/$ARTIFACT_NAME $APP_HOME_DIR/bin/

# Add file for externalized configuration
sudo mv /home/vagrant/rest/application.yml $APP_HOME_DIR/config/

sudo chown -R vagrant:vagrant $APP_HOME_DIR
