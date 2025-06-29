#!/usr/bin/bash

native_mega(){
    cd /opt/apps/temp/
    wget https://mega.nz/linux/repo/openSUSE_Tumbleweed/x86_64/megasync-openSUSE_Tumbleweed.x86_64.rpm
    sudo zypper -n --no-gpg-checks install "$PWD/megasync-openSUSE_Tumbleweed.x86_64.rpm"
}

native_mega
