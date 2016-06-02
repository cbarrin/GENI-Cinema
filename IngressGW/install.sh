#!/usr/bin/env bash
#echo "Enter username:"
#read USERNAME
#echo $USERNAME > /users/$USERNAME/username

USERNAME="cbarrin"

sudo apt-get install gcc
sudo apt-get install make
sudo apt-get update

sudo apt-get install vlc -y
sudo apt-get install libavcodec53 -y
sudo apt-get install libavcodec-dev -y
sudo apt-get install libavcodec-extra-53 -y

#install OVS
sudo apt-get install pkg-config autoconf automake linux-libc-dev libtool libssl-devlinux-headers-`uname -r` -y
sudo wget http://openvswitch.org/releases/openvswitch-2.3.0.tar.gz
sudo tar -xvzf /users/${USERNAME}/openvswitch-2.3.0.tar.gz
cd openvswitch-2.3.0
sudo /users/${USERNAME}/openvswitch-2.3.0/boot.sh
sudo /users/${USERNAME}/openvswitch-2.3.0/configure --with-linux=/lib/modules/`uname -r`/build
sudo make
sudo make install
sudo make modules_install
sudo /sbin/modprobe openvswitch
sudo mkdir -p /usr/local/etc/openvswitch/
sudo ovsdb-tool create /usr/local/etc/openvswitch/conf.db /users/${USERNAME}/openvswitch-2.3.0/vswitchd/vswitch.ovsschema