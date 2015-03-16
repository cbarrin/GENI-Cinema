echo "Enter username:"
read USERNAME
echo $USERNAME > /home/$USERNAME/username


sudo apt-get install gcc
sudo apt-get install make
sudo apt-get update

sudo apt-get install vlc -y
sudo apt-get install libavcodec53 -y
sudo apt-get install libavcodec-dev -y
sudo apt-get install libavcodec-extra-53 -y

#install OVS
apt-get install pkg-config autoconf automake linux-libc-dev libtool libssl-devlinux-headers-`uname -r` -y
wget http://openvswitch.org/releases/openvswitch-2.3.0.tar.gz
tar -xvzf /home/$USERNAME/openvswitch-2.3.0.tar.gz
cd openvswitch-2.3.0
/home/$USERNAME/openvswitch-2.3.0/configure --with-linux=/lib/modules/`uname -r`/build
make
make install
make modules_install
insmod /home/$USERNAME/openvswitch-2.3.0/datapath/linux/openvswitch.ko
mkdir -p /usr/local/etc/openvswitch/
ovsdb-tool create /usr/local/etc/openvswitch/conf.db /home/$USERNAME/openvswitch-2.3.0/vswitchd/vswitch.ovsschema