#!/bin/bash
PID=$(ps -ef|grep sshutt|grep dorigo_a|awk '{print $2}')
#echo $PID
/bin/kill $PID
sshuttle -D -v -r dorigo_a@g 192.168.71.0/24 192.168.1.0/24 192.168.9.0/24
