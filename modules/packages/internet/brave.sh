#!/usr/bin/bash

native_brave_browser(){
    cd "$SCRIPTS_FOLDER"/temp
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf4 config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
        sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        sudo dnf update -y
        sudo dnf install -y brave-browser

    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
        sudo zypper ref
        sudo zypper -n install brave-browser
    elif [ "$DISTRO" == "debian" ]
    then
        sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
        sudo apt-get update
        sudo apt-get install -y brave-browser
    else
        echo "Unkown error has occurred."
    fi
}

remove_brave_browser(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y brave-browser
        sudo rm "/etc/yum.repos.d/brave-browser.repo"
        sudo rm "/etc/pki/rpm-gpg/RPM-GPG-KEY-brave-nightly"
        sudo rm "/etc/pki/rpm-gpg/RPM-GPG-KEY-brave-beta"
        sudo rm "/etc/pki/rpm-gpg/RPM-GPG-KEY-brave"
        sudo dnf update -y
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        sudo zypper -n rm brave-browser
        sudo rm "/etc/zypp/repos.d/brave-browser.repo"
        sudo rm "/etc/pki/rpm-gpg/RPM-GPG-KEY-brave-nightly"
        sudo rm "/etc/pki/rpm-gpg/RPM-GPG-KEY-brave-beta"
        sudo rm "/etc/pki/rpm-gpg/RPM-GPG-KEY-brave"
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y brave-browser
        sudo rm "/etc/apt/sources.list.d/brave-browser-release.list"
        sudo apt-get update
        
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub com.brave.Browser
    remove_brave_browser
elif [ "$1" == "native" ]
then
    flatpak uninstall --user -y com.brave.Browser
    native_brave_browser
else
    echo "error"
fi