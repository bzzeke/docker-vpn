#!/bin/sh
echo ": PSK \"${SHARED_SECRET}\"" > /etc/ipsec.secrets
sed -i "s/xxx_server_ip_xxx/${SERVER_IP}/g" /etc/ipsec.conf
sed -i "s/xxx_server2_ip_xxx/${SERVER2_IP}/g" /etc/ipsec.conf
sed -i 's,xxx_server2_subnet_xxx,'"$SERVER2_SUBNET", /etc/ipsec.conf

rm -f /var/run/starter.charon.pid

ipsec start --nofork


