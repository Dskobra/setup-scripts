#!/usr/bin/bash

native_virtualization(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf update -y
        sudo dnf install -y libvirt-daemon-config-network libvirt-daemon-kvm\
        qemu-kvm virt-install virt-manager virt-viewer
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install patterns-server-kvm_server
        sudo zypper -n install patterns-server-kvm_tools
    else
        echo "Unkown error has occurred."
    fi
}

native_virtualization
"$SCRIPTS_FOLDER"/modules/misc/check_for_libvirt_group.sh
xdg-open "https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md"
