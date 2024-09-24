#!/usr/bin/bash

## Adds user to libvirt group so they can skip the root password
## when using virt-man
check_for_libvirt_group(){
    if [ $(getent group libvirt) ]; then
        sudo usermod -aG libvirt "$USER"
    else
        echo "Group doesn't exist. You're likely running Fedora Atomic Edition."
        echo "Go to Misc menu and choose 'Add user to libvirt group' after rebooting."
    fi
}

check_for_libvirt_group
