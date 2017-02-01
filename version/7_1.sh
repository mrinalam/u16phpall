#!/bin/bash -e

#Build PHP 7.1.1
echo "============ Building PHP 7.1 =============="
php-build -i development 7.1.1 $HOME/.phpenv/versions/7.1

# Setting phpenv to 7.1.1
echo "============ Setting phpenv to 7.1 ============"
phpenv rehash
phpenv global 7.1

cd /home/phpuser
# Install phpunit
echo "============ Installing PHPUnit ============="
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
mv phpunit.phar $HOME/.phpenv/versions/7.1/bin/phpunit

# Install Composer
echo "============ Installing Composer ============"
curl -s http://getcomposer.org/installer | php
chmod +x composer.phar
mv composer.phar $HOME/.phpenv/versions/7.1/bin/composer

#install pickle
cd /tmp/pickle
$HOME/.phpenv/versions/7.1/bin/composer install

cd /

