#!/bin/bash

echo "============ In _install.sh. Installing as php user ============="
# Install phpenv
echo "============ Installing phpenv ============="
echo "home for phpuser: $HOME"
echo "============================================"

cd /home/phpuser

git clone git://github.com/CHH/phpenv.git $HOME/phpenv
$HOME/phpenv/bin/phpenv-install.sh
echo 'export PATH=$PHPENV_PATH/.phpenv/bin:$PATH' >> $HOME/.bashrc
echo 'eval "$(phpenv init -)"' >> $HOME/.bashrc
rm -rf $HOME/phpenv

# Install php-build
echo "============ Installing php-build =============="
git clone git://github.com/php-build/php-build.git $HOME/php-build
sudo $HOME/php-build/install.sh
rm -rf $HOME/php-build

# Activate phpenv
export PATH=$HOME/.phpenv/bin:$PATH
echo " 51 PATH=$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

#Download pickle
git clone https://github.com/FriendsOfPHP/pickle.git /tmp/pickle
sudo ln -s /tmp/pickle/bin/pickle /usr/bin/

cd /
/u16phpall/version/5_4.sh

#for file in /u16phpall/version/*;
#do
#  . $file
#done

