#!/usr/bin/bash

## Adds user to libvirt group so they can skip the root password
## when using virt-man
check_for_libvirt_group(){
    if [ $(getent group libvirt) ]; then
        sudo usermod -aG libvirt "$USER"
    else
        echo "Group doesn't exist. Please select the 'Virtualization' option"
        echo "under 'Utilities' menu with 'Native' apps."
    fi
}

check_for_libvirt_group
