#!/usr/bin/bash

fedora_menu(){
    echo "        ---------------------"
    echo "        |       Fedora      |"
    echo "        ---------------------"
    echo ""
    echo "                 Menu"
    echo ""
    echo "1. Setup RPMFusion       2. Setup Flatpak"
    echo "3. Drivers               4. Desktop Features"      
    echo "5. Internet              6. Multimedia"
    echo "7. Gaming                8. Office"
    echo "9. Coding                10. Utilities"
    echo "11. Extras"
    echo "0. Exit"
    printf "Option: "
    read -r input

    case $input in


        1)  
            sudo $PKGMGR install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
            check_if_kinoite
            fedora_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_flatpak"
            fedora_menu
            ;;


        3)
            drivers_menu
            check_if_kinoite
            fedora_menu
            ;;
        4)
            desktop_features_menu
            check_if_kinoite
            fedora_menu
            ;;

        5)
            internet_menu
            check_if_kinoite
            fedora_menu
            ;;

        6)
            multimedia_menu
            check_if_kinoite
            fedora_menu
            ;;

        7)
            gaming_menu
            check_if_kinoite
            fedora_menu
            ;;

        8)
            office_menu
            fedora_menu
            ;;
        9)
            coding_menu
            fedora_menu
            ;;

        10)
            utils_menu
            fedora_menu
            ;;

        11)
            extras_menu
            fedora_menu
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

drivers_menu(){
    echo "              ---------------"
    echo "              |   Drivers   |"
    echo "              ---------------"
    echo ""
    echo "AMD/Nvidia drivers"
    echo ""
    echo "                Menu"     
    echo "1. Corectrl(amd)       2. Nvidia Driver"
    echo "99. Help"
    echo "100. Main Menu        0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            sudo $PKGMGR install -y corectrl
            xdg-open xdg-open https://github.com/Dskobra/setup-scripts/wiki/Basic-Apps#corectrl
            basic_menu
            ;;

        4)
            sudo $PKGMGR install -y akmod-nvidia xorg-x11-drv-nvidia-cuda nvidia-xconfig nvidia-settings
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Basic-Apps#nvidia
            basic_menu
            ;;

        99)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Basic-Apps
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

desktop_features_menu(){
    echo "              ------------------------"
    echo "              |   Desktop Features   |"
    echo "              ------------------------"
    echo ""
    echo "Extra apps and plugins for KDE/XFCE"
    echo ""
    echo "                Menu"
    echo "1. KDE Applications   2. KDE Email/Contacts"
    echo "3. KDE Multimedia "    
    echo "4. XFCE Applications  5. XFCE Plugins"        
    echo "99. Help"
    echo "100. Main Menu        0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_kdeapps"
            desktop_features_menu
            ;;
        
        2)

            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_kdeemail"
            desktop_features_menu
            ;;

        3)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_kdemm"
            desktop_features_menu
            ;;

        4)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_xfce_apps"
            desktop_features_menu
            ;;

        5)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_xfce_plugins"
            desktop_features_menu
            ;;


        99)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Basic-Apps
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
    echo "              ---------------------"
    echo "              |   Internet Apps   |"
    echo "              --------------------"
    echo ""
    echo "Web browser, cloud storage and bitorrent client."
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

        99) 
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Flatpak-substitutes#internet-apps
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
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_openshot"
            multimedia_menu
            ;;

        5)
            sudo $PKGMGR install -y k3b
            multimedia_menu
            ;;
        6)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_kolourpaint"
            multimedia_menu
            ;;

        99)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Flatpak-substitutes#multimedia-apps
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
    echo "              -------------------"
    echo "              |   Gaming Apps   |"
    echo "              -------------------"
    echo ""
    echo "Steam, lutris and other game related apps/games."
    echo ""
    echo "                Menu"
    echo "1. Steam                  2. Lutris"
    echo "3. Mangohud               4. Protontricks"
    echo "5. ProtonUp Qt            6. Discord"
    echo "7. Solitare               8. Minecraft"
    echo "9. WoWUp"
    echo "100. Main Menu            0. Exit"
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
            sudo $PKGMGR install -y mangohud goverlay
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
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_kpat"
            ;;
        
        8)
            source $SCRIPTS_HOME/modules/shared.sh; "minecraft"
            ;;

        9)
            source $SCRIPTS_HOME/modules/shared.sh; "wowup"
            ;;
        
        99)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Gaming-Apps
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
    echo "Office and note taking apps."
    echo ""
    echo "                Menu"
    echo "1. Libreoffice        2. QOwnNotes"         
    echo "99. Help"
    echo "100. Main Menu        0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "remove_office"
            flatpak install --user -y flathub org.libreoffice.LibreOffice
            ;;

        2)
            flatpak install --user -y flathub org.qownnotes.QOwnNotes
            ;;
        
        99) 
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Office-Apps
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
    echo "          -------------------"
    echo "          |   Coding Apps   |"
    echo "          -------------------"
    echo ""
    echo "Mostly IDEs and compilers."
    echo ""
    echo "              Menu"
    echo ""
    echo "1. Languages        2. IDEs"
    echo "3. GitHub Desktop   4. Containers"
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
            sudo $PKGMGR install -y toolbox
            sudo $PKGMGR install -y distrobox
            flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
            ;;

        99)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Coding-Apps
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
    echo "          ----------------------"
    echo "          |   Language Tools   |"
    echo "          ----------------------"
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
            languages_menu
            ;;

        2)
            sudo $PKGMGR install -y java-17-openjdk-devel
            languages_menu
            ;;
        3)
            echo "This downloads the nvm or Node Version Manager script to install"
            echo "the latest nodejs long term support release."
            wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	        source ~/.bashrc
	        nvm install lts/*
            languages_menu
            ;;

        4)
            sudo $PKGMGR install -y python3-devel
            languages_menu
            ;;

        5)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_rpm_tools"
            languages_menu
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
    echo "          -------------------------------"
    echo "          |   Development Environments   |"
    echo "          --------------------------------"
    echo ""
    echo "                      Menu"
    echo ""
    echo "1. VIM                            2. VSCodium"
    echo "3. Geany                          4. Python IDLE"
    echo "5. Eric                           6. Bluefish"
    echo "7. Eclipse                        8. Scene Builder" 
    echo "9. Codeblocks"
    echo "100. Main Menu                    0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            sudo $PKGMGR install -y vim-enhanced
            ides_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_vscodium"
            ides_menu
            ;;

        3)
            sudo $PKGMGR remove -y geany
            flatpak install --user -y flathub org.geany.Geany
            ides_menu
            ;;
        4)
            sudo $PKGMGR install -y python3-idle
            ides_menu
            ;;

        5)
            sudo $PKGMGR install -y eric
            ides_menu
            ;;

        6)
            install_bluefish
            ides_menu
            ;;

        7)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_eclipse"
            ides_menu
            ;;

        8)
            sudo $PKGMGR install -y openjfx
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_scene_builder"
            ides_menu
            ;;

        9)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_codeblocks"
            ides_menu
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
    echo "          -----------------"
    echo "          |   Utilities   |"
    echo "          -----------------"
    echo ""
    echo "Largely apps for image writing and file security."
    echo "Plus virtual machine client."
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
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_fmedia_writer"
            utils_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_kde_iso_image_writer"
            utils_menu
            ;;

        3)
            flatpak install --user -y flathub org.raspberrypi.rpi-imager
            utils_menu
            ;;

        4)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_kleopatra"
            utils_menu
            ;;

        5)
            flatpak install --user -y flathub org.gtkhash.gtkhash
            utils_menu
            ;;

        6)
            flatpak install --user -y flathub com.github.tchx84.Flatseal
            utils_menu
            ;;
        
        7)
            install_virtualization
            utils_menu
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

extras_menu(){
    echo "          --------------"
    echo "          |   Extras   |"
    echo "          --------------"
    echo ""
    echo "Upgrade helper and script for my personal configurations"
    echo "                       Menu"
    echo ""
    echo "1. Upgrade Helper             2. Mystuff"
    echo "100. Main Menu                0. Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/fedora/upgrade_helper.sh; "launch_menu"
            extras_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/fedora/mystuff.sh; "mystuff_menu"
            extras_menu
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
    extras_menu
}

export VARIANT=""
export PKGMGR=""
source $SCRIPTS_HOME/modules/fedora/shared.sh; "variant_check"
fedora_menu
