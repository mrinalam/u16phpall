#!/bin/bash -e

apt-get clean
mv /var/lib/apt/lists/* /tmp
mkdir -p /var/lib/apt/lists/partial
apt-get clean


# Install dependencies
echo "=========== Installing dependencies ============"
apt-get purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "`
add-apt-repository -y ppa:ondrej/php

apt-get update
apt-get install php5.6
apt-get install php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml

apt-get install -y git wget cmake libmcrypt-dev libreadline-dev libzmq-dev
apt-get install -y libxml2-dev     \
                libjpeg-dev     \
                libpng-dev      \
                libtidy-dev     \
                libxml2-dev     \
                libpcre3-dev    \
                libbz2-dev      \
                libcurl4-openssl-dev    \
                libminiupnpc-dev\
                libdb5.3-dev    \
                libpng12-dev    \
                libxpm-dev      \
                libfreetype6-dev        \
                libgd2-xpm-dev  \
                libgmp-dev      \
                libsasl2-dev    \
                libmhash-dev    \
                unixodbc-dev    \
                freetds-dev     \
                libpspell-dev   \
                libsnmp-dev     \
                libxslt1-dev    \
                libmcrypt-dev
                #libt1-dev       \
apt-get install -y php5.6-dev

#fixes for ubuntu 16.04. create soft links
ln -s /usr/include/tidy/tidybuffio.h /usr/include/tidy/buffio.h
ln -s /usr/include/tidy/tidyplatform.h /usr/include/tidy/platform.h


#install gosu
echo "================= Installing GoSu ==================="
/u16phpall/install_gosu.sh

#create a separate user for running php compose wihtout root
#needs gosu installed in the u16all base image
groupadd phpuser
useradd -g phpuser phpuser
chown -R phpuser /u16phpall/version
chown phpuser /u16phpall/_install.sh
mkdir /home/phpuser
chown -R phpuser /home/phpuser

#add php user to sudo group
usermod -aG sudo phpuser

#run remaining scripts by droppping root privileges as a phpuser
echo "================= Installing phpversions as phpuser ==================="
gosu phpuser /u16phpall/_install.sh

# Cleaning package lists
echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove
