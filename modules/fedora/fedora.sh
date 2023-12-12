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
    echo "9. Utilities"
    echo "15. Personalization               16. Upgrade"
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
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_flatpak"
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
            utils_menu
            fedora_menu
            ;;

        16)
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
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_xfce_features"
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
        basic_menu
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
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_brave_browser"
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
        internet_menu
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
    echo "5. K3b                    6. Kolourpaint"
    echo "99. Help"
    echo "100. Main Menu            0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_codecs"
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
            sudo $PKMGR install -y k3b
            multimedia_menu
            ;;
        6)
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
        multimedia_menu
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
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_steam"
            sudo modprobe xpad
            ;;

        2)
            mkdir "$HOME"/Games
            mkdir "$HOME"/.config/MangoHud/
            flatpak install --user -y flathub net.lutris.Lutris
            flatpak run net.lutris.Lutris
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
        gaming_menu
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
            office_menu
            ;;
            
        esac
        unset input
        office_menu
}

coding_menu(){
    echo "          -----------"
    echo "          | Coding  |"
    echo "          -----------"
    echo ""
    echo "              Menu"
    echo ""
    echo "1. Languages        2. IDEs"
    echo "3. GitHub Desktop   4. Containers"
    echo "5. VIM"
    echo "100. Main Menu      0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            languages_menu
            ;;

        2)
            ides_menu
            ;;
        3)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_github_desktop"
            ;;
        4)
            sudo $PKMGR install -y toolbox
            sudo $PKMGR install -y distrobox
            flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
            ;;
        5)
            sudo $PKMGR install -y vim-enhanced
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
        coding_menu
        ;;
        
    esac
    unset input
    coding_menu
}

languages_menu(){
    echo "          -----------"
    echo "          | Coding  |"
    echo "          -----------"
    echo ""
    echo "              Menu"
    echo ""
    echo "1. C/C++            2. openJDK 17"
    echo "3. NodejS LTS       4. Python"
    echo "5. RPM Build Tools"
    echo "100. Main Menu      0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_c_cpp"
            ;;

        2)
            sudo $PKMGR install -y java-17-openjdk-devel
            ;;
        3)
            wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	        source ~/.bashrc
	        nvm install lts/*
            ;;

        4)
            sudo $PKMGR install -y python3-devel
            ;;

        5)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_rpm_tools"
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
        languages_menu
        ;;
        
    esac
    unset input
    languages_menu
}

ides_menu(){
    echo "          -----------"
    echo "          |  IDE's  |"
    echo "          -----------"
    echo ""
    echo "              Menu"
    echo ""
    echo "1. VSCodium         2. Geany"
    echo "3. Python IDLE      4.Eric "
    echo "5. Bluefish         6. Eclipse" 
    echo "7. Scene Builder    8. Codeblocks"
    echo "100. Main Menu      0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_vscodium"
            ;;

        2)
            flatpak install --user -y flathub org.geany.Geany
            ;;
        3)
            sudo $PKMGR install -y python3-idle
            ;;

        4)
            sudo $PKMGR install -y eric
            ;;

        5)
            sudo $PKMGR install -y bluefish  
            ;;

        6)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_eclipse"
            ;;

        7)
            sudo $PKMGR install -y openjfx
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_scene_builder"
            ;;

        8)
            sudo $PKMGR install -y codeblocks codeblocks-contrib-devel
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
        ides_menu
        ;;
        
    esac
    unset input
    ides_menu
}

utils_menu(){
    echo "          -----------"
    echo "          |Utilities|"
    echo "          -----------"
    echo ""
    echo "                       Menu"
    echo ""
    echo "1. Fedora Media Writer        2. KDE ISO Image Writer"
    echo "3. Raspberry Pi Imager        4. Kleopatra"
    echo "5. GtkHash                    6 Flatseal"
    echo "7. Virtualization"
    echo "100. Main Menu                0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            echo ""
            ;;

        2)
            flatpak install --user -y flathub org.kde.isoimagewriter
            ;;

        3)
            flatpak install --user -y flathub org.raspberrypi.rpi-imager
            ;;

        4)
            flatpak install --user -y flathub org.kde.kleopatra
            ;;

        5)
            	flatpak install --user -y flathub org.gtkhash.gtkhash
            ;;

        6)
                flatpak install --user -y flathub com.github.tchx84.Flatseal
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
        utils_menu
        ;;
        
    esac
    unset input
    utils_menu
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

export VARIANT=""
export PKMGR=""
source $SCRIPTS_HOME/modules/fedora/shared.sh; "variant_check"
fedora_menu
