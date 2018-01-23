#!/bin/bash

ps -C openvpn
if [ $? -ne 0 ]; then
    echo "Let' connect to VPN"
    openvpn --config /root/client.ovpn --daemon
else
    ifconfig tun0
    if [ $? -ne 0 ]; then
        echo "Connecting to VPN"
    else
        echo "Connected to VPN. Yay"
    fi
fi
