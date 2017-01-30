#!/bin/bash -e

apt-get clean
mv /var/lib/apt/lists/* /tmp
mkdir -p /var/lib/apt/lists/partial
apt-get clean

#create a separate user for running php compose wihtout root
#needs gosu installed in the u16all base image
groupadd phpuser
useradd -g phpuser phpuser

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

# Install phpenv
echo "============ Installing phpenv ============="
git clone git://github.com/CHH/phpenv.git $HOME/phpenv
$HOME/phpenv/bin/phpenv-install.sh
echo 'export PATH=$HOME/.phpenv/bin:$PATH' >> $HOME/.bashrc
echo 'eval "$(phpenv init -)"' >> $HOME/.bashrc
rm -rf $HOME/phpenv

# Install php-build
echo "============ Installing php-build =============="
git clone git://github.com/php-build/php-build.git $HOME/php-build
$HOME/php-build/install.sh
rm -rf $HOME/php-build

# Activate phpenv
export PATH=$HOME/.phpenv/bin:$PATH
echo " 51 PATH=$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

#Download pickle
git clone https://github.com/FriendsOfPHP/pickle.git /tmp/pickle
ln -s /tmp/pickle/bin/pickle /usr/bin/

cd /
/u16phpall/version/5_4.sh

#for file in /u16phpall/version/*;
#do
#  . $file
#done

# Cleaning package lists
echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove
