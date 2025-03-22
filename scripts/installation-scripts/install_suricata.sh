#!/bin/bash

echo "Installing necessary dependencies..."
sudo apt install libpcre3 libpcre3-dbg libpcre3-dev build-essential libpcap-dev libyaml-0-2 libyaml-dev pkg-config zlib1g zlib1g-dev make libmagic-dev libjansson-dev rustc cargo python-yaml python3-yaml liblua5.1.0-dev

echo "Downloading Suricata source code..."
wget https://www.openinfosecfoundation.org/download/suricata-6.0.10.tar.gz

echo "Extracting Suricata..."
tar -xvf suricata-6.0.10.tar.gz

echo "Entering Suricata directory..."
cd suricata-6.0.10

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