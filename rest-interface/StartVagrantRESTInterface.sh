#!/bin/bash

check=$(netstat -an | grep 8080 | wc -l)
if [[ $check -eq 0 ]];then
    echo "rest-interface is not running..."
    java -Dgrails.env=prod -Dserver.port=8080 -jar /opt/rest-interface/bin/rest-interface-0.1.war &
else
    echo "rest-interface is running"
fi
