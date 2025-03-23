#!/bin/bash

echo "Updating the system..."
sudo apt-get update && sudo apt-get upgrade -y

echo "Installing necessary dependencies..."
sudo apt install libpcre3 libpcre3-dbg libpcre3-dev build-essential libpcap-dev libyaml-0-2 libyaml-dev pkg-config zlib1g zlib1g-dev make libmagic-dev libjansson-dev rustc cargo python-yaml python3-yaml liblua5.1-dev

echo "Downloading Suricata source code..."
wget https://www.openinfosecfoundation.org/download/suricata-7.0.9.tar.gz

echo "Extracting Suricata..."
tar -xvf suricata-7.0.9.tar.gz

echo "Entering Suricata directory..."
cd suricata-7.0.9

echo "Configuring installation..."
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --enable-nfqueue --enable-lua

echo "Compiling Suricata..."
make

echo "Installing Suricata..."
sudo make install

echo "Going to suricata-update folder..."
cd suricata-update/

echo "Building suricata-update..."
sudo python setup.py build

echo "Installing suricata-update..."
sudo python setup.py install

echo "Going to Suricata directory..."
cd ..

echo "Finishing Suricata installation, including its rules..."
sudo make install-full

echo "Updating Suricata's rules..."
sudo suricata-update