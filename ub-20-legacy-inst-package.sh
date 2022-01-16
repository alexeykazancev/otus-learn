#!/bin/bash
echo "run upgrade";
echo "deb http://ru.archive.ubuntu.com/ubuntu focal main restricted universe multiverse" > /etc/apt/sources.list;
echo "deb http://ru.archive.ubuntu.com/ubuntu focal-updates main restricted universe multiverse" >> /etc/apt/sources.list;
echo "deb http://ru.archive.ubuntu.com/ubuntu focal-backports main restricted universe multiverse" >> /etc/apt/sources.list;
echo "deb http://security.ubuntu.com/ubuntu focal-security main restricted" >> /etc/apt/sources.list;
echo "deb http://security.ubuntu.com/ubuntu focal-security universe" >> /etc/apt/sources.list;
echo "deb http://security.ubuntu.com/ubuntu focal-security multiverse" >> /etc/apt/sources.list;
export http_proxy=http://192.168.152.9:3128;
apt-get update && apt-get -y upgrade;
echo "run dist-upgrade";
apt-get -y dist-upgrade;
echo "run pack inst";
apt-get -y install open-vm-tools rsync mc atop htop iotop sudo net-tools ntp ntpdate;
echo 'complite inst pack';

echo 'run sed for ntp';
/bin/sed -i ' s/pool*/#pool/g ' /etc/ntp.conf;
/bin/echo "server 192.168.152.1 prefer iburst" >> /etc/ntp.conf;
/usr/sbin/ntpdate -q 192.168.152.1;
/usr/sbin/ntpdate -s 192.168.152.1;
