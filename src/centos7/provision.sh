#!/bin/bash

ARTIFACT_NAME="rest-interface.jar"
APP_HOME_DIR=$1

sudo yum -y -q install net-tools

# Check if java is installed and added to Path
which java > /dev/null 2>&1;
COMMAND_RESULT=$?

if [ -n "$JAVA_HOME" ] || [ $COMMAND_RESULT -eq 0 ];then
   printf "\nJava already installed\n"
else
    printf "\nInstalling Java...\n"
    sudo yum -y -q install java-1.8.0-openjdk-devel
    printf "\nJava has been installed\n"
fi

sudo mkdir -p $APP_HOME_DIR/bin
sudo mkdir $APP_HOME_DIR/log
sudo mkdir $APP_HOME_DIR/config
sudo touch $APP_HOME_DIR/log/output.log

sudo mv /home/vagrant/rest/$ARTIFACT_NAME $APP_HOME_DIR/bin/

# Add file for externalized configuration
sudo mv /home/vagrant/rest/application.yml $APP_HOME_DIR/config/

sudo chown -R vagrant:vagrant $APP_HOME_DIR
