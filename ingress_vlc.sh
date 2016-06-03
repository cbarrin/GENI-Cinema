#!/bin/bash

echo "Enter number of vlc streams to start:"
read VLCNum

#echo "Enter the name of the streaming image (this doesn't matter if not first ingress):"
#read image
image="GENI-Cinema-Logo.jpg"

ip=`/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`

COUNTER=0
if [ -f /users/qw/$image ]
then
cmd1="cvlc --demux="Image" --image-duration=-1 $image -vvv --sout "
quote="'"
end="#transcode{vcodec=MJPG,vb=1024,width=800,height=600}:duplicate{dst=std{access="udp",mux="ts",caching="300",dst=10.10.2.3:32000}}"
end2=" --sout-transcode-height=600 --sout-transcode-width=800 --sout-transcode-maxheight=600 --sout-transcode-maxwidth=800 &"
cmd2=$cmd1$quote$end$quote$end2
echo $cmd2 > /users/qw/cmd.sh
sudo chmod 777 /users/qw/cmd.sh
#echo $cmd2
./cmd.sh
let COUNTER=COUNTER+1
let VLCNum=VLCNum+1
fi


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
if [ $COUNTER -eq 3 ]
then
echo "cvlc --loop /users/qw/GECSports.mp4 --sout '#transcode{vcodec=mp4v,vb=1024,ab=128,fps=20,vfilter=canvas{width=800,height=600,aspect=4:3}}:duplicate{dst=std{access=udp,caching="300",mux="ts",dst=10.10.2.3:32$num}}"
./cmd.sh
elif [ $COUNTER -eq 4 ]
then
echo "cvlc --loop /users/qw/GECSports_v2.mp4 --sout '#transcode{vcodec=mp4v,vb=1024,ab=128,fps=20,vfilter=canvas{width=800,height=600,aspect=4:3}}:duplicate{dst=std{access=udp,caching="300",mux="ts",dst=10.10.2.3:32$num}}"
./cmd.sh
else
cmd1="cvlc -I dummy udp://@:31$num --sout "
quote="'"
end="#transcode{vcodec=mp4v,vb=2048,ab=128,fps=20,vfilter=canvas{width=800,height=600,aspect=4:3}}:duplicate{dst=std{access="udp",caching="300",mux="ts",dst=10.10.2.3:32$num}}"
end2=" &"
cmd2=$cmd1$quote$end$quote$end2
echo $cmd2 > /users/qw/cmd.sh
sudo chmod 777 /users/qw/cmd.sh
./cmd.sh
fi
let COUNTER=COUNTER+1 
done
