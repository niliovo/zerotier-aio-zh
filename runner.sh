#!/bin/bash
#sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources
apt update -y
apt install curl gnupg2 ca-certificates gzip xz-utils iproute2 unzip net-tools procps wget --no-install-recommends -y
Ver=$(wget -qO- -t1 -T2 https://api.github.com/repos/just-containers/s6-overlay/releases/latest | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')

wget https://github.com/just-containers/s6-overlay/releases/download/$Ver/s6-overlay-noarch.tar.xz
#curl -L -O https://github.com/just-containers/s6-overlay/releases/download/$Ver/s6-overlay-noarch.tar.xz
#curl -L -O https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.2/s6-overlay-noarch.tar.xz
tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz && rm /tmp/s6-overlay-noarch.tar.xz

wget https://github.com/just-containers/s6-overlay/releases/download/$Ver/s6-overlay-$(uname -m).tar.xz
#curl -L -O https://github.com/just-containers/s6-overlay/releases/download/$Ver/s6-overlay-$(uname -m).tar.xz
#curl -L -O https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.2/s6-overlay-$(uname -m).tar.xz
tar -C / -Jxpf /tmp/s6-overlay-$(uname -m).tar.xz && rm /tmp/s6-overlay-$(uname -m).tar.xz
groupadd -g 2222 zerotier-one
useradd -u 2222 -g 2222 zerotier-one
usermod -aG zerotier-one zerotier-one
usermod -aG zerotier-one root
curl -sL -o zt-one.sh https://install.zerotier.com
bash zt-one.sh
rm -f zt-one.sh
apt clean -y
rm -rf /var/lib/zerotier-one
rm -rf /var/lib/apt/lists/*
