#!/bin/bash

# Install docker
sudo apt-get update -y && apt-get dist-upgrade -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo usermod -aG docker ${USER}

# Install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose -v

sudo apt autoremove -y

sudo apt-get install -y vim htop locate git-core tmux openssh-server

sudo dpkg --add-architecture i386

sudo apt-get -y install --no-install-recommends build-essential \
    automake ncurses-dev libcurl4-openssl-dev libssl-dev libgtest-dev \
    make autoconf libtool git apt-utils pkg-config libc6-dev libcurl3-dev \
    libudev-dev m4 g++-multilib unzip python zlib1g-dev wget bsdmainutils \
    qt5-default cmake libboost-all-dev nmap ncdu inxi links opencl-headers \
    mesa-common-dev

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common \
    python-software-properties --no-install-recommends \
    clinfo xorg xserver-xorg-legacy xserver-xorg-video-dummy

sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update -y
sudo apt-get install -y nvidia-387 supervisor

sudo cp miner /usr/local/bin
sudo cp miner_log.conf /etc/supervisor/conf.d/
sudo cp zcash_miner.conf /etc/supervisor/conf.d/

sudo systemctl enable supervisor
sudo systemctl restart supervisor

sudo systemctl enable multi-user.target --force
sudo systemctl set-default multi-user.target


# sudo nano /etc/default/grub
# Find this line:

# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
# Change it to:

# GRUB_CMDLINE_LINUX_DEFAULT="text"
# Update GRUB:

# sudo update-grub

# ------------------------------------------------------------------------------
# sudo shred -v -n1 -z /dev/sdX
#
# Erase entire hard disk
# This will overwrite all the blocks on the device with random data three times,
# the -v flag is for verbose and will print the current progress.
# You can add the option -nN to only do this N times, to save time on
# large capacity devices. This might take a while, depending on the size of
# your external hard drive.
# You can also set all bits to zero after the last iteration by
# adding the option -z, I prefer to do this.


# dd if=/dev/sdX of=/dev/sdY bs=64K conv=noerror,sync status=progress
#
# This will clone the entire drive, including the MBR
# (and therefore bootloader), all partitions, UUIDs, and data.
# bs= sets the block size. Defaults to 512 bytes, which is the
#     "classic" block size for hard drives since the early 1980s,
#     but is not the most convenient. Use a bigger value, 64K or 128K.
#     Also, please read the warning below, because there is more to this
#     than just "block sizes" -it also influences how read errors propagate.
# noerror instructs dd to continue operation, ignoring all read errors.
#     Default behavior for dd is to halt at any error.
# sync fills input blocks with zeroes if there were any read errors,
#     so data offsets stay in sync.
# status=progress shows periodic transfer statistics which can be used to
#     estimate when the operation may be complete.
