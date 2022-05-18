#!/bin/bash

ARTIFACT_NAME="rest-interface.jar"
APP_HOME_DIR=$1

yum clean all
yum update
yum -y -q install net-tools
rm -rf /var/cache/yum/*

printf "\n\nInstalling Java...\n"
yum -y -q install java-1.8.0-openjdk-devel

printf "\n\nJava has been installed"

mkdir -p $APP_HOME_DIR/bin
mkdir -p $APP_HOME_DIR/log
touch $APP_HOME_DIR/log/output.log
mv /home/vagrant/rest/$ARTIFACT_NAME $APP_HOME_DIR/bin/

chown -R vagrant:vagrant $APP_HOME_DIR
