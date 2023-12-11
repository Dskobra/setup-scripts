#!/usr/bin/bash

fedora_menu(){
    echo "        ---------------------"
    echo "        |       Fedora      |"
    echo "        ---------------------"
    echo ""
    echo "                 Menu"
    echo ""
    echo "1. RPMFusion             2. Flatpak"
    echo "3. Basic Apps            4. Internet"
    echo "5. Multimedia            6. Gaming"
    echo "7. Office                8. Coding"
    echo "9. Extras                10. Upgrade"
    echo "0. Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_rpmfusion"
            check_if_kinoite
            fedora_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_rpmfusion"
            install_flatpak
            fedora_menu
            ;;
        
        3)
            
            basic_menu
            check_if_kinoite
            fedora_menu
            ;;

        4)
            internet_menu
            check_if_kinoite
            fedora_menu
            ;;

        5)
            multimedia_menu
            check_if_kinoite
            fedora_menu
            ;;

        6)
            gaming_menu
            check_if_kinoite
            fedora_menu
            ;;

        7)
            office_menu
            fedora_menu
            ;;
        8)
            coding_menu
            fedora_menu
            ;;

        9)
            extras_menu
            ;;

        10)
            upgrade_menu
            ;;

        0)
            check_if_kinoite
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            fedora_menu
            ;;

        esac
        unset input
        fedora_menu
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

        100)
            fedora_menu
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
    echo "1. Brave Browser          2. Dropbox"
    echo "3. Transmissionbt"
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
            flatpak install --user -y flathub com.dropbox.Client
            ;;

        3)
            flatpak install --user -y flathub com.transmissionbt.Transmission
            internet_menu
            ;;

        100)
            fedora_menu
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
        
        100)
            fedora_menu
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
    echo "100. Main Menu"
    echo "0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            install_steam
            sudo modprobe xpad
            ;;

        2)
            mkdir "$HOME"/Games
            flatpak install --user -y flathub net.lutris.Lutris
            flatpak run net.lutris.Lutris
            mkdir "$HOME"/.config/MangoHud/
            ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/net.lutris.Lutris/config/"
            ;;

        3)
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

        100)
            fedora_menu
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
    echo "1. Libreoffice        2. QOwnNotes"         
    echo "99. Help"
    echo "100. Main Menu        0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            echo "This replaces the fedora providede LibreOffice with"
            echo "the flatpak version."
            sudo $PKMGR remove -y libreoffice
            flatpak install --user -y flathub org.libreoffice.LibreOffice
            ;;

        2)
            flatpak install --user -y flathub org.qownnotes.QOwnNotes
            ;;

        100)
            fedora_menu
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

coding_menu(){
    echo "          -----------"
    echo "          | Coding  |"
    echo "          -----------"
    echo ""
    echo "              Menu"
    echo ""
    echo "1. Runtimes/Compilers     2. IDEs"
    echo "3. GitHub Desktop"
    echo "100. Main Menu      0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            install_limited_dev_tools
            ;;

        2)
            sudo $PKMGR install -y java-17-openjdk-devel
            ;;
        3)
            install_github_desktop
            ;;

        100)
            fedora_menu
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
            fedora_menu
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
            fedora_menu
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
fedora_menu
