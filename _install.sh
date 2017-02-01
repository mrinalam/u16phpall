#!/bin/bash -e 

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

# Activate phpenv
export PATH=$HOME/.phpenv/bin:$PATH
echo " 51 PATH=$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

cd /

for file in /u16phpall/version/*.sh;
do
  . $file
done

