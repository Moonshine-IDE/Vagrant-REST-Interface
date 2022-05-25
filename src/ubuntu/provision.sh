#!/bin/bash

ARTIFACT_NAME="rest-interface.jar"
APP_HOME_DIR=$1

apt-get update

printf "\n\nInstalling Java...\n"
sudo add-apt-repository ppa:openjdk-r/ppa -y >/dev/null 2>&1
sudo apt-get update >/dev/null 2>&1
apt-get install -y openjdk-8-jdk >/dev/null 2>&1;

printf "\n\nJava has been installed"

mkdir -p $APP_HOME_DIR/bin
mkdir -p $APP_HOME_DIR/log
touch $APP_HOME_DIR/log/output.log
mv /home/vagrant/rest/$ARTIFACT_NAME $APP_HOME_DIR/bin/

chown -R vagrant:vagrant $APP_HOME_DIR
