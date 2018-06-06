#!/bin/sh

sysctl net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -m policy --dir out --pol ipsec -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE

echo ": PSK \"${VPN_SHARED_SECRET}\"" > /etc/ipsec.secrets
sed -i "s/xxx_server_ip_xxx/${VPN_SERVER_IP}/g" /etc/ipsec.conf
sed -i "s/xxx_server2_ip_xxx/${VPN_SERVER2_IP}/g" /etc/ipsec.conf
sed -i 's,xxx_server2_subnet_xxx,'"$VPN_SERVER2_SUBNET", /etc/ipsec.conf
sed -i 's,xxx_rw_id_xxx,'"$VPN_RW_ID", /etc/ipsec.conf

rm -f /var/run/starter.charon.pid

ipsec start --nofork


