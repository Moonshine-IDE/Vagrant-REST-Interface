#!/bin/bash

HTTP_GUEST_PORT=$1
ARTIFACT_NAME="rest-interface.jar"
APP_HOME_DIR=$2
HTTP_HOST_PORT=$3
EXTERNAL_CONFIG_FILE=$4

check=$(netstat -an | grep $HTTP_GUEST_PORT | wc -l)
if [[ $check -ne 0 ]];then
	printf "\nrest-interface is running, stopping..."
	pkill -9 -f $ARTIFACT_NAME
fi

cd $APP_HOME_DIR

printf "\n\nStarting rest-interface..."
java -Xmx1024m -Dgrails.env=prod -Dlogging.level.root=ERROR -Dserver.port=$HTTP_GUEST_PORT \
     -Dspring.config.location=classpath:application.yml,optional:file:$EXTERNAL_CONFIG_FILE \
     -jar bin/$ARTIFACT_NAME > log/output.log 2>&1 &

printf "\nrest-interface is starting at 127.0.0.1:$HTTP_HOST_PORT, it takes about 20 seconds to become ready..."
