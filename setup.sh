#!/usr/bin/bash

launch(){
    test -d $SCRIPTS_HOME/temp && TEMP_FOLDER=exists
    if [ "$TEMP_FOLDER" = "exists" ];
        then
           TEMP_FOLDER=exists 
    elif [ "$TEMP_FOLDER" = "missing" ];
        then
        mkdir $SCRIPTS_HOME/temp        # make a temp folder for all files to be downloaded to   
    fi
    distro_check
}

distro_check(){
    DISTRO=$(source /etc/os-release ; echo $ID)
    if [ $DISTRO == "fedora" ]
    then
        fedora_variant_check
    elif [ $DISTRO == "opensuse-tumbleweed" ]
    then
        PKGMGR="zypper"
        check_for_git
        check_for_wget
        check_for_curl
        check_for_dos2unix
        get_data
        display_third_party_repos
        main_menu
    elif [ $DISTRO == "debian" ]
    then
        PKGMGR="apt-get"
        check_for_git
        check_for_wget
        check_for_curl
        check_for_dos2unix
        get_data
        display_third_party_repos
        main_menu
    else
        echo "Unsupported distro"
    fi

}

fedora_variant_check(){
    test -f /run/ostree-booted && VARIANT=ostree
    if [ ! -n "$VARIANT" ]
    then
        PKGMGR="dnf"
        check_for_git
        check_for_wget
        check_for_curl
        check_for_dos2unix
        get_data
        display_third_party_repos
        main_menu
    elif [ $VARIANT == "ostree" ]
    then
        PKGMGR="rpm-ostree"
        check_for_dos2unix
        get_data
        display_third_party_repos
        main_menu
    fi
}

check_if_fedora_immutable(){
    if [ "$PKGMGR" == "rpm-ostree" ]
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
	    main_menu
    fi
}

check_for_git(){
    test -f /usr/bin/git && GITCHECK="exists"
    if [ "$GITCHECK" = "exists" ];
        then
           GITCHECK=exists 
    elif [ "$GITCHECK" = "missing" ];
        then
        echo "git not found. Will install it."
        install_git
    fi
}

check_for_wget(){
    test -f /usr/bin/wget && WGETCHECK="exists"
    if [ "$WGETCHECK" = "exists" ];
        then
           WGETCHECK="exists" 
    elif [ "$WGETCHECK" = "missing" ];
        then
        echo "wget not found. Will install it."
        install_wget
    fi
}

check_for_curl(){
    test -f /usr/bin/curl && CURLCHECK="exists"
    if [ "$CURLCHECK" = "exists" ];
        then
           CURLCHECK="exists" 
    elif [ "$CURLCHECK" = "missing" ];
        then
        echo "curl not found. Will install it."
        install_curl
    fi
}

check_for_dos2unix(){
    test -f /usr/bin/dos2unix && DOS2UNIXCHECK="exists"
    if [ "$DOS2UNIXCHECK" = "exists" ];
        then
           DOS2UNIXCHECK=exists 
    elif [ "$DOS2UNIXCHECK" = "missing" ];
        then
        echo "dos2unix not found. Will install it."
        install_dos2unix
    fi
}

install_git(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y git
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install git
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y git
    else
        echo "Unkown error has occured."
    fi
}

install_wget(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y wget
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install wget
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y wget
    else
        echo "Unkown error has occured."
    fi
}

install_curl(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y curl
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install curl
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y curl
    else
        echo "Unkown error has occured."
    fi
}

install_dos2unix(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y dos2unix
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install dos2unix
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install dos2unix
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y dos2unix
    else
        echo "Unkown error has occured."
    fi
}

display_third_party_repos(){
    if [ "$PKGMGR" == "dnf" ] || [ "$PKGMGR" = "rpm-ostree" ]
    then
        THIRD_PARTY_REPO="RPMFusion"
    elif [ $PKGMGR == "zypper" ]
    then
        THIRD_PARTY_REPO="Packman Essentials"
    elif [ $PKGMGR == "apt-get" ]
    then
        THIRD_PARTY_REPO="contrib non-free"
    fi
}

main_menu(){
    echo "---------------------------"   
    echo "|   DSK's Setup Scripts   |"
    echo "---------------------------" 
    echo ""
    echo "Version: $VERSION"
    echo "Copyright (c) 2021-2023 Jordan Bottoms"
    echo "Released under the MIT license"
    echo ""
    echo "OS Name: $OS_NAME"
    echo "Package Manager: $PKGMGR"
    echo "3rd Party Repo is: $THIRD_PARTY_REPO"
    echo ""
    echo ""
    echo "(1) 3rd Party Repo                (2) Setup Flatpak"
    echo "(3) Hardware                      (4) Desktop Plugins"      
    echo "(5) Internet                      (6) Multimedia"
    echo "(7) Gaming                        (8) Office"
    echo "(9) Coding                        (10) Utilities"
    echo "(11) Extras"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)  
            source $SCRIPTS_HOME/data/packages.sh; "install_third_party_repos"
            main_menu
            ;;

        2)
            source $SCRIPTS_HOME/data/packages.sh; "install_flatpak"
            main_menu
            ;;

        3)
            hardware_menu
            main_menu
            ;;

        4)
            desktop_plugins_menu
            main_menu
            ;;

        5)
            internet_menu
            main_menu
            ;;

        6)
            multimedia_menu
            main_menu
            ;;

        7)
            gaming_menu
            main_menu
            ;;

        8)
            office_menu
            main_menu
            ;;
        9)
            coding_menu
            main_menu
            ;;

        10)
            utils_menu
            main_menu
            ;;

        11)
            extras_menu
            main_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            main_menu
            ;;

        esac
        unset input
        main_menu
}

hardware_menu(){
    echo "----------------"
    echo "|   Hardware   |"
    echo "----------------"
    echo ""
    echo "AMD/Nvidia drivers"
    echo ""
    echo ""     
    echo "(1) Corectrl(amd)       (2) Nvidia Driver"
    echo "(3) Cheese(gtk)         (4) Kamoso(Qt)"
    echo "(h) Help"
    echo "(m) Main Menu           (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/data/packages.sh; "install_corectrl"
            hardware_menu
            ;;

        2)
            source $SCRIPTS_HOME/data/packages.sh; "install_nvidia"
            hardware_menu
            ;;

        3)
            source $SCRIPTS_HOME/data/packages.sh; "install_cheese"
            hardware_menu
            ;;

        4)
            source $SCRIPTS_HOME/data/packages.sh; "install_kamoso"
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
            main_menu
            ;;
            
        M)
            main_menu
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
    echo "-----------------------"
    echo "|   Desktop Plugins   |"
    echo "-----------------------"
    echo ""
    echo "Extra plugins and misc stuff for specific desktops"
    echo ""
    echo ""   
    echo "(1) KDE                (2) XFCE"
    echo "(3) Mate               (h) Help"     
    echo "(m) Main Menu          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/data/packages.sh; "install_kdeapps"
            ;;
        
        2)
            source $SCRIPTS_HOME/data/packages.sh; "install_xfce_apps"
            ;;

        3)
            source $SCRIPTS_HOME/data/packages.sh; "install_mate_apps"
            ;;

        h)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Features
            main_menu
            ;;

        H)  
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Features
            main_menu
            ;;

        m)
            main_menu
            ;;

        M)
            main_menu
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
    echo "----------------"
    echo "|   Internet   |"
    echo "----------------"
    echo ""
    echo "Web browsers, cloud storage and bitorrent client."
    echo ""
    echo ""   
    echo "(1) Firefox                (2) Brave Browser"
    echo "(3) Dropbox                (4) Transmissionbt"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/data/packages.sh; "install_firefox"
            internet_menu
            ;;

        2)
            source $SCRIPTS_HOME/data/packages.sh; "install_brave_browser"
            internet_menu
            ;;
        
        3)
            flatpak install --user -y flathub com.dropbox.Client
            internet_menu
            ;;

        4)
            flatpak install --user -y  flathub com.transmissionbt.Transmission
            internet_menu
            ;;

        m)
            main_menu
            ;;

        M)
            main_menu
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
    echo "------------------"
    echo "|   Multimedia   |"
    echo "------------------"
    echo ""
    echo "Various multimedia apps, codecs etc."
    echo ""
    echo ""   
    echo "(1) Codecs                (2) VLC Media Player" 
    echo "(3) OBS Studio            (4) OpenShot" 
    echo "(5) K3b                   (6) Kolourpaint"
    echo "(m) Main Menu             (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/data/packages.sh; "install_codecs"
            multimedia_menu
            ;;

        2)
            flatpak install --user -y flathub org.videolan.VLC
            multimedia_menu
            ;;
        
        3)
            flatpak install --user -y flathub com.obsproject.Studio
            install_openshot
            multimedia_menu
            ;;

        4)
            source $SCRIPTS_HOME/data/packages.sh; "install_openshot"
            multimedia_menu
            ;;

        5)
            source $SCRIPTS_HOME/data/packages.sh; "install_kthreeb"
            multimedia_menu
            ;;
            
        6)
            source $SCRIPTS_HOME/data/packages.sh; "install_kolourpaint"
            multimedia_menu
            ;;
        
        m)
            main_menu
            ;;
        
        M)
            main_menu
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
    echo "--------------"
    echo "|   Gaming   |"
    echo "--------------"
    echo ""
    echo "Steam, lutris and other game related apps/games."
    echo ""
    echo ""   
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
            source $SCRIPTS_HOME/data/packages.sh; "install_steam"
            ;;

        2) 
            mkdir "$HOME"/Games       
            flatpak install --user -y flathub net.lutris.Lutris
            flatpak run net.lutris.Lutris
            ;;

        3)
            source $SCRIPTS_HOME/data/packages.sh; "install_mangohud"
            gaming_menu
            ;;

        4)
            flatpak install --user -y com.github.Matoking.protontricks
            ;;
        
        5)
            flatpak install --user -y flathub net.davidotek.pupgui2
            ;;

        6)
            flatpak install --user -y flathub com.discordapp.Discord
            ;;

        7)
            source $SCRIPTS_HOME/data/packages.sh; "install_kpat"
            ;;
        
        8)
            source $SCRIPTS_HOME/data/packages.sh; "minecraft"
            ;;

        9)
            source $SCRIPTS_HOME/data/packages.sh; "wowup"
            ;;


        m)
            main_menu
            ;;

        M)
            main_menu
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
    echo "--------------"
    echo "|   Office   |"
    echo "--------------"
    echo ""
    echo "Office and note taking apps."
    echo ""
    echo ""   
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
            flatpak install --user -y flathub org.qownnotes.QOwnNotes
            office_menu
            ;;

        2)
            source $SCRIPTS_HOME/data/packages.sh; "remove_office"
            flatpak install --user -y flathub org.libreoffice.LibreOffice
            check_if_fedora_immutable
            office_menu
            ;;

        3)
            source $SCRIPTS_HOME/data/packages.sh; "install_abiword"
            office_menu
            ;;
        
        4)
            source $SCRIPTS_HOME/data/packages.sh; "install_gnumeric"
            office_menu
            ;;

        5)
            source $SCRIPTS_HOME/data/packages.sh; "install_okular"
            office_menu
            ;;

        6)
            source $SCRIPTS_HOME/data/packages.sh; "install_evince"
            office_menu
            ;;
        
        7)
            source $SCRIPTS_HOME/data/packages.sh; "install_kde_ark"
            office_menu
            ;;

        8)
            source $SCRIPTS_HOME/data/packages.sh; "install_file_roller"
            office_menu
            ;;

        9)
            source $SCRIPTS_HOME/data/packages.sh; "install_claws_mail"
            office_menu
            ;;
        
        10)
            source $SCRIPTS_HOME/data/packages.sh; "install_thunderbird"
            office_menu
            ;;
        
        99) 
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Office-Apps
            ;;

        m)
            main_menu
            ;;

        M)
            main_menu
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
    echo "--------------"
    echo "|   Coding   |"
    echo "--------------"
    echo ""
    echo "Mostly IDEs and compilers."
    echo ""
    echo ""   
    echo ""
    echo "(1) C/C++             (2) openJDK"
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
            openjdk_menu
            ;;

        3)
            web_dev_menu
            ;;
        4)
            python_menu
            ;;
        5)
            source $SCRIPTS_HOME/data/packages.sh; "install_github_desktop"
            ;;

        6)
            source $SCRIPTS_HOME/data/packages.sh; "install_containers"
            
            ;;

        7)
            ides_menu
            ;;

        m)
            main_menu
            ;;

        M)
            main_menu
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
    echo "-------------"
    echo "|   C/C++   |"
    echo "-------------"
    echo ""
    echo ""   
    echo ""
    echo "(1) GCC            (2) Package Build Tools"
    echo "(3) Codeblocks"
    echo "(p) Previous Menu  (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/data/packages.sh; "install_c_cpp"
            cpp_menu
            ;;

        2)
            source $SCRIPTS_HOME/data/packages.sh; "install_package_tools"
            cpp_menu
            ;;

        3)
            source $SCRIPTS_HOME/data/packages.sh; "install_codeblocks"
            cpp_menu
            ;;
        
        p)
            coding_menu
            ;;
        
        P)
            coding_menu
            ;;
        
        m)
            main_menu
            ;;
        
        M)
            main_menu
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

openjdk_menu(){
    echo "---------------"
    echo "|   openJDK   |"
    echo " --------------"
    echo ""
    echo ""   
    echo ""
    echo "(1) openJDK 17      (2) Intellij IDEA"
    echo "(3) Netbeans        (4) Scene Builder"
    echo "(p) Previous Menu   (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/data/packages.sh; "install_java_jdk"
            java_menu
            ;;

        2)
            
            source $SCRIPTS_HOME/data/packages.sh; "install_idea"
            java_menu
            ;;

        3)  
            source $SCRIPTS_HOME/data/packages.sh; "install_netbeans"
            java_menu
            ;;

        4)
            source $SCRIPTS_HOME/data/packages.sh; "install_scene_builder"
            java_menu
            ;;
        p)
            coding_menu
            ;;

        P)
            coding_menu
            ;;

        m)
            main_menu
            ;;

        M)
            main_menu
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
    echo "-----------------------"
    echo "|   Web Development   |"
    echo "-----------------------"
    echo ""
    echo ""
    echo ""   
    echo "(1) NodejS LTS            (2) LAMP Stack"
    echo "(3) Bluefish"
    echo "(p) Previous Menu         (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/data/packages.sh; "install_nodejs"
            web_dev_menu
            ;;

        2)
            source $SCRIPTS_HOME/data/packages.sh; "install_lamp_stack"
            web_dev_menu
            ;;

        3)
            source $SCRIPTS_HOME/data/packages.sh; "install_bluefish"
            web_dev_menu
            ;;
        
        p)
            coding_menu
            ;;

        P)
            coding_menu
            ;;

        m)
            main_menu
            ;;
        
        M)
            main_menu
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
    echo "--------------"
    echo "|   Python   |"
    echo "--------------"
    echo ""
    echo ""
    echo ""   
    echo "(1) Python IDLE           (2) Eric"
    echo "(3) Pycharm"
    echo "(p) Previous Menu         (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/data/packages.sh; "install_python_tools"
            python_menu
            ;;

        2)
            source $SCRIPTS_HOME/data/packages.sh; "install_eric_ide"
            python_menu
            ;;

        3)
            source $SCRIPTS_HOME/data/packages.sh; "install_pycharm"
            python_menu
            ;;

        p)
            coding_menu
            ;;

        P)
            coding_menu
            ;;

        m)
            main_menu
            ;;
        
        M)
            main_menu
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
    echo "------------"
    echo "|   IDEs   |"
    echo "------------"
    echo ""
    echo ""
    echo ""   
    echo "(1) VIM                            (2) VSCodium"
    echo "(3) Geany                          (4) Eclipse"
    echo "(p) Previous Menu                  (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/data/packages.sh; "install_vim"
            ides_menu
            ;;

        2)
            source $SCRIPTS_HOME/data/packages.sh; "install_vscodium"
            ides_menu
            ;;

        3)
            source $SCRIPTS_HOME/data/packages.sh; "install_geany"
            ides_menu
            ;;

        4)
            source $SCRIPTS_HOME/data/packages.sh; "install_eclipse"
            ides_menu
            ;;

        p)
            coding_menu
            ;;

        P)
            coding_menu
            ;;

        m)
            main_menu
            ;;

        M)
            main_menu
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
    echo "-----------------"
    echo "|   Utilities   |"
    echo "-----------------"
    echo ""
    echo "Largely apps for image writing and file security."
    echo "Plus virtual machine client."
    echo ""
    echo ""
    echo ""   
    echo "(1) Fedora Media Writer        (2) KDE ISO Image Writer"
    echo "(3) Raspberry Pi Imager        (4) Kleopatra"
    echo "(5) GtkHash                    (6) Flatseal"
    echo "(7) MissionCenter              (8) Virtualization"
    echo "(m) Main Menu                  (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/data/packages.sh; "install_fmedia_writer"
            utils_menu
            ;;

        2)
            source $SCRIPTS_HOME/data/packages.sh; "install_kde_iso_image_writer"
            utils_menu
            ;;

        3)
            flatpak install --user -y flathub org.raspberrypi.rpi-imager
            utils_menu
            ;;

        4)
            source $SCRIPTS_HOME/data/packages.sh; "install_kleopatra"
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
            flatpak install --user -y flathub io.missioncenter.MissionCenter
            utils_menu
            ;;
        
        8)
            source $SCRIPTS_HOME/data/packages.sh; "install_virtualization"
            utils_menu
            ;;

        m)
            main_menu
            ;;

        M)
            main_menu
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
    echo "--------------"
    echo "|   Extras   |"
    echo "--------------"
    echo ""
    echo "Upgrade helper and script for my personal configurations"
    echo ""
    echo ""   
    echo "(1) Fedora Upgrade Helper      (2) Configurations"
    echo "(3) DSKs Stuff                 (4) Remove Codecs"
    echo "(m) Main Menu                  (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/data/fedora_upgrade_helper.sh; "launch_menu"
            extras_menu
            ;;

        2)
            configurations_menu
            ;;

        3)
            source $SCRIPTS_HOME/data/dsksstuff.sh; "dsksstuff_menu"
            extras_menu
            ;;

        4)
            source $SCRIPTS_HOME/data/packages.sh; "remove_codecs"
            ;;

        m)
            main_menu
            ;;

        M)
            main_menu
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

configurations_menu(){
    echo "----------------------"
    echo "|   Configurations   |"
    echo "----------------------"
    echo ""
    echo ""
    echo ""
    echo ""   
    echo "(1) Setup xbox controller      (2) Add user to libvirt group"
    echo "(3) Link Mangohud to Lutris"
    echo "(p) Previous Menu              (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            sudo modprobe xpad
            configurations_menu
            ;;

        2)
            source $SCRIPTS_HOME/data/packages.sh; "check_for_libvirt_group"
            configurations_menu
            ;;

        3)
            mkdir "$HOME"/.config/MangoHud/
            ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/net.lutris.Lutris/config/"
            ;;

        p)
            extras_menu
            ;;

        P)
            extras_menu
            ;;

        m)
            main_menu
            ;;

        M)
            main_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        configurations_menu
        ;;
        
    esac
    unset input
    configurations_menu
}

get_data(){
    cd $SCRIPTS_HOME/temp
    git clone https://github.com/Dskobra/setup-scripts -b data
}
export SCRIPTS_HOME=$(pwd)
OS_NAME=$(source /etc/os-release ; echo $NAME)
VERSION="dev branch"
TEMP_FOLDER="missing"
GITCHECK="missing"
WGETCHECK="missing"
CURLCHECK="missing"
DOS2UNIXCHECK="missing"
DISTRO=""
PKGMGR=""
VARIANT=""
launch