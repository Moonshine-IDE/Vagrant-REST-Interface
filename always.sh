#!/bin/bash

check=$(netstat -an | grep 8080 | wc -l)
if [[ $check -ne 0 ]];then
    echo "rest-interface is running, stopping..."
	pkill -9 -f rest-interface-0.1.war
fi

echo "Starting rest-interface..."
java -Dgrails.env=prod -Dserver.port=8080 -jar /opt/rest-interface/bin/rest-interface-0.1.war &
