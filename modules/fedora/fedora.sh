#!/usr/bin/bash

fedora_menu(){
    echo "        ---------------------"
    echo "        |       Fedora      |"
    echo "        ---------------------"
    echo ""
    echo "                 Menu"
    echo ""
    echo "(1) Setup RPMFusion       (2) Setup Flatpak"
    echo "(3) Hardware              (4) Desktop Plugins"      
    echo "(5) Internet              (6) Multimedia"
    echo "(7) Gaming                (8) Office"
    echo "(9) Coding                (10) Utilities"
    echo "(11) Extras"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)  
            source $SCRIPTS_HOME/modules/packages/3rd_party_repos.conf
            sudo $PKGMGR install -y $RPMFUSION_FEDORA
            check_if_immutable 
            fedora_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_flatpak"
            fedora_menu
            ;;

        3)
            hardware_menu
            check_if_immutable
            fedora_menu
            ;;

        4)
            desktop_plugins_menu
            check_if_immutable
            fedora_menu
            ;;

        5)
            internet_menu
            fedora_menu
            ;;

        6)
            multimedia_menu
            fedora_menu
            ;;

        7)
            gaming_menu
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

hardware_menu(){
    echo "              ---------------"
    echo "              |   Hardware  |"
    echo "              ---------------"
    echo ""
    echo "AMD/Nvidia drivers"
    echo ""
    echo "                Menu"     
    echo "(1) Corectrl(amd)       (2) Nvidia Driver"
    echo "(3) Cheese(gtk)         (4) Kamoso(Qt)"
    echo "(h) Help"
    echo "(m) Main Menu           (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            sudo $PKGMGR install -y corectrl
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Hardware#amd-cpus-andor-gpus-with-corectrl
            check_if_immutable
            drivers_menu
            ;;

        2)
            sudo $PKGMGR install -y akmod-nvidia xorg-x11-drv-nvidia-cuda nvidia-xconfig nvidia-settings
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Hardware#nvidia
            check_if_immutable
            hardware_menu
            ;;

        3)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_cheese"
            hardware_menu
            ;;

        4)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_kamoso"
            hardware_menu
            ;;
        
        h)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Hardware
            hardware_menu
            ;;

        H)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Hardware
            hardware_menu
            ;;

        m)
            fedora_menu
            ;;
            
        M)
            fedora_menu
            ;;
        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            hardware_menu
            ;;
            
        esac
        unset input
        hardware_menu
}

desktop_plugins_menu(){
    echo "              ------------------------"
    echo "              |   Desktop Plugins  |"
    echo "              ------------------------"
    echo ""
    echo "Extra plugins and misc stuff for specific desktops"
    echo ""
    echo "                Menu"
    echo "(1) KDE                (2) XFCE"
    echo "(3) Mate               (h) Help"     
    echo "(m) Main Menu          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_kdeapps"
            ;;
        
        2)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_xfce_apps"
            ;;

        3)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_mate_apps"
            ;;

        h)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Features
            fedora_menu
            ;;

        H)  
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Features
            fedora_menu
            ;;

        m)
            fedora_menu
            ;;

        M)
            fedora_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            desktop_plugins_menu
            ;;
            
        esac
        unset input
        desktop_plugins_menu
}

internet_menu(){
    echo "              ---------------------"
    echo "              |   Internet Apps   |"
    echo "              --------------------"
    echo ""
    echo "Web browser, cloud storage and bitorrent client."
    echo ""
    echo "                   Menu"
    echo "(1) Firefox                (2) Brave Browser"
    echo "(3) Dropbox                (4) Transmissionbt"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_firefox"
            internet_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_brave_browser"
            internet_menu
            ;;
        
        3)
            source $SCRIPTS_HOME/modules/packages/internet_apps.conf
            flatpak install --user -y $FLATPAK_DROPBOX
            internet_menu
            ;;

        4)
            source $SCRIPTS_HOME/modules/packages/internet_apps.conf
            flatpak install --user -y  $FLATPAK_TRANSMISSION
            internet_menu
            ;;

        m)
            fedora_menu
            ;;

        M)
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
    echo "(1) Codecs                (2) VLC Media Player" 
    echo "(3) OBS Studio            (4) OpenShot" 
    echo "(5) K3b                   (6) Kolourpaint"
    echo "(m) Main Menu             (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_codecs"
            multimedia_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/packages/multimedia_apps.conf
            flatpak install --user -y $FLATPAK_VLC
            multimedia_menu
            ;;
        
        3)
            source $SCRIPTS_HOME/modules/packages/multimedia_apps.conf
            flatpak install --user -y $FLATPAK_OBS
            multimedia_menu
            ;;

        4)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_openshot"
            multimedia_menu
            ;;

        5)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_kthreeb"
            multimedia_menu
            ;;
            
        6)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_kolourpaint"
            multimedia_menu
            ;;
        
        m)
            fedora_menu
            ;;
        
        M)
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
    echo "(1) Steam                  (2) Lutris"
    echo "(3) Mangohud               (4) Protontricks"
    echo "(5) ProtonUp Qt            (6) Discord"
    echo "(7) Solitare               (8) Minecraft"
    echo "(9) WoWUp"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_steam"
            sudo modprobe xpad
            ;;

        2)
            source $SCRIPTS_HOME/modules/packages/gaming_apps.conf
            mkdir "$HOME"/Games
            mkdir "$HOME"/.config/MangoHud/
            
            flatpak install --user -y $FLATPAK_LUTRIS
            flatpak run net.lutris.Lutris
            ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/net.lutris.Lutris/config/"
            ;;

        3)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_mangohud"
            gaming_menu
            ;;

        4)
            source $SCRIPTS_HOME/modules/packages/gaming_apps.conf
            flatpak install --user -y $FLATPAK_PROTONTRICKS
            ;;
        
        5)
            source $SCRIPTS_HOME/modules/packages/gaming_apps.conf
            flatpak install --user -y $FLATPAK_PROTONUP
            ;;

        6)
            source $SCRIPTS_HOME/modules/packages/gaming_apps.conf
            flatpak install --user -y $FLATPAK_DISCORD
            ;;

        7)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_kpat"
            ;;
        
        8)
            source $SCRIPTS_HOME/modules/shared.sh; "minecraft"
            ;;

        9)
            source $SCRIPTS_HOME/modules/shared.sh; "wowup"
            ;;


        m)
            fedora_menu
            ;;

        M)
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
    echo "(1) QOwnNotes          (2) Libreoffice"
    echo "(3) Abiword            (4) Gnumeric"
    echo "(5) KDE Okular         (6) Gnome Evince"
    echo "(7) KDE Ark            (8) Gnome File Roller"
    echo "(9) Claws-Mail         (10) Thunderbird"         
    echo "(m) Main Menu          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/packages/office_apps.conf
            flatpak install --user -y $FLATPAK_QOWNNOTES
            office_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "remove_office"
            source $SCRIPTS_HOME/modules/packages/office_apps.conf
            flatpak install --user -y $FLATPAK_LIBREOFFICE
            office_menu
            ;;

        3)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_abiword"
            office_menu
            ;;
        
        4)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_gnumeric"
            office_menu
            ;;

        5)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_okular"
            office_menu
            ;;

        6)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_evince"
            office_menu
            ;;
        
        7)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_kde_ark"
            office_menu
            ;;

        8)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_file_roller"
            office_menu
            ;;

        9)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_claws_mail"
            office_menu
            ;;
        
        10)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_thunderbird"
            office_menu
            ;;
        
        99) 
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Office-Apps
            ;;

        m)
            fedora_menu
            ;;

        M)
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
    echo "(1) C/C++             (2) Java"
    echo "(3) Web Devlopment    (4) Python"
    echo "(5) GitHub Desktop    (6) Containers"
    echo "(7) Other IDEs"
    echo "(m) Main Menu         (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            cpp_menu
            ;;

        2)
            java_menu
            ;;

        3)
            web_dev_menu
            ;;
        4)
            python_menu
            ;;
        5)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_github_desktop"
            ;;

        6)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_containers"
            
            ;;

        7)
            ides_menu
            ;;

        m)
            fedora_menu
            ;;

        M)
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

cpp_menu(){
    echo "          -------------"
    echo "          |   C/C++   |"
    echo "          -------------"
    echo ""
    echo "              Menu"
    echo ""
    echo "(1) GCC            (2) RPM Build Tools"
    echo "(3) Codeblocks"
    echo "(p) Previous Menu  (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_c_cpp"
            cpp_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_rpm_tools"
            cpp_menu
            ;;

        3)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_codeblocks"
            cpp_menu
            ;;
        
        p)
            coding_menu
            ;;
        
        P)
            coding_menu
            ;;
        
        m)
            fedora_menu
            ;;
        
        M)
            fedora_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        cpp_menu
        ;;
        
    esac
    unset input
    cpp_menu
}

java_menu(){
    echo "          ---------------"
    echo "          |   openJDK   |"
    echo "          ---------------"
    echo ""
    echo "              Menu"
    echo ""
    echo "(1) openJDK 17      (2) Intellij IDEA"
    echo "(3) Netbeans        (4) Scene Builder"
    echo "(p) Previous Menu   (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_java_jdk"
            java_menu
            ;;

        2)
            
            source $SCRIPTS_HOME/modules/shared.sh; "install_idea"
            java_menu
            ;;

        3)  
            source $SCRIPTS_HOME/modules/shared.sh; "install_netbeans"
            java_menu
            ;;

        4)
            sudo $PKGMGR install -y openjfx
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_scene_builder"
            java_menu
            ;;
        p)
            coding_menu
            ;;

        P)
            coding_menu
            ;;

        m)
            fedora_menu
            ;;

        M)
            fedora_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        java_menu
        ;;
        
    esac
    unset input
    java_menu
}

web_dev_menu(){
    echo "          -----------------------"
    echo "          |   Web Development   |"
    echo "          -----------------------"
    echo ""
    echo "              Menu"
    echo ""
    echo "(1) NodejS LTS            (3) LAMP Stack"
    echo "(4) Bluefish"
    echo "(p) Previous Menu         (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/shared.sh; "install_nodejs"
            web_dev_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_lamp_stack"
            ;;

        3)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_bluefish"
            web_dev_menu
            ;;
        
        p)
            coding_menu
            ;;

        P)
            coding_menu
            ;;

        m)
            fedora_menu
            ;;
        
        M)
            fedora_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        cpp_menu
        ;;
        
    esac
    unset input
    cpp_menu
}

python_menu(){
    echo "          --------------"
    echo "          |   Python   |"
    echo "          --------------"
    echo ""
    echo "              Menu"
    echo ""
    echo "(1) Python IDLE           (2) Eric"
    echo "(3) Pycharm"
    echo "(p) Previous Menu         (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_python_tools"
            python_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_eric_ide"
            python_menu
            ;;

        3)
            source $SCRIPTS_HOME/modules/shared.sh; "install_pycharm"
            python_menu
            ;;

        p)
            coding_menu
            ;;

        P)
            coding_menu
            ;;

        m)
            fedora_menu
            ;;
        
        M)
            fedora_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        cpp_menu
        ;;
        
    esac
    unset input
    cpp_menu
}

ides_menu(){
    echo "          -------------------------------"
    echo "          |   Development Environments   |"
    echo "          --------------------------------"
    echo ""
    echo "                      Menu"
    echo ""
    echo "(1) VIM                            (2) VSCodium"
    echo "(3) Geany                          (4) Eclipse"
    echo "(p) Previous Menu                  (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            sudo $PKGMGR install -y vim-enhanced
            ides_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_vscodium"
            ides_menu
            ;;

        3)
            sudo $PKGMGR remove -y geany
            flatpak install --user -y $FLATPAK_GEANY
            ides_menu
            ;;

        4)
            source $SCRIPTS_HOME/modules/shared.sh; "install_eclipse"
            ides_menu
            ;;

        p)
            coding_menu
            ;;

        P)
            coding_menu
            ;;

        m)
            fedora_menu
            ;;

        M)
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
    echo "(1) Fedora Media Writer        (2) KDE ISO Image Writer"
    echo "(3) Raspberry Pi Imager        (4) Kleopatra"
    echo "(5) GtkHash                    (6) Flatseal"
    echo "(7) Virtualization"
    echo "(m) Main Menu                  (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_fmedia_writer"
            utils_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_kde_iso_image_writer"
            utils_menu
            ;;

        3)
            flatpak install --user -y flathub org.raspberrypi.rpi-imager
            utils_menu
            ;;

        4)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "install_kleopatra"
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

        m)
            fedora_menu
            ;;

        M)
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
    echo "(1) Upgrade Helper             (2) Mystuff"
    echo "(3) Remove Codecs              (4) Add user to libvirt group"
    echo "(m) Main Menu                  (0) Exit"
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

        3)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "remove_codecs"
            ;;

        4)
            source $SCRIPTS_HOME/modules/fedora/fedora_packages.sh; "check_for_libvirt_group"
            ;;

        m)
            fedora_menu
            ;;

        M)
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

check_if_immutable(){
    if [ "$VARIANT" == "ostree" ]
    then
        confirm_reboot
    fi
}

confirm_reboot(){
    echo "================================================"
    echo "New RPM packages won't be availble until a "
    echo "restart is performed. Not doing so may"
    echo "result in errors."
    echo "Do you wish to restart now?"
    echo "Type y/n"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input == "y" ] || [ $input == "Y" ]
    then
        sudo systemctl reboot
    elif [ $input == "n" ] || [ $input == "N" ]
    then
        echo "Chose not to reboot."
    else
	    fedora_menu
    fi
}

variant_check(){
    test -f /run/ostree-booted && VARIANT=ostree
    if [ ! -n "$VARIANT" ]
    then
        PKGMGR="dnf"
        echo "Fedora spin not detected as immutable."
        echo "Setting package manager to $PKGMGR."
        #sudo $PKGMGR clean all && sudo $PKGMGR update -y
    elif [ $VARIANT == "ostree" ]
    then
        PKGMGR="rpm-ostree"
        echo "Fedora spin detected as immutable"
        echo "Setting package manager to $PKGMGR."
        echo "Please note this is experimental atm"
        #sudo $PKGMGR refresh-md
    fi
}

old_variant_check(){
    VARIANT=$(source /etc/os-release ; echo $VARIANT_ID)
    if [ ! -n "$VARIANT" ]
    then
        PKGMGR="dnf"
        echo "variant_id in os-release not set. Likely used the net/server install."
        echo "Setting package manager to $PKGMGR."
        #sudo $PKGMGR clean all && sudo $PKGMGR update -y
    elif [ $VARIANT == "kde" ] || [ $VARIANT == "xfce" ] || [ $VARIANT == "matecompiz" ]
    then
        PKGMGR="dnf"
        echo "Fedora spin detected as $VARIANT"
        echo "Setting package manager to dnf."
        #sudo dnf clean all && sudo dnf update -y
    elif [ $VARIANT == "kinoite" ]
    then
        PKGMGR="rpm-ostree"
        echo "Fedora spin detected as $VARIANT"
        echo "Setting package manager to $PKGMGR."
        echo "Please note this is experimental atm"
        #sudo $PKGMGR refresh-md
    fi
}

export VARIANT=""
export PKGMGR=""
variant_check
fedora_menu
