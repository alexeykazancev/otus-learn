#!/bin/bash
echo "run upgrade";
apt-get update && apt-get -y upgrade;
echo "run dist-upgrade";
apt-get -y dist-upgrade;
echo "run pack inst";
apt-get -y install open-vm-tools rsync mc atop htop iotop sudo net-tools ntp ntpdate;
echo 'complite inst pack';

echo 'run sed for ntp';
/usr/sbin/ntpdate -q 192.168.152.1;
/usr/sbin/ntpdate -s 192.168.152.1;
/bin/sed -i ' s/pool*/#pool/g ' /etc/ntp.conf;
/bin/echo "server 192.168.152.1 prefer iburst" >> /etc/ntp.conf;
/usr/bin/systemctl enable ntp && /etc/init.d/ntp restart;
echo 'complete tune ntp';
