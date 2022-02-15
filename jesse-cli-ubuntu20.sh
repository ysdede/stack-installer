#!/usr/bin/env bash

start=`date +%s`

echo "updating ubuntu ..."
sudo apt-get -y update

# python 3.x extensions
echo "installing Python 3.x extensions ..."
sudo apt-get -y install gcc binutils
sudo apt-get -y install software-properties-common
sudo apt-get -y install python3-dev python3-pip python3-setuptools python3-testresources python-is-python3
sudo apt-get -y install build-essential
sudo apt-get -y install byobu

pip install --upgrade setuptools wheel
pip install ez_setup
pip install Cython numpy

# talib
echo "installing talib ... (you should have more then 1Gb free of ram)"
sudo apt-get -y install libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev
wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz -q
tar -xzf ta-lib-0.4.0-src.tar.gz
cd ta-lib/
./configure --prefix=/usr
make
sudo make install

# install pip packages for jesse
echo "installing jesse ..."
pip install -r https://raw.githubusercontent.com/ysdede/jesse/cache%2Byakirsim/requirements.txt -v
pip install git+https://github.com/ysdede/jesse.git@cache+yakirsim#egg=jesse -v

pip install -r https://raw.githubusercontent.com/ysdede/jesse-tk/master/requirements.txt
pip install git+https://github.com/ysdede/jesse-tk.git#egg=jesse-tk -v

# point python to python3
# echo "alias python=python3" >> ~/.profile
# echo "alias pip=pip3" >> ~/.profile
# . ~/.profile

echo "cleaning..."
rm ta-lib-0.4.0-src.tar.gz #  && rm -rf ta-lib
echo "Finished installation. "
end=`date +%s`
runtime=$((end-start))
echo "Installation took ${runtime} seconds."
echo "Here's the output of 'python --version' (it should be 'Python 3.x.x'):"
python --version
echo "Here's the output of 'pip --version':"
pip --version
