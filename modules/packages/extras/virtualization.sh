#!/usr/bin/bash

sudo dnf install -y libvirt-daemon-config-network libvirt-daemon-kvm\
 qemu-kvm virt-install virt-manager virt-viewer
sudo usermod -aG libvirt "$USER"
xdg-open "https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md"
