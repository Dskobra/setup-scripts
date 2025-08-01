#!/usr/bin/bash

sudo zypper -n install patterns-server-kvm_server
sudo zypper -n install patterns-server-kvm_tools
sudo usermod -aG libvirt "$USER"
xdg-open "https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md"
