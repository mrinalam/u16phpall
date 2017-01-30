#!/bin/bash -e

sudo apt-get clean
sudo mv /var/lib/apt/lists/* /tmp
sudo mkdir -p /var/lib/apt/lists/partial
sudo apt-get clean

# Install dependencies
echo "=========== Installing dependencies ============"
apt-get update
apt-get install -y git wget cmake libmcrypt-dev libreadline-dev libzmq-dev
apt-get install libxml2-dev     \
                libjpeg-dev     \
                libpng-dev      \
                libtidy-dev     \
                libxml2-dev     \
                libpcre3-dev    \
                libbz2-dev      \
                libcurl4-openssl-dev    \
                libminiupnpc-dev\
                libdb5.1-dev    \
                libpng12-dev    \
                libxpm-dev      \
                libfreetype6-dev        \
                libt1-dev       \
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
apt-get install php5-dev

# Install libmemcached
echo "========== Installing libmemcached =========="
wget https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz
tar xzf libmemcached-1.0.18.tar.gz && cd libmemcached-1.0.18
./configure --enable-sasl
make && make install
cd .. && rm -fr libmemcached-1.0.18*

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

# Install librabbitmq
echo "============ Installing librabbitmq ============"
cd /tmp && wget https://github.com/alanxz/rabbitmq-c/releases/download/v0.7.1/rabbitmq-c-0.7.1.tar.gz
tar xzf rabbitmq-c-0.7.1.tar.gz
mkdir build && cd build
cmake /tmp/rabbitmq-c-0.7.1
cmake -DCMAKE_INSTALL_PREFIX=/usr/local /tmp/rabbitmq-c-0.7.1
cmake --build . --target install
cd /tmp/rabbitmq-c-0.7.1
autoreconf -i
./configure
make
make install
cd /

for file in /u14phpall/version/*;
do
  . $file
done

# Cleaning package lists
echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove
