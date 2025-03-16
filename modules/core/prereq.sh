#!/usr/bin/bash

# checks/installs basic packages such as flatpak, curl/wget and git.

install_prereq(){
    # package names are same across most distros. Check these first. 
    wget_check
    curl_check
    flatpak_check
    if [ "$DISTRO" == "fedora" ]
    then
        dnf_plugins_core_check
        echo $PACKAGES_TO_INSTALL
        if [ -z "$PACKAGES_TO_INSTALL" ]
        then
            echo "Dependencies are installed."
        else
            echo "Following packages will be installed: curl wget flatpak flatseal dnf-plugins-core"
            sudo dnf install -y $PACKAGES_TO_INSTALL
            #sudo dnf install -y curl wget flatpak dnf-plugins-core
        fi
        rpmfusion_check
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        echo $PACKAGES_TO_INSTALL
        if [ -z "$PACKAGES_TO_INSTALL" ]
        then
            echo "Dependencies are installed."
        else
            echo "Following packages will be installed: curl wget flatpak flatseal"
            sudo zypper -n $PACKAGES_TO_INSTALL
            #sudo zypper -n install wget curl flatpak
        fi
    else
        echo "Unkown error has occurred."
    fi
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install --user -y flathub com.github.tchx84.Flatseal        # allows easily managing permissions for flatpaks
}

wget_check(){
    if test -f /usr/bin/wget; then
        echo "wget already installed."
    elif ! test -f /usr/bin/wget; then
        PACKAGES_TO_INSTALL+=" wget"
    fi
}

curl_check(){
    if test -f /usr/bin/curl; then
        echo "Curl already installed."
    elif ! test -f /usr/bin/curl; then
        PACKAGES_TO_INSTALL+=" curl"
    fi
}

flatpak_check(){
    if test -f /usr/bin/flatpak; then
        echo "flatpak already installed."
    elif ! test -f /usr/bin/flatpak; then
        PACKAGES_TO_INSTALL+=" flatpak"

    fi
}

dnf_plugins_core_check(){
    if test -f /etc/dnf/plugins/copr.conf; then
        echo "dnf-plugins-core already installed."
    elif ! test -f /etc/dnf/plugins/copr.conf; then
        PACKAGES_TO_INSTALL+=" dnf-plugins-core"
    fi
}

rpmfusion_check(){
    if test -f /etc/yum.repos.d/rpmfusion-free.repo && test -f /etc/yum.repos.d/rpmfusion-nonfree.repo; then
        echo "rpmfusion already installed."
    elif ! test -f /etc/yum.repos.d/rpmfusion-free.repo; then
        sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

    fi
}

run_prereq_check(){
    ### check if required packages should be installed.
    ### 0 (default) for yes and 1 for no
    PREREQ_FILE=$(cat $SCRIPTS_FOLDER/.prereq.txt)
   if [ "$PREREQ_FILE" != "1" ]
    then
        mkdir /home/$USER/bin
        sudo mkdir /opt/apps/
        sudo mkdir /opt/apps/icons
        sudo mkdir /opt/apps/appimages
        sudo mkdir /opt/apps/temp
        sudo chown $USER:$USER /opt/apps/ -R
        install_prereq
        echo "1" > $SCRIPTS_FOLDER/.prereq.txt
    else
        echo "Skipping first run steps."
    fi
}

PACKAGES_TO_INSTALL=""
run_prereq_check
