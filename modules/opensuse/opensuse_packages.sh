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
    sudo $PKGMGR install -y $XFCE_APPS $XFCE_APPS_OPENSUSE
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
    sudo $PKGMGR install -y $STEAM
}

install_kpat(){
    source $SCRIPTS_HOME/modules/packages/gaming_apps.conf
    sudo $PKGMGR install -y $KPAT
}

install_mangohud(){
    source $SCRIPTS_HOME/modules/packages/gaming_apps.conf
    sudo $PKGMGR install -y $MANGOHUD
    flatpak install --user -y $FLATPAK_MANGOHUD
}

### coding apps

install_c_cpp(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y gcc-g++ autoconf automake bison\
        flex libtool m4 valgrind byacc ccache cscope indent\
        ltrace perf strace
    elif [ $VARIANT == "ostree" ]
    then
        sudo $PKGMGR install -y gcc-g++ autoconf automake bison\
        flex libtool m4 valgrind byacc ccache cscope indent\
        ltrace perf strace

        source $SCRIPTS_HOME/modules/fedora/fedora.sh; "check_if_immutable"
    else
        echo "Unkown error has occured."
    fi
}

install_bluefish(){
    if [ ! -n "$VARIANT" ]
    then
         sudo $PKGMGR install -y bluefish
    elif [ $VARIANT == "ostree" ]
    then
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_bluefish"
        
    else
        echo "Unkown error has occured."
    fi
}

install_codeblocks(){
    if [ ! -n "$VARIANT" ]
    then
         sudo $PKGMGR install -y codeblocks codeblocks-contrib-devel
    elif [ $VARIANT == "ostree" ]
    then
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_codeblocks"
    else
        echo "Unkown error has occured."
    fi
}

install_rpm_tools(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y koji mock redhat-rpm-config\
        rpm-build rpmdevtools
    elif [ $VARIANT == "ostree" ]
    then
        sudo $PKGMGR install -y koji mock redhat-rpm-config\
        rpm-build rpmdevtools

        source $SCRIPTS_HOME/modules/fedora/fedora.sh; "check_if_immutable"

    else
        echo "Unkown error has occured."
    fi
}

install_github_desktop(){
    sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
    if [ ! -n "$VARIANT" ]
        then
            sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
            sudo $PKGMGR install -y git-gui github-desktop
            
    elif [ $VARIANT == "ostree" ]
        then
            cd $SCRIPTS_HOME/temp
            curl -L -o shiftkey-gpg.key https://rpm.packages.shiftkey.dev/gpg.key
            sudo chown root:root shiftkey-gpg.key
            sudo mv shiftkey-gpg.key /etc/pki/rpm-gpg/
            sudo $PKGMGR install -y git-gui 
            sudo $PKGMGR install -y github-desktop

            source $SCRIPTS_HOME/modules/fedora/fedora.sh; "check_if_immutable"
    fi
}

install_vscodium(){
    printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo
    if [ ! -n "$VARIANT" ]
        then
            sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
            sudo $PKGMGR install -y codium

            source $SCRIPTS_HOME/modules/fedora/fedora.sh; "check_if_immutable"    
    elif [ $VARIANT == "ostree" ]
        then
            cd $SCRIPTS_HOME/temp
            curl -L -o vscodium.gpg https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
            chown root:root vscodium.gpg
            sudo mv vscodium.gpg /etc/pki/rpm-gpg/ 
            sudo $PKGMGR install -y codium  
   
    fi
}

install_scene_builder(){
    cd $SCRIPTS_HOME/temp
    SCENE_BUILDER="SceneBuilder-20.0.0.rpm"
    curl -o $SCENE_BUILDER https://download2.gluonhq.com/scenebuilder/20.0.0/install/linux/SceneBuilder-20.0.0.rpm
    if [ ! -n "$VARIANT" ]
    then
        sudo rpm -i $SCENE_BUILDER
    elif [ $VARIANT == "ostree" ]
    then
        sudo $PKGMGR install -y $SCENE_BUILDER

        source $SCRIPTS_HOME/modules/fedora/fedora.sh; "check_if_immutable"
    else
        echo "Unkown error has occured."
    fi
}

install_lamp_stack(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y httpd php mariadb-server phpmyadmin
    elif [ $VARIANT == "ostree" ]
    then
        sudo $PKGMGR install -y httpd php mariadb-server phpmyadmin

        source $SCRIPTS_HOME/modules/fedora/fedora.sh; "check_if_immutable"

    else
        echo "Unkown error has occured."
    fi
}

### utilities

install_fmedia_writer(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y mediawriter
    elif [ $VARIANT == "ostree" ]
    then
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_fedora_mediawriter"
    else
        echo "Unkown error has occured."
    fi
}

install_kde_iso_image_writer(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y isoimagewriter
    elif [ $VARIANT == "ostree" ]
    then
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_fedora_mediawriter"
    else
        echo "Unkown error has occured."
    fi
}

install_kleopatra(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y kleopatra
    elif [ $VARIANT == "ostree" ]
    then
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_kleopatra"
    else
        echo "Unkown error has occured."
    fi
}

install_virtualization(){
    if [ ! -n "$VARIANT" ]
    then
        sudo dnf groupinstall -y "Virtualization"
    elif [ $VARIANT == "ostree" ]
    then
        sudo $PKGMGR install -y libvirt-daemon-config-network\
        libvirt-daemon-kvm qemu-kvm virt-install\
        virt-manager virt-viewer

        source $SCRIPTS_HOME/modules/fedora/fedora.sh; "check_if_immutable"

    else
        echo "Unkown error has occured."
    fi
    sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
    -O /etc/yum.repos.d/virtio-win.repo
    sudo $PKGMGR install -y virtio-win
}

### remove packages

remove_codecs(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR swap -y ffmpeg libavcodec-free --allowerasing
        sudo $PKGMGR swap -y mesa-va-drivers-freeworld mesa-va-drivers 
        sudo $PKGMGR swap -y mesa-vdpau-drivers-freeworld mesa-vdpau-drivers 
    elif [ $VARIANT == "ostree" ]
    then
        sudo $PKGMGR remove ffmpeg
        sudo $PKGMGR override reset libavcodec-free libavfilter-free \
        libavformat-free libavutil-free libpostproc-free \
        libswresample-free libswscale-free
        sudo $PKGMGR override reset mesa-va-drivers mesa-vdpau-drivers-freeworld
        
        sudo $PKGMGR remove -y gstreamer1-plugin-openh264 \
        mozilla-openh264

        
        source $SCRIPTS_HOME/modules/fedora/fedora.sh; "check_if_immutable"
    else
        echo "Unkown error has occured."
    fi
}

remove_office(){
    if [ ! -n "$VARIANT" ]
        then
            sudo $PKGMGR remove -y gnumeric libreoffice*
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