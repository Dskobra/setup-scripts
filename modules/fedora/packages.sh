#!/usr/bin/bash

install_flatpak(){
    if [ ! -n "$VARIANT" ] || [ $VARIANT == "kde" ] || [ $VARIANT == "xfce" ] || [ $VARIANT == "matecompiz" ]
    then
        sudo $PKGMGR install -y flatpak
        source $SCRIPTS_HOME/modules/shared.sh; "frepo"
    elif [ $VARIANT == "kinoite" ]
    then
        source $SCRIPTS_HOME/modules/shared.sh; "fpk_repo"
    fi
}

install_kdeapps(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y kcalc konversation krdc krusader ktorrent okular kmouth
        sudo $PKGMGR install -y signon-kwallet-extension kate firefox fedora-bookmarks
    elif [ $VARIANT == "ostree" ]
    then
        sudo $PKGMGR install -y krusader kmouth krdc signon-kwallet-extension
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_ktorrent"
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_kconversation"
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_kcalc"
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_kdeokular"

        source $SCRIPTS_HOME/modules/fedora/fedora.sh; "check_if_immutable"
    else
        echo "Unkown error has occured."
    fi
}

install_kdemm(){
    if [ ! -n "$VARIANT" ];
    then
        sudo $PKGMGR install -y digikam elisa-player gwenview k3b\
        kamera kamoso kf5-kipi-plugins kolourpaint 
    elif [ $VARIANT == "ostree" ];
    then
        sudo $PKGMGR install -y k3b
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_kdedigikam"
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_kdeelisa"
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_kdegwenview"
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_kdekamoso"
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_kpaint"

        source $SCRIPTS_HOME/modules/fedora/fedora.sh; "check_if_immutable"
    else
        echo "Unkown error has occured."
    fi
}

install_kdeemail(){
    if [ ! -n "$VARIANT" ];
    then
        sudo $PKGMGR groupinstall -y "KDE PIM"
    elif [ $VARIANT == "ostree" ];
    then
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_kontact"
    else
        echo "Unkown error has occured."
    fi
}

install_xfce_apps(){
    if [ ! -n "$VARIANT" ];
    then
        sudo $PKGMGR groupinstall -y "Applications for the xfce desktop"
        sudo $PKGMGR install -y menulibre python3-distutils-extra
        sudo $PKGMGR remove -y geany transmission
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_geany"
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_transmission"
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_missioncenter"
        install_mugshot
    elif [ $VARIANT == "ostree" ];
    then
        echo "Immutable variants are unsupported"

    fi
}

install_xfce_plugins(){
    if [ ! -n "$VARIANT" ];
    then
        sudo $PKGMGR install -y xfce4-*-plugin
        
    elif [ $VARIANT == "ostree" ];
    then
        echo "Immutable variants are unsupported"    
    fi
}

install_xfcemm(){
    if [ ! -n "$VARIANT" ];
    then
        sudo $PKGMGR install -y asunder pavucontrol pragha xfburn
    elif [ $VARIANT == "ostree" ];
    then
        echo "Immutable variants are unsupported"
    fi
}

install_mugshot(){
    MUGSHOT_FOLDER="mugshot-0.4.3"
    cd $SCRIPTS_HOME/temp/
    curl -L -o $MUGSHOT_FOLDER.tar.gz https://github.com/bluesabre/mugshot/releases/download/mugshot-0.4.3/mugshot-0.4.3.tar.gz
    tar -xvf $MUGSHOT_FOLDER.tar.gz
    cd $MUGSHOT_FOLDER
    sudo python3 setup.py install
    sudo mkdir /usr/local/share/glib-2.0/schemas
    cd data/glib-2.0/schemas/
    sudo cp org.bluesabre.mugshot.gschema.xml  /usr/local/share/glib-2.0/schemas
    sudo glib-compile-schemas /usr/local/share/glib-2.0/schemas
}

install_mate_apps(){
    if [ ! -n "$VARIANT" ];
    then
        sudo $PKGMGR install -y caja-beesu caja-share firewall-applet mate-menu\
        mate sensors-applet mate-utils multimedia-menus pidgin pluma-plugins\
        tigervnc
    elif [ $VARIANT == "ostree" ];
    then
        echo "Immutable variants are unsupported"
    fi
}

install_compiz(){
   if [ ! -n "$VARIANT" ];
    then
        sudo $PKGMGR groupinstall -y "Compiz"
    elif [ $VARIANT == "ostree" ];
    then
        echo "Immutable variants are unsupported"
    fi
}

install_brave_browser(){
    if [ ! -n "$VARIANT" ]
        then
            sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
            sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
            sudo dnf update -y
            sudo $PKGMGR install -y brave-browser
    elif [ $VARIANT == "ostree" ]
        then
            cd $SCRIPTS_HOME/temp
            curl -L -o brave-browser.repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
            sudo chown root:root brave-browser.repo
            sudo mv brave-browser.repo /etc/yum.repos.d/

            curl -L -o brave-core.asc https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
            sudo chown root:root brave-core.asc
            sudo mv brave-core.asc /etc/pki/rpm-gpg/

            sudo $PKGMGR refresh-md
            sudo $PKGMGR install -y brave-browser

            source $SCRIPTS_HOME/modules/fedora/fedora.sh; "check_if_immutable"
    fi
}

install_codecs(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR swap -y ffmpeg-free ffmpeg --allowerasing
        sudo $PKGMGR install -y gstreamer1-plugin-openh264 \
	    mozilla-openh264 ffmpeg ffmpeg-libs.i686 ffmpeg-libs
        #sudo $PKGMGR swap -y mesa-va-drivers mesa-va-drivers-freeworld
        #sudo $PKGMGR swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
    elif [ $VARIANT == "ostree" ]
    then
        sudo $PKGMGR override remove libavcodec-free libavfilter-free \
        libavformat-free libavutil-free libpostproc-free \
        libswresample-free libswscale-free --install ffmpeg
        #sudo $PKGMGR override remove mesa-va-drivers --install mesa-va-drivers-freeworld
        
        #sudo $PKGMGR install -y mesa-vdpau-drivers-freeworld
        sudo $PKGMGR install -y gstreamer1-plugin-openh264 \
        mozilla-openh264

        source $SCRIPTS_HOME/modules/fedora/fedora.sh; "check_if_immutable"
    else
        echo "Unkown error has occured."
    fi
}

install_openshot(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y openshot
    elif [ $VARIANT == "ostree" ]
    then
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_openshot"
    else
        echo "Unkown error has occured."
    fi
}

install_kolourpaint(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y kolourpaint
    elif [ $VARIANT == "ostree" ]
    then
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_kpaint"
        
    else
        echo "Unkown error has occured."
    fi
}

install_kpat(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y kpat
    elif [ $VARIANT == "ostree" ]
    then
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_kpat"
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

install_steam(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y steam gamescope
    elif [ $VARIANT == "ostree" ]
    then
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_steam"
        source $SCRIPTS_HOME/modules/fedora/packages.sh; "fpk_gamescope"
    else
        echo "Unkown error has occured."
    fi
}

install_c_cpp(){
    if [ ! -n "$VARIANT" ]
    then
        sudo dnf groupinstall -y "C Development Tools and libraries"
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

install_rpm_tools(){
    if [ ! -n "$VARIANT" ]
    then
        sudo dnf groupinstall -y "RPM Development Tools"
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
    sudo usermod -aG libvirt $USER
}

### Reset packages

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