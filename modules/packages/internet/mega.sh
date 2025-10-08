#!/usr/bin/bash

native_mega(){
    if [ "$VERSION_ID" == "42" ]
    then
        cd /opt/apps/temp/
        wget https://mega.nz/linux/repo/Fedora_42/x86_64/megasync-Fedora_42.x86_64.rpm && sudo dnf install -y "$PWD/megasync-Fedora_42.x86_64.rpm"
        rm megasync-Fedora_42.x86_64.rpm

    elif [ "$VERSION_ID" == "43" ]
    then
        cd /opt/apps/temp/
        wget https://mega.nz/linux/repo/Fedora_43/x86_64/megasync-Fedora_43.x86_64.rpm && sudo dnf install "$PWD/megasync-Fedora_43.x86_64.rpm"
        rm megasync-Fedora_43.x86_64.rpm
    else
        echo "Unkown error has occurred."
    fi

}

native_mega