#!/usr/bin/bash

dnf_menu(){
    echo "        ---------------------"
    echo "        |       Fedora      |"
    echo "        ---------------------"
    echo ""
    echo "                 Menu"
    echo ""
    echo "1. RPMFusion             2. Flatpak"
    echo "3. Basic Apps            4. Internet"
    echo "5. Multimedia            6. Gaming"
    echo "7. Office                8. Dev Tools"
    echo "9. Extras                10. Upgrade"
    echo "0. Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            install_rpmfusion
            ;;

        2)
            install_flatpak
            ;;
        
        3)
            basic_menu
            dnf_menu
            ;;

        4)
            internet_menu
            dnf_menu
            ;;

        5)
            multimedia_menu
            dnf_menu
            ;;

        6)
            gaming_menu
            dnf_menu
            ;;

        7)
            office_menu
            dnf_menu
            ;;
        8)
            dev_menu
            dnf_menu
            ;;

        9)
            extras_menu
            ;;

        10)
            upgrade_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            dnf_menu
            ;;

        esac
        unset input
        dnf_menu
}

basic_menu(){
    echo "              --------------------"
    echo "              |Basic Desktop Apps|"
    echo "              --------------------"
    echo ""
    echo "Selection of apps for normal computer use."
    echo ""
    echo "                Menu"
    echo "1. KDE Extras         2. XFCE Extras"        
    echo "3. Corectrl(amd)      4. Nvidia Driver"
    echo "99. Help"
    echo "100. Main Menu        0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            sudo $PKMGR install -y gwenview kate
            basic_menu
            ;;
        
        2)
            install_xfce_features
             basic_menu
            ;;

        3)
            sudo $PKMGR install -y corectrl
             basic_menu
            ;;

        4)
            sudo $PKMGR install -y akmod-nvidia xorg-x11-drv-nvidia-cuda nvidia-xconfig nvidia-settings
            basic_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            basic_menu
            ;;
            
        esac
        unset input
}

internet_menu(){
    echo "              ----------------"
    echo "              |   Internet   |"
    echo "              ----------------"
    echo ""
    echo ""
    echo ""
    echo "                   Menu"
    echo "1. Brave Browser          2. Transmissionbt"
    echo "99. Help"
    echo "100. Main Menu            0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            install_brave_browser
            internet_menu
            ;;

        2)
            flatpak install --user -y flathub com.transmissionbt.Transmission
            internet_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            internet_menu
            ;;
            
        esac
        unset input
}

multimedia_menu(){
    echo "              -----------------------"
    echo "              |   Multimedia Apps   |"
    echo "              -----------------------"
    echo ""
    echo "Various multimedia apps, codecs etc."
    echo ""
    echo "                   Menu"
    echo "1. Codecs                 2. VLC Media Player" 
    echo "3. OBS Studio             4. OpenShot" 
    echo "5. Kolourpaint"
    echo "99. Help"
    echo "100. Main Menu            0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            install_codecs
            multimedia_menu
            ;;

        2)
            flatpak install --user -y flathub org.videolan.VLC
            multimedia_menu
            ;;
        
        3)
            flatpak install --user -y flathub com.obsproject.Studio
            multimedia_menu
            ;;

        4)
            flatpak install --user -y flathub org.openshot.OpenShot
            multimedia_menu
            ;;

        5)
            flatpak install --user -y flathub org.kde.kolourpaint
            multimedia_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            multimedia_menu
            ;;
            
        esac
        unset input
}

gaming_menu(){
    echo "              --------"
    echo "              |Gaming|"
    echo "              --------"
    echo ""
    echo "                Menu"
    echo "1. Steam                  2. Lutris"
    echo "3. Mangohud               4. Protontricks"
    echo "5. ProtonUp Qt            6. Discord"
    echo "7. Solitare               8. Minecraft"
    echo "9. WoWUp"
    echo "9. Main Menu"
    echo "0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            sudo $PKMGR install -y steam gamescope
            sudo modprobe xpad
            ;;

        2)
            flatpak install --user -y flathub net.lutris.Lutris
            flatpak run net.lutris.Lutris
            mkdir "$HOME"/Games
            
            ;;

        3)
            mkdir "$HOME"/.config/MangoHud/
            sudo $PKMGR install -y mangohud goverlay
            flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
            ;;

        4)
            flatpak install --user -y flathub com.github.Matoking.protontricks
            ;;
        
        5)
            flatpak install --user -y flathub net.davidotek.pupgui2
            ;;

        6)
            flatpak install --user -y flathub com.discordapp.Discord
            ;;

        7)
            flatpak install --user -y flathub org.kde.kpat
            ;;
        
        8)
            source $SCRIPTS_HOME/modules/shared.sh; "minecraft"
            ;;

        9)
            source $SCRIPTS_HOME/modules/shared.sh; "wowup"
            ;;
        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            gaming_menu
            ;;
            
        esac
        unset input
}

office_menu(){
    echo "              -------------------"
    echo "              |   Office Apps   |"
    echo "              -------------------"
    echo ""
    echo "Selection of apps for normal computer use."
    echo ""
    echo "                Menu"
    echo "1. Libreoffice        5. QOwnNotes"         
    echo "99. Help"
    echo "100. Main Menu        0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            echo "This installs replaces the fedora providede LibreOffice with"
            echo "the flatpak version."
            sudo $PKMGR remove -y libreoffice
            flatpak install --user -y flathub org.libreoffice.LibreOffice
            ;;

        2)
            flatpak install --user -y flathub org.qownnotes.QOwnNotes
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            basic_menu
            ;;
            
        esac
        unset input
}

dev_menu(){
    echo "          -----------"
    echo "          |Dev Tools|"
    echo "          -----------"
    echo ""
    echo "              Menu"
    echo ""
    echo "1. Limited Tools  2. Full Tools"
    echo "3. Containers"
    echo "9. Main Menu      0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            install_limited_dev_tools
            ;;

        2)
            install_limited_dev_tools
            install_full_dev_tools
            ;;
        3)
            install_container_dev_tools
            ;;

        9)
            dnf_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        dev_menu
        ;;
        
    esac
    unset input
    dev_menu
}

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
    if [ "$PKMGR" = "rpm-ostree" ];
        then
            echo "Immutable variants are unsupported"
    elif [ "$PKMGR" = "dnf" ];
        then
            sudo dnf install -y  xarchiver menulibre flatpak python3-distutils-extra
            sudo dnf groupinstall -y "Extra plugins for the Xfce panel"
            flatpak install --user -y flathub io.missioncenter.MissionCenter
            install_mugshot         
    fi
}

install_brave_browser(){
    if [ "$PKMGR" = "rpm-ostree" ];
        then
            cd $SCRIPTS_HOME/temp
            curl -L -o https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
            sudo chmod root:root brave-browser.repo
            sudo mv brave-browser.repo /etc/yum.repos/

            curl -L -o https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
            sudo chmod root:root brave-core.asc
            sudo mv brave-core.asc /etc/pki/rpm-gpg/

            sudo $PKMGR refresh-md
            sudo $PKMGR install -y brave-browser
    elif [ "$PKMGR" = "dnf" ];
        then
            sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
            sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
            sudo dnf update -y
            sudo $PKMGR install -y brave-browser
   
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
        sudo $PKMGR override remove libavcodec-free libavfilter-free \
        libavformat-free libavutil-free libpostproc-free \
        libswresample-free libswscale-free --install ffmpeg
    
        sudo $PKMGR install -y gstreamer1-plugin-openh264 \
	    mozilla-openh264 ffmpeg-libs.i686

        sudo $PKMGR override remove mesa-va-drivers mesa-va-drivers-freeworld
        sudo $PKMGR install -y mesa-vdpau-drivers-freeworld
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

install_limited_dev_tools(){
	sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
	printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo
	sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'

	sudo dnf install -y codium git-gui github-desktop\
    toolbox distrobox 
    sudo systemctl enable podman
}

install_full_dev_tools(){
    sudo dnf groupinstall -y "C Development Tools and libraries"
    sudo dnf groupinstall -y "Development Tools"
    sudo dnf groupinstall -y "RPM Development Tools"

	sudo dnf install -y java-17-openjdk-devel openjfx python3-devel \
    python3-idle 

    cd $SCRIPTS_HOME/temp
    SCENE_BUILDER="SceneBuilder-20.0.0.rpm"
    curl -o $SCENE_BUILDER https://download2.gluonhq.com/scenebuilder/20.0.0/install/linux/SceneBuilder-20.0.0.rpm
    sudo rpm -i $SCENE_BUILDER

    ECLIPSE="eclipse-inst-jre-linux64.tar.gz"
    curl -o $ECLIPSE https://eclipse.mirror.rafal.ca/oomph/epp/2023-09/R/eclipse-inst-jre-linux64.tar.gz

    tar -xvf $ECLIPSE
    ./eclipse-installer/eclipse-inst
    
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
}

install_container_dev_tools(){
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf groupinstall -y "C Development Tools and libraries"
    sudo dnf groupinstall -y "Development Tools"
    sudo dnf groupinstall -y "RPM Development Tools"

    sudo dnf install -y python python3-devel java-17-openjdk-devel


    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
	

}

extras_menu(){
    echo "              --------"
    echo "              |Extras|"
    echo "              --------"
    echo ""
    echo "                Menu"
    echo ""
    echo "1. Virtualization     2. Corectrl"
    echo "3. Extra Apps         4. Cleanup"
    echo "5. Autostart          9. Main Menu"
    echo "0. Exit"
    printf "Option: "
    read -r input
    case $input in

        1)
            sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
            -O /etc/yum.repos.d/virtio-win.repo
            sudo dnf groupinstall -y "Virtualization"
            sudo dnf install -y virtio-win
            sudo usermod -aG libvirt $USER      # add self to group so i can run without admin. Needed for remotely connecting with qemu
            ;;

        2)
            ;;
        3)
            sudo dnf install -y okular k3b xwaylandvideobridge # needed for video sharing with discord on wayland
            cp 
            source $SCRIPTS_HOME/modules/shared.sh; "fmedia"
            source $SCRIPTS_HOME/modules/shared.sh; "fextras"
            ;;
        4)
            cleanup
            ;;

        5)
            autostart
            ;;

        
        9)
            dnf_menu
            ;;
        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            extras_menu
            ;;

        esac
        unset input
        extras_menu
}

upgrade_menu(){
    echo "              ---------------"
    echo "              |Upgrade Steps|"
    echo "              ---------------"
    echo ""
    echo "                   Menu"
    echo ""
    echo "1. Upgrade                2. Reinstall RPMFusion"
    echo "3. Reinstall Codecs       4. Reinstall Steam"
    echo "5. Update Rescue Kernel   6. Reinstall mugshot"
    echo "9. Main Menu              0. Exit"
    printf "Option: "
    read -r input
    IS_UPGRADE_SAFE="NO"

    case $input in

        1)
            source $SCRIPTS_HOME/modules/shared.sh; "upgrade_check" 
            if [ "$IS_UPGRADE_SAFE" = "YES" ];
                then
                    upgrade_steps
            elif [ "$IS_UPGRADE_SAFE" = "NO" ];
                then
                    remove_rpmfusion
                    upgrade_distro
            fi
            ;;

        2)
            sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
            upgrade_menu
            ;;

        3)
            install_codecs
            upgrade_menu
            ;;

        4)
            sudo dnf install -y steam steam-devices
            upgrade_menu
            ;;

        5)
            update_rescue_kernel
            ;;

        6)
            install_mugshot
            ;;

        9)
            dnf_menu
            ;;
            
        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            upgrade_menu
            ;;
            
        esac
        unset input
}

install_rpmfusion(){
    sudo $PKMGR install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

}

install_flatpak(){
    sudo $PKMGR install -y flatpak
    source $SCRIPTS_HOME/modules/shared.sh; "frepo"
}

remove_rpmfusion(){
    echo "================================================"
    echo "In order for a successful upgrade to occur" 
    echo "RPMFusion and packages from there need to be "
    echo "removed. Settings will be left intact."
    echo "Would you like to do this now?"
    echo "Type y/n or exit"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input == "y" ] || [ $input == "Y" ]
    then
        sudo dnf remove -y steam steam-devices
        sudo dnf swap -y ffmpeg libavcodec-free --allowerasing
        sudo dnf remove -y rpmfusion-free-release rpmfusion-nonfree-release
        sudo dnf clean all
        sudo dnf update -y
    elif [ $input == "n" ] || [ $input == "N" ]
    then
        echo "Chose not to remove."
    elif [ $input == "exit" ]
    then
	    exit
    else
	    upgrade_menu
    fi
}

upgrade_distro(){
    sudo dnf upgrade --refresh
    sudo dnf install dnf-plugin-system-upgrade
    sudo dnf system-upgrade download --releasever=39
    sudo dnf system-upgrade reboot
}

update_rescue_kernel(){
    # For some reason the rescue kernel when updating to a newer Fedora release
    # still lists as the last release in the boot menu. For example f38 after upgrading
    # to f39. This will delete it then reinstall the kernel which will force a rebuild
    # of the rescue image.
    sudo rm /boot/initramfs-0-rescue*.img
    sudo rm /boot/vmlinuz-0-rescue*
    sudo dnf reinstall -y kernel*
}

autostart(){
    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.
    cp /home/$USER/.local/share/flatpak/exports/share/applications/com.dropbox.Client.desktop /home/$USER/.config/autostart/com.dropbox.Client.desktop
    DISCORD="/home/$USER/.local/share/flatpak/exports/share/applications/com.discordapp.Discord.desktop"
    DOVERLAY="/home/$USER/.local/share/flatpak/exports/share/applications/io.github.trigg.discover_overlay.desktop"
    STEAM="/usr/share/applications/steam.desktop"
    CORECTRL="/usr/share/applications/org.corectrl.corectrl.desktop"
    XWVIDEO_BRIDGE="/usr/share/applications/org.kde.xwaylandvideobridge.desktop"

    [ -f $DISCORD ] && { echo "Discord was found. Adding to startup."; cp "$DISCORD"  /home/$USER/.config/autostart/com.discordapp.Discord.desktop; }
    [ -f $DOVERLAY ] && { echo "Discord Overlay was found. Adding to startup."; cp "$DOVERLAY"  /home/$USER/.config/autostart/io.github.trigg.discover_overlay.desktop; }
    [ -f $STEAM ] && { echo "Steam was found. Adding to startup."; cp "$STEAM"  /home/$USER/.config/autostart/steam.desktop; }
    [ -f $CORECTRL ] && { echo "Corectrl was found. Adding to startup."; cp "$CORECTRL"  /home/$USER/.config/autostart/org.corectrl.corectrl.desktop; }
    [ -f $XWVIDEO_BRIDGE ] && { echo "XWaylandVideoBridge was found. Adding to startup."; cp "$XWVIDEO_BRIDGE"  /home/$USER/.config/autostart/org.kde.xwaylandvideobridge.desktop; }

}

cleanup(){
	# Installing Fedora 36 using the everything installer to install the mate desktop with my normal package groups "Development Tools", 
	# "C Development Tools and libraries" and "RPM Development Tools" results in systemd-oomd-defaults also being installed.
	# This creates a package conflict with mate-desktop and mate-desktop-configs when updating. Research shows this is an 
	# uneeded/extra package as Fedora uses earlyoom. So removing systemd-oomd-defaults is perfectly safe. Unsure what causes this
	# to be installed.
	sudo dnf remove -y libreoffice-core \
	gnome-shell-extension-gamemode gnome-text-editor \
	kmahjongg kmines systemd-oomd-defaults \
	transmission-gtk transmission-qt \
	compiz kpat
    sudo rm -r -f $SCRIPTS_HOME/temp
}

variant_check(){
    VARIANT=$(source /etc/os-release ; echo $VARIANT_ID)
    if [ $VARIANT == "" ]
    then
        PKMGR="dnf"
        echo "variant_id in os-release not set. Likely used the net/server install."
        echo "Package manager to $PKMGR."
    elif [ $VARIANT == "kde" ] || [ $VARIANT == "xfce" ]
    then
        echo "Fedora spin detected as $VARIANT"
        echo "Setting package manager to dnf."
        PKMGR="dnf"
    elif [ $VARIANT == "kinoite" ]
    then
        PKMGR="rpm-ostree"
        echo "Fedora spin detected as $VARIANT"
        echo "Package manager to $PKMGR."
        echo "Please note this is experimental atm"
    fi
    echo $variant
}

export VARIANT=""
export PKMGR=""
variant_check
dnf_menu
