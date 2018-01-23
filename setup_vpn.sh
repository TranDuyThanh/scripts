#!/bin/bash
#
# https://medium.com/@jmarhee/automating-deploying-a-personal-vpn-server-on-digitalocean-f585aca396cf
# source: https://raw.githubusercontent.com/jmarhee/dockvpn/master/provision.sh

function install_pkgs() {
    apt-get update && \
    apt-get install -y git-core curl
}

function install_compose() {
    curl -L "https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose
}

function deploy_vpn() {
    git clone https://github.com/jmarhee/dockvpn.git && \
    cd dockvpn && \
    docker-compose up -d
}

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo usermod -aG docker ${USER}

install_pkgs && install_compose && deploy_vpn
