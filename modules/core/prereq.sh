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

apps_folder_check(){
    if test -d /home/$USER/bin; then
        echo "bin folder present."
    elif ! test -d /home/$USER/bin; then
        mkdir /home/$USER/bin
        echo "Created /home/$USER/bin folder"

    fi

    if test -d /opt/apps/; then
        echo "Apps folder present."
    elif ! test -d /opt/apps/; then
        echo "apps folder missing."
        sudo mkdir /opt/apps/
        sudo mkdir /opt/apps/icons
        sudo mkdir /opt/apps/appimages
        sudo mkdir /opt/apps/temp
        sudo chown $USER:$USER /opt/apps/ -R
        echo "Created /opt/apps folder"

    fi

    if test -d /opt/apps/icons; then
        echo "Apps icons folder present."
    elif ! test -d /opt/apps/icons; then
        echo "Apps icon folder missing."
        sudo mkdir /opt/apps/icons
        sudo chown $USER:$USER /opt/apps/icons -R
        echo "Created /opt/apps/icons folder"

    fi

    if test -d /opt/apps/appimages; then
        echo "Apps appimages folder present."
    elif ! test -d /opt/apps/appimages; then
        echo "Apps appimages folder missing."
        sudo mkdir /opt/apps/appimages
        sudo chown $USER:$USER /opt/apps/appimages -R
        echo "Created /opt/apps/appimages folder"

    fi

    if test -d /opt/apps/temp; then
        echo "temp folder present."
    elif ! test -d /opt/apps/temp; then
        echo "apps temp folder missing."
        sudo mkdir /opt/apps/temp
        sudo chown $USER:$USER /opt/apps/temp -R
        echo "Created /opt/apps/temp folder"

    fi
}

deps_check(){
    if test -f /usr/bin/wget; then
        echo "wget already installed."
    elif ! test -f /usr/bin/wget; then
        PACKAGES_TO_INSTALL+=" wget"
    fi

    if test -f /usr/bin/curl; then
        echo "Curl already installed."
    elif ! test -f /usr/bin/curl; then
        PACKAGES_TO_INSTALL+=" curl"
    fi

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
#run_prereq_check
prereq_check
