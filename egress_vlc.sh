#!/bin/bash

echo "Enter number of vlc streams to start:"
read VLCNum

ip=`/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`

COUNTER=0
while [ $COUNTER -lt $VLCNum ]; do
if [ $COUNTER -lt 10 ]
then
num="00"$COUNTER
elif [ $COUNTER -lt 100 ]
then
num="0"$COUNTER
else    
num=$COUNTER
fi
quote="'"
end="#duplicate{dst=std{access="http",caching="200",mux="ts",dst=$ip:33$num}}"
#echo $end
command="cvlc udp://@10.10.2.3:32$num --sout "
#echo $command
end2=" &"
command2=$command$quote$end$quote$end2
#echo $command2
#$command2
echo $command2 > /users/qw/cmd.sh
sudo chmod 777 cmd.sh
./cmd.sh
let COUNTER=COUNTER+1 
done
