#!/usr/bin/bash

native_virtualization(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf update -y
        sudo dnf install -y libvirt-daemon-config-network libvirt-daemon-kvm\
        qemu-kvm virt-install virt-manager virt-viewer
    else
        echo "Unkown error has occurred."
    fi
}

native_virtualization
sudo usermod -aG libvirt "$USER"
xdg-open "https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md"
