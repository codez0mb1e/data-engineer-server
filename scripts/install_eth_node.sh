#!/bin/bash

#
# Install ETH node scripts
#

# 0. Set up node
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt update

sudo apt install -y ethereum


# 1. Set up data disc
ls /mnt
lsblk -f
# mount data disc (optional)
sudo mkdir /mnt/node-1
sudo mount /dev/sdb1 /mnt/node-1

sudo groupadd ethadmin <username>
sudo usermod -aG ethadmin /mnt/node-1
sudo chgrp -R ethadmin /mnt/node-1/node-1
sudo chmod -R 770 /mnt/node-1/node-1

# 2. To be continued...


# References
# 1. https://gavofyork.gitbooks.io/turboethereum/content/chapter1.html
# 2. https://geth.ethereum.org/docs/install-and-build/installing-geth
