#!/usr/bin/bash

install_flatpak(){
    source $SCRIPTS_HOME/modules/packages/3rd_party_repos.conf
    sudo $PKGMGR -n install flatpak
    flatpak remote-add --if-not-exists --user $FLATPAK_FLATHUB
}

### desktop features
install_cheese(){
    source $SCRIPTS_HOME/modules/packages/desktop_apps.conf
    sudo $PKGMGR -n install $CHEESE
}

install_kamoso(){
    source $SCRIPTS_HOME/modules/packages/desktop_apps.conf
    sudo $PKGMGR -n install $KAMOSO
}

install_kdeapps(){
    source $SCRIPTS_HOME/modules/packages/desktop_apps.conf
    sudo $PKGMGR -n install $KDE_APPS
}

install_xfce_apps(){
    source $SCRIPTS_HOME/modules/packages/desktop_apps.conf
    sudo $PKGMGR -n remove geany transmission-gtk
    sudo $PKGMGR -n install $XFCE_APPS $XFCE_APPS_OPENSUSE
}

install_mate_apps(){
    source $SCRIPTS_HOME/modules/packages/mate_apps.conf
    sudo $PKGMGR -n install $MATE_APPS $MATE_APPS_OPENSUSE\
    $MATE_COMPIZ $MATE_COMPIZ_OPENSUSE
}

### internet

install_firefox(){
    source $SCRIPTS_HOME/modules/packages/internet_apps.conf
    sudo $PKGMGR -n install $FIREFOX_OPENSUSE
}

install_brave_browser(){
    source $SCRIPTS_HOME/modules/packages/internet_apps.conf
    sudo rpm --import $BRAVE_PKEY
    sudo zypper addrepo $BRAVE_REPO
    sudo $PKGMGR -n install brave-browser
}

### multimedia

install_codecs(){
    source $SCRIPTS_HOME/modules/packages/multimedia_apps.conf
    sudo $PKGMGR -n install ffmpeg-6 mozilla-openh264 gstreamer-plugin-openh264
}

install_openshot(){
    source $SCRIPTS_HOME/modules/packages/multimedia_apps.conf
    sudo $PKGMGR -n install $OPENSHOT_OPENSUSE
}

install_kthreeb(){
    source $SCRIPTS_HOME/modules/packages/multimedia_apps.conf
    sudo $PKGMGR -n install $KTHREEB
}

install_kolourpaint(){
    source $SCRIPTS_HOME/modules/packages/multimedia_apps.conf
    sudo $PKGMGR -n install $KOLOURPAINT
}

### games
install_steam(){
    source $SCRIPTS_HOME/modules/packages/gaming_apps.conf
    sudo $PKGMGR -n install $STEAM
}

install_kpat(){
    source $SCRIPTS_HOME/modules/packages/gaming_apps.conf
    sudo $PKGMGR -n install $KPAT
}

install_mangohud(){
    source $SCRIPTS_HOME/modules/packages/gaming_apps.conf
    sudo $PKGMGR -n install $MANGOHUD
    flatpak install --user -y $FLATPAK_MANGOHUD
}

### Office Apps

install_abiword(){
    source $SCRIPTS_HOME/modules/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR -n install $GTK_ABIWORD
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_ABIWORD
    else
        echo "Unkown error has occured."
    fi
}

install_gnumeric(){
    source $SCRIPTS_HOME/modules/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR -n install $GTK_GNUMERIC
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_GNUMERIC
    else
        echo "Unkown error has occured."
    fi
}

install_okular(){
    source $SCRIPTS_HOME/modules/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR -n install $KDE_OKULAR
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_OKULAR
    else
        echo "Unkown error has occured."
    fi
}

install_evince(){
    source $SCRIPTS_HOME/modules/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR -n install $GTK_EVINCE
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_EVINCE
    else
        echo "Unkown error has occured."
    fi
}

install_kde_ark(){
    source $SCRIPTS_HOME/modules/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR -n install $KDE_ARK
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_ARK
    else
        echo "Unkown error has occured."
    fi
}

install_file_roller(){
    source $SCRIPTS_HOME/modules/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR -n install $GTK_FILE_ROLLER
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_FILE_ROLLER
    else
        echo "Unkown error has occured."
    fi
}

install_claws_mail(){
    source $SCRIPTS_HOME/modules/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR -n install $GTK_CLAWS_MAIL
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_CLAWS_MAIL
    else
        echo "Unkown error has occured."
    fi
}

install_thunderbird(){
    source $SCRIPTS_HOME/modules/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR -n install $THUNDERBIRD_OPENSUSE
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_THUNDERBIRD
    else
        echo "Unkown error has occured."
    fi
}
### coding apps

install_c_cpp(){
    source $SCRIPTS_HOME/modules/packages/coding_apps.conf
    sudo $PKGMGR -n install $OPENSUSE_GCC

}

install_rpm_tools(){
    source $SCRIPTS_HOME/modules/packages/coding_apps.conf
    sudo $PKGMGR -n install $OPENSUSE_RPM_BUILD_TOOLS
}

install_codeblocks(){
    source $SCRIPTS_HOME/modules/packages/coding_apps.conf
    flatpak install --user -y $FLATPAK_CODEBLOCKS
}

install_java_jdk(){
    source $SCRIPTS_HOME/modules/packages/coding_apps.conf
    sudo $PKGMGR -n install $JAVA_JDK
}

install_scene_builder(){
    cd $SCRIPTS_HOME/temp
    SCENE_BUILDER="SceneBuilder-20.0.0.rpm"
    curl -o $SCENE_BUILDER https://download2.gluonhq.com/scenebuilder/20.0.0/install/linux/SceneBuilder-20.0.0.rpm
    #sudo rpm -i $SCENE_BUILDER
    echo "Please use Yast to install this by going into the scripts main folder -> Temp and right clicking 'SceneBuilder-*.rpm'"
    echo "and choosing to open with YaST Software. You'll need to hit ignore to allow the installation."
}

install_lamp_stack(){
    source $SCRIPTS_HOME/modules/packages/coding_apps.conf
    sudo $PKGMGR -n install $LAMP_STACK $OPENSUSE_LAMP_STACK
}

install_bluefish(){
    source $SCRIPTS_HOME/modules/packages/coding_apps.conf
    sudo $PKGMGR -n install $GTK_BLUEFISH
}

install_python_tools(){
    source $SCRIPTS_HOME/modules/packages/coding_apps.conf
    sudo $PKGMGR -n install $OPENSUSE_PYTHON_TOOLS
}

install_eric_ide(){
    source $SCRIPTS_HOME/modules/packages/coding_apps.conf
    sudo $PKGMGR -n install $QT_ERIC
}

install_vscodium(){
    cd $SCRIPTS_HOME/modules/packages
    cp vscodium.repo.txt vscodium.repo
    sudo chown root:root vscodium.repo
    sudo mv vscodium.repo /etc/zypp/repos.d/vscodium.repo
    sudo zypper refresh
    sudo $PKGMGR -n install codium
}

install_github_desktop(){
    sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/zypp/repos.d/shiftkey-packages.repo'
    sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
    sudo $PKGMGR -n install git-gui github-desktop
}

install_containers(){
    source $SCRIPTS_HOME/modules/packages/coding_apps.conf
    sudo $PKGMGR -n install toolbox distrobox containers-systemd
    flatpak install --user -y $FLATPAK_PODMAN_DESKTOP
}

### utilities

install_fmedia_writer(){
    source $SCRIPTS_HOME/modules/packages/utility_apps.conf
    flatpak install --user -y $FLATPAK_FMEDIA_WRITER
}

install_kde_iso_image_writer(){
    source $SCRIPTS_HOME/modules/packages/utility_apps.conf
    flatpak install --user -y $FLATPAK_KDE_ISO_IMAGE_WRITER
}

install_kleopatra(){
    sudo $PKGMGR install -y kleopatra
}

install_virtualization(){
    source $SCRIPTS_HOME/modules/packages/utility_apps.conf
    sudo $PKGMGR -n install $VIRTUALIZATION libvirt\
    libvirt-daemon-driver-lxc libvirt-daemon-driver-gluster\
    libvirt-daemon-hooks libvirt-daemon-lxc\
    libvirt-daemon-plugin-sanlock libvirt-daemon-qemu\
    libvirt-daemon-xen

    wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo
    sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
    -O /etc/zypp/repos.d/virtio-win.repo
    sudo $PKGMGR install -y virtio-win

}

### remove packages

remove_office(){
    if [ ! -n "$VARIANT" ]
        then
            sudo $PKGMGR remove -y libreoffice*
    elif [ $VARIANT == "ostree" ]
        then
            sudo $PKGMGR remove -y libreoffice
    fi
}

### configurations

check_for_libvirt_group(){
    if [ $(getent group libvirt) ]; then
        sudo usermod -aG libvirt $USER
    else
        echo "Group doesn't exist. Please run the "Virtualization" option "
        echo "from the Extras menu and/or reboot first if using Kinoite etc."
    fi
}