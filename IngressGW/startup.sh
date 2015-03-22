#echo "OVS: Configuring OVS..."
#echo "OVS: Checking for kernel module..."
#if [ -e $(lsmod | grep openvswitch) ]
#then
#echo "OVS: ...inserting kernel module"
/sbin/modprobe openvswitch
#else
#echo "OVS: ...kernel module already present"
#fi

#echo "OVS: Creating database"
ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock \
--remote=db:Open_vSwitch,Open_vSwitch,manager_options \
--private-key=db:Open_vSwitch,SSL,private_key \
--certificate=db:Open_vSwitch,SSL,certificate \
--bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert \
--pidfile --detach
#echo "OVS: Initializing OVS..."
ovs-vsctl --no-wait init
#echo "OVS: Starting OVS..."
ovs-vswitchd --pidfile --detach
#if [ -n "$(ovs-vsctl show | grep br_OVS)" ]
#then
#echo "OVS: ...removing br_$IFACE1"
#ovs-vsctl del-br br_OVS
#fi

#echo "adding bridges"

ip = "$(ifconfig | grep -A 1 'eth1' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
sudo ifconfig eth1 0.0.0.0

ovs-vsctl add-br br_OVS

echo "adding ports for br_eth1"
#ovs-vsctl add-port br_OVS eth1

ovs-vsctl add-br br_v3724 br_OVS 3724
ovs-vsctl add-port br_OVS vlan3724 tag=3724


#sudo ifconfig eth1 $ip
#route add -net 10.0.0.0 netmask 255.255.255.0 dev eth1

ovs-vsctl set bridge br_OVS other-config:datapath-id=0000000000000011

ovs-vsctl set-fail-mode br_OVS secure