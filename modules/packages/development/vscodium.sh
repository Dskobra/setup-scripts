#!/usr/bin/bash

native_vscodium(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
        printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
        sudo dnf install -y codium
    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
        printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/zypp/repos.d/vscodium.repo
        sudo zypper -n install codium
    elif [ "$PKGMGR" == "apt-get" ]
    then
        wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
            | gpg --dearmor \
            | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
        echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
            | sudo tee /etc/apt/sources.list.d/vscodium.list
        sudo apt-get update && sudo apt-get install -y codium
    else
        echo "Unkown error has occurred."
    fi
}

remove_vscodium(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo rm /etc/yum.repos.d/vscodium.repo
        sudo dnf remove -y codium
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo rm /etc/zypp/repos.d/vscodium.repo
        sudo zypper -n rm codium
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo rm archive_uri-https_paulcarroty_gitlab_io_vscodium-deb-rpm-repo_debs_-bookworm.list
        sudo apt-get remove -y codium
        
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub com.vscodium.codium
    remove_vscodium
elif [ "$1" == "native" ]
then
    flatpak remove --user -y com.vscodium.codium
    native_vscodium
else
    echo "error"
fi