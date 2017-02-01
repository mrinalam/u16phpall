#!/bin/bash -e

echo "============================ PHP Versions ==============================="
echo "phpenv versions"
export PHPUSER_HOME=/home/phpuser
$PHPUSER_HOME/.phpenv/bin/phpenv versions
printf "\n\n"

declare -a versions=('5.4' '5.5' '5.6' '7.0')

for version in "${versions[@]}"
  do
    export PATH=$PHPUSER_HOME/.phpenv/bin:$PHPUSER_HOME/.phpenv/extensions:$PATH;
    eval "$(phpenv init -)"

    echo "=============== Switching to version $version  ======================"
    echo "phpenv global $version"
    $PHPUSER_HOME/.phpenv/bin/phpenv global $version
    printf "\n"
    rm -rf ~/.composer && sudo ln -s ~/.phpenv/versions/$(phpenv version-name)/composer ~/.composer
    echo "======================== Checking version ==========================="
    echo "php --version"
    php --version
    printf "\n"
  done
