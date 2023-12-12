#!/usr/bin/bash

install_basic_apps(){
    echo "Setting up rpmfusion and brave browser"

    sudo dnf install -y vim-enhanced java-17-openjdk brave-browser \
    plymouth-theme-spinfinity lm_sensors dnfdragora flatpak git     
    
    install_codecs
	sudo plymouth-set-default-theme spinfinity -R

    source $SCRIPTS_HOME/modules/shared.sh; "fbasic"
    source $SCRIPTS_HOME/modules/shared.sh; "futils"

    test -f /usr/bin/plasma_session && DESKTOP=kde
    test -f /usr/bin/xfce4-panel && DESKTOP=xfce
    if [ "$DESKTOP" = "kde" ];
        then
            sudo dnf install -y  ark gwenview kate 
    elif [ "$DESKTOP" = "xfce" ];
        then
            sudo dnf install -y  xarchiver menulibre flatpak python3-distutils-extra
            sudo dnf groupinstall -y "Firefox Web Browser"
            sudo dnf groupinstall -y "Extra plugins for the Xfce panel"
            flatpak install --user -y flathub io.missioncenter.MissionCenter
            install_mugshot         
    fi
}

install_xfce_features(){
    if [ "$PKGMGR" = "rpm-ostree" ];
        then
            echo "Immutable variants are unsupported"
    elif [ "$PKGMGR" = "dnf" ];
        then
            sudo dnf install -y  xarchiver menulibre flatpak python3-distutils-extra
            sudo dnf groupinstall -y "Extra plugins for the Xfce panel"
            flatpak install --user -y flathub io.missioncenter.MissionCenter
            install_mugshot    
    fi
}

install_brave_browser(){
    if [ "$PKGMGR" = "rpm-ostree" ];
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
    elif [ "$PKGMGR" = "dnf" ];
        then
            sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
            sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
            sudo dnf update -y
            sudo $PKGMGR install -y brave-browser
   
    fi
}

install_github_desktop(){
    sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'

	sudo $PKGMGR install -y git-gui github-desktop
    if [ "$PKGMGR" = "rpm-ostree" ];
        then
            cd $SCRIPTS_HOME/temp
            curl -L -o shiftkey-gpg.key https://rpm.packages.shiftkey.dev/gpg.key
            chown root:root shiftkey-gpg.key
            sudo mv shiftkey-gpg.key /etc/pki/rpm-gpg/
            
    elif [ "$PKGMGR" = "dnf" ];
        then
            sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
   
    fi
}

install_vscodium(){
    printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo
    if [ "$PKGMGR" = "rpm-ostree" ];
        then
            cd $SCRIPTS_HOME/temp
            curl -L -o vscodium.gpg https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
            chown root:root vscodium.gpg
            sudo mv vscodium.gpg /etc/pki/rpm-gpg/ 
            sudo $PKGMGR install -y codium      
    elif [ "$PKGMGR" = "dnf" ];
        then
            sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
            sudo $PKGMGR install -y codium
   
    fi
}

install_codecs(){
    if [ $VARIANT == "" ] || [ $VARIANT == "kde" ] || [ $VARIANT == "xfce" ]
    then
        sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
        sudo dnf install -y gstreamer1-plugin-openh264 \
	    mozilla-openh264 ffmpeg ffmpeg-libs.i686 ffmpeg-libs

        sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
        sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
    elif [ $VARIANT == "kinoite" ]
    then
        sudo $PKGMGR override remove libavcodec-free libavfilter-free \
        libavformat-free libavutil-free libpostproc-free \
        libswresample-free libswscale-free --install ffmpeg
        
        sudo $PKGMGR install -y gstreamer1-plugin-openh264 \
        mozilla-openh264

        sudo $PKGMGR override remove mesa-va-drivers --install mesa-va-drivers-freeworld
        sudo $PKGMGR install -y mesa-vdpau-drivers-freeworld
    else
        echo "Unkown error has occured."
    fi
}

install_steam(){
    if [ $VARIANT == "" ] || [ $VARIANT == "kde" ] || [ $VARIANT == "xfce" ]
    then
        sudo $PKGMGR install -y steam gamescope
    elif [ $VARIANT == "kinoite" ]
    then
        flatpak install --user -y flathub com.valvesoftware.Steam
        flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
    else
        echo "Unkown error has occured."
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

install_c_cpp(){
    if [ $VARIANT == "" ] || [ $VARIANT == "kde" ] || [ $VARIANT == "xfce" ]
    then
        sudo dnf groupinstall -y "C Development Tools and libraries"
    elif [ $VARIANT == "kinoite" ]
    then
        sudo $PKGMGR install -y gcc-g++ autoconf automake bison\
        flex libtool m4 valgrind byacc ccache cscope indent\
        ltrace perf strace
    else
        echo "Unkown error has occured."
    fi
}

install_rpm_tools(){
    if [ $VARIANT == "" ] || [ $VARIANT == "kde" ] || [ $VARIANT == "xfce" ]
    then
        sudo dnf groupinstall -y "RPM Development Tools"
    elif [ $VARIANT == "kinoite" ]
    then
        sudo $PKGMGR install -y koji mock redhat-rpm-config\
        rpm-build rpmdevtools

    else
        echo "Unkown error has occured."
    fi
}

install_virtualization(){
    if [ $VARIANT == "" ] || [ $VARIANT == "kde" ] || [ $VARIANT == "xfce" ]
    then
        sudo dnf groupinstall -y "Virtualization"
    elif [ $VARIANT == "kinoite" ]
    then
        sudo $PKGMGR install -y libvirt-daemon-config-network\
        libvirt-daemon-daemon-kvm qemu-kvm virt-install\
        virt-manager virt-viewer

    else
        echo "Unkown error has occured."
    fi
    sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
    -O /etc/yum.repos.d/virtio-win.repo
    sudo dnf install -y virtio-win
    sudo usermod -aG libvirt $USER
}

install_scene_builder(){
    cd $SCRIPTS_HOME/temp
    SCENE_BUILDER="SceneBuilder-20.0.0.rpm"
    curl -o $SCENE_BUILDER https://download2.gluonhq.com/scenebuilder/20.0.0/install/linux/SceneBuilder-20.0.0.rpm
    if [ $VARIANT == "" ] || [ $VARIANT == "kde" ] || [ $VARIANT == "xfce" ]
    then
        sudo rpm -i $SCENE_BUILDER
    elif [ $VARIANT == "kinoite" ]
    then
        sudo $PKGMGR install -y $SCENE_BUILDER
    else
        echo "Unkown error has occured."
    fi
}

install_eclipse(){
    cd $SCRIPTS_HOME/temp
    ECLIPSE="eclipse-inst-jre-linux64.tar.gz"
    curl -o $ECLIPSE https://eclipse.mirror.rafal.ca/oomph/epp/2023-09/R/eclipse-inst-jre-linux64.tar.gz

    tar -xvf $ECLIPSE
    ./eclipse-installer/eclipse-inst
}

install_flatpak(){
    if [ $VARIANT == "" ] || [ $VARIANT == "kde" ] || [ $VARIANT == "kinoite" ]
    then
        source $SCRIPTS_HOME/modules/shared.sh; "frepo"
    elif [ $VARIANT == "xfce" ]
    then
        sudo $PKGMGR install -y flatpak
        source $SCRIPTS_HOME/modules/shared.sh; "frepo"
    fi
}

check_if_kinoite(){
    if [ $VARIANT == "kinoite" ]
    then
        confirm_reboot
    fi
}

confirm_reboot(){
    echo "================================================"
    echo "Reboots are required to enable the new layers."
    echo "Do you wish to reboot now?"
    echo "Type y/n or exit"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input == "y" ] || [ $input == "Y" ]
    then
        sudo systemctl reboot
    elif [ $input == "n" ] || [ $input == "N" ]
    then
        echo "Chose not to reboot."
    elif [ $input == "exit" ]
    then
	    exit
    else
	    menu
    fi
}

variant_check(){
    VARIANT=$(source /etc/os-release ; echo $VARIANT_ID)
    if [ $VARIANT == "" ]
    then
        PKGMGR="dnf"
        echo "variant_id in os-release not set. Likely used the net/server install."
        echo "Package manager to $PKGMGR."
        sudo $PKGMGR update -y
    elif [ $VARIANT == "kde" ] || [ $VARIANT == "xfce" ]
    then
        PKGMGR="dnf"
        echo "Fedora spin detected as $VARIANT"
        echo "Setting package manager to dnf."
        sudo dnf clean all && sudo dnf update -y
    elif [ $VARIANT == "kinoite" ]
    then
        PKGMGR="rpm-ostree"
        echo "Fedora spin detected as $VARIANT"
        echo "Package manager to $PKGMGR."
        echo "Please note this is experimental atm"
        sudo $PKGMGR refresh-md
    fi
    echo $VARIANT
}