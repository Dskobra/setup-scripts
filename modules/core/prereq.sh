#!/usr/bin/bash

# checks/installs basic packages such as flatpak, curl/wget and git.

prereq_check(){
    # package names are same across most distros. Check these first. 
    apps_folder_check
    deps_check
    if [ "$DISTRO" == "fedora" ]
    then
        dnf_plugins_core_check
        echo $PACKAGES_TO_INSTALL
        if [ -z "$PACKAGES_TO_INSTALL" ]
        then
            echo "Dependencies are installed."
        else
            echo "Following packages will be installed: $PACKAGES_TO_INSTALL flatseal"
            sudo dnf install -y $PACKAGES_TO_INSTALL
            #sudo dnf install -y curl wget flatpak dnf-plugins-core
        fi
        rpmfusion_check
    else
        echo "Unkown error has occurred."
    fi
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install --user -y flathub com.github.tchx84.Flatseal        # allows easily managing permissions for flatpaks
}

apps_folder_check(){
    if test -d /home/$USER/bin; then
        #echo "Found folder: /home/$USER/bin"
        USELESS_VAR=""
    elif ! test -d /home/$USER/bin; then
        mkdir /home/$USER/bin
        echo "Created folder: /home/$USER/bin"

    fi

    if test -d /opt/apps/; then
        #echo "Found folder: /opt/apps/" 
        USELESS_VAR=""
    elif ! test -d /opt/apps/; then
        sudo mkdir /opt/apps/
        sudo mkdir /opt/apps/icons
        sudo mkdir /opt/apps/appimages
        sudo mkdir /opt/apps/temp
        sudo chown $USER:$USER /opt/apps/ -R
        echo "Created folder: /opt/apps/"
        echo "Created folder: /opt/apps/icons"
        echo "Created folder: /opt/apps/appimages"
        echo "Created folder: /opt/apps/temp"

    fi

    if test -d /opt/apps/icons; then
        #echo "Found folder: /opt/apps/icons"
        USELESS_VAR=""
    elif ! test -d /opt/apps/icons; then
        echo "Missing folder: /opt/apps/icons"
        sudo mkdir /opt/apps/icons
        sudo chown $USER:$USER /opt/apps/icons -R
        echo "Created folder: /opt/apps/icons"

    fi

    if test -d /opt/apps/appimages; then
        #echo "Found folder: /opt/apps/appimages"
        USELESS_VAR=""
    elif ! test -d /opt/apps/appimages; then
        echo "Missing folder: /opt/apps/appimages"
        sudo mkdir /opt/apps/appimages
        sudo chown $USER:$USER /opt/apps/appimages -R
        echo "Created folder: /opt/apps/appimages"

    fi

    if test -d /opt/apps/temp; then
        #echo "Found folder: /opt/apps/temp"
        USELESS_VAR=""
    elif ! test -d /opt/apps/temp; then
        echo "Missing folder: /opt/apps/temp"
        sudo mkdir /opt/apps/temp
        sudo chown $USER:$USER /opt/apps/temp -R
        echo "Created folder: /opt/apps/temp folder"

    fi
}

deps_check(){
    if test -f /usr/bin/wget; then
        echo "wget already installed."
        USELESS_VAR=""
    elif ! test -f /usr/bin/wget; then
        PACKAGES_TO_INSTALL+=" wget "
    fi

    if test -f /usr/bin/curl; then
        echo "Curl already installed."
    elif ! test -f /usr/bin/curl; then
        PACKAGES_TO_INSTALL+=" curl "
    fi

    if test -f /usr/bin/flatpak; then
        echo "flatpak already installed."
    elif ! test -f /usr/bin/flatpak; then
        PACKAGES_TO_INSTALL+=" flatpak "

    fi
}

dnf_plugins_core_check(){
    if test -f /etc/dnf/plugins/copr.conf; then
        echo "dnf-plugins-core already installed."
    elif ! test -f /etc/dnf/plugins/copr.conf; then
        PACKAGES_TO_INSTALL+=" dnf-plugins-core "
    fi
}

rpmfusion_check(){
    if test -f /etc/yum.repos.d/rpmfusion-free.repo && test -f /etc/yum.repos.d/rpmfusion-nonfree.repo; then
        echo "rpmfusion already installed."
    elif ! test -f /etc/yum.repos.d/rpmfusion-free.repo; then
        sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

    fi
}

PACKAGES_TO_INSTALL=""
USELESS_VAR=""          # dont echo if folders are present or else it lists them even after script makes them
prereq_check
