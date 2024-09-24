#!/usr/bin/bash

install_virtualization(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf update -y
        sudo dnf install -y libvirt-daemon-config-network libvirt-daemon-kvm\
        qemu-kvm virt-install virt-manager virt-viewer
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
        -O /etc/yum.repos.d/virtio-win.repo
        sudo rpm-ostree refresh-md
        sudo rpm-ostree install libvirt-daemon-config-network libvirt-daemon-kvm\
        qemu-kvm virt-install virt-manager virt-viewer virtio-win
        sudo rpm-ostree apply-live
        #"$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y libvirt-daemon-config-network qemu-kvm virt-manager virt-viewer
    else
        echo "Unkown error has occurred."
    fi
}

install_virtualization
$SCRIPTS_FOLDER/modules/other/misc/check_for_libvirt_group.sh
xdg-open "https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md"
