#!/usr/bin/bash

### This is the main script that contians all the menus,
### and code for determining the distro.
make_temp(){
    test -d $SCRIPTS_HOME/temp && TEMP_FOLDER=exists
    if [ "$TEMP_FOLDER" = "exists" ];
        then
           TEMP_FOLDER=exists 
    elif [ "$TEMP_FOLDER" = "missing" ];
        then
        mkdir $SCRIPTS_HOME/temp        # make a temp folder for all files to be downloaded to   
    fi
}

make_app_folder(){
    # desktops like xfce might not have the applications folder created. 
    # Which is needed for menu shortcuts.
    mkdir -p $HOME/.local/share/applications/       
    test -d /opt/AppInstalls/ && APP_FOLDER=exists
    if [ "$APP_FOLDER" = "exists" ];
        then
           APP_FOLDER=exists 
    elif [ "$APP_FOLDER" = "missing" ];
        then
        sudo mkdir /opt/AppInstalls/
        sudo mkdir /opt/AppInstalls/launchers # store launch scripts
        sudo mkdir /opt/AppInstalls/data      # store program folders etc
        sudo mkdir /opt/AppInstalls/icons

        sudo chown $USER:$USER /opt/AppInstalls -R  # make current user owner so its writable  
    fi
}

distro_check(){
    DISTRO=$(source /etc/os-release ; echo $ID)
    if [ $DISTRO == "fedora" ]
    then
        fedora_variant_check
    elif [ $DISTRO == "opensuse-tumbleweed" ]
    then
        PKGMGR="zypper"
        deps_check
        #check_for_git
        #check_for_wget
        #check_for_curl
        #check_for_zenity
        get_data
        display_third_party_repos
        main_menu
    elif [ $DISTRO == "debian" ]
    then
        PKGMGR="apt-get"
        deps_check
        #check_for_git
        #check_for_wget
        #check_for_curl
        #check_for_zenity
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
        deps_check
        #check_for_git
        #check_for_wget
        #check_for_curl
        #check_for_zenity
        get_data
        display_third_party_repos
        main_menu
    elif [ $VARIANT == "ostree" ]
    then
        PKGMGR="rpm-ostree"
        deps_check
        #check_for_zenity
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

deps_check(){
    test -f /usr/bin/git && GITCHECK="exists"
    if [ "$GITCHECK" = "exists" ];
        then
           GITCHECK=exists 
    elif [ "$GITCHECK" = "missing" ];
        then
        echo "git not found. Will install it."
        install_git
    fi
    
    test -f /usr/bin/zenity && ZENITYCHECK="exists"
    if [ "$ZENITYCHECK" = "exists" ];
        then
           ZENITYCHECK=exists 
    elif [ "$ZENITYCHECK" = "missing" ];
        then
        echo "zenity not found. Will install it."
        install_zenity
    fi

    test -f /usr/bin/wget && WGETCHECK="exists"
    if [ "$WGETCHECK" = "exists" ];
        then
           WGETCHECK="exists" 
    elif [ "$WGETCHECK" = "missing" ];
        then
        echo "wget not found. Will install it."
        install_wget
    fi

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

check_for_zenity(){
    test -f /usr/bin/zenity && ZENITYCHECK="exists"
    if [ "$ZENITYCHECK" = "exists" ];
        then
           ZENITYCHECK=exists 
    elif [ "$ZENITYCHECK" = "missing" ];
        then
        echo "zenity not found. Will install it."
        install_zenity
    fi
}

get_data(){
    echo "Will need to download extra files from data branch"
    cd $SCRIPTS_HOME
    rm -r -f data
    git clone https://github.com/Dskobra/setup-scripts -b data
    mv $SCRIPTS_HOME/setup-scripts $SCRIPTS_HOME/data
}

install_git(){
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
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y dos2unix
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install dos2unix
        sudo rpm-ostree apply-live
        #check_if_fedora_immutable
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

install_zenity(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y zenity
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install zenity
        sudo rpm-ostree apply-live
        #check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install zenity
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y zenity
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
            source $SCRIPTS_HOME/packages.sh; "install_third_party_repos"
            main_menu
            ;;

        2)
            source $SCRIPTS_HOME/packages.sh; "install_flatpak"
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
            source $SCRIPTS_HOME/packages.sh; "install_corectrl"
            ;;

        2)
            source $SCRIPTS_HOME/packages.sh; "install_nvidia"
            ;;

        3)
            source $SCRIPTS_HOME/packages.sh; "install_cheese"
            ;;

        4)
            source $SCRIPTS_HOME/packages.sh; "install_kamoso"
            ;;
        
        h)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Hardware
            ;;

        H)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Hardware
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
            source $SCRIPTS_HOME/packages.sh; "install_kdeapps"
            ;;
        
        2)
            source $SCRIPTS_HOME/packages.sh; "install_xfce_apps"
            ;;

        3)
            source $SCRIPTS_HOME/packages.sh; "install_mate_apps"
            ;;

        h)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Features
            ;;

        H)  
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Features
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
            source $SCRIPTS_HOME/packages.sh; "install_firefox"
            ;;

        2)
            source $SCRIPTS_HOME/packages.sh; "install_brave_browser"
            ;;
        
        3)
            flatpak install --user -y flathub com.dropbox.Client
            ;;

        4)
            flatpak install --user -y  flathub com.transmissionbt.Transmission
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
    echo "(7) OBS Virtual Camera Driver"
    echo "(m) Main Menu             (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/packages.sh; "install_codecs"
            ;;

        2)
            flatpak install --user -y flathub org.videolan.VLC
            ;;
        
        3)
            flatpak install --user -y flathub com.obsproject.Studio
            ;;

        4)
            source $SCRIPTS_HOME/packages.sh; "install_openshot"
            ;;

        5)
            source $SCRIPTS_HOME/packages.sh; "install_kthreeb"
            ;;
            
        6)
            source $SCRIPTS_HOME/packages.sh; "install_kolourpaint"
            ;;

        7)
            source $SCRIPTS_HOME/packages.sh; "install_v4l2loopback"
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
    echo "Game clients and other apps"
    echo ""
    echo ""   
    echo "(1) Game Clients           (2) Tools"
    echo "(3) WoW Clients            (4) Emulators"
    echo "(5) Discord                (6) Solitare"
    echo "(7) Minecraft"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            gaming_clients_menu
            ;;

        2) 
            gaming_tools_menu
            ;;

        3)
            gaming_wow_clients_menu
            ;;

        4)
            emulators_menu
            ;;

        5)
            flatpak install --user -y flathub com.discordapp.Discord
            ;;
        
        6)
            source $SCRIPTS_HOME/packages.sh; "install_kpat"
            ;;

        7)
            source $SCRIPTS_HOME/packages.sh; "download_minecraft"
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

gaming_clients_menu(){
    echo "----------------------"
    echo "|   Gaming Clients   |"
    echo "---------------- ------"
    echo ""
    echo "Steam, lutris and bottles"
    echo ""
    echo ""   
    echo "(1) Steam                  (2) Lutris"
    echo "(3) Bottles"
    echo "(p) Previous Menu          (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            source $SCRIPTS_HOME/packages.sh; "install_steam"
            ;;

        2) 
            mkdir "$HOME"/Games       
            flatpak install --user -y flathub net.lutris.Lutris
            flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro
            flatpak run net.lutris.Lutris
            ;;

        3)
            flatpak install --user -y flathub com.usebottles.bottles
            flatpak override com.usebottles.bottles --user --filesystem=xdg-config/MangoHud:ro
            ;;

        p)
            gaming_menu
            ;;

        P)
            gaming_menu
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
            gaming_clients_menu
            ;;
            
        esac
        unset input
        gaming_clients_menu
}

gaming_tools_menu(){
    echo "--------------------"
    echo "|   Gaming Tools   |"
    echo "--------------------"
    echo ""
    echo "Mangohud and proton tools"
    echo ""
    echo ""   
    echo "(1) Mangohud               (2) Protontricks"
    echo "(3) ProtonUp Qt"
    echo "(p) Previous Menu          (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/packages.sh; "install_mangohud"
            ;;

        2)
            flatpak install --user -y com.github.Matoking.protontricks
            ;;
        
        3)
            flatpak install --user -y flathub net.davidotek.pupgui2
            ;;

        p)
            gaming_menu
            ;;
        
        P)
            gaming_menu
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
            gaming_tools_menu
            ;;
            
        esac
        unset input
        gaming_tools_menu
}

gaming_wow_clients_menu(){
    echo "----------------------"
    echo "|  Clients  for WoW   |"
    echo "---------------- ------"
    echo ""
    echo "Addon managers and extra stuff for World of Warcraft"
    echo ""
    echo ""   
    echo "(1) WoW UP                 (2) Warcraft Logs"
    echo "(3) Raider.IO              (4) Weak Auras Companion"
    echo "(p) Previous Menu          (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            source $SCRIPTS_HOME/packages.sh; "download_wowup"
            ;;

        2) 
            source $SCRIPTS_HOME/packages.sh; "download_warcraft_logs"
            ;;

        3)
            WARNING_ONE="Raider.IO uses a CDN which prevents this script from downloading."
            WARNING_TWO="Clicking OK will take you to the web page."
            zenity --warning --text="$WARNING_ONE $WARNING_TWO"
            xdg-open "https://raider.io/addon"
            source $SCRIPTS_HOME/packages.sh; "download_raiderio"

            ;;

        4)
            source $SCRIPTS_HOME/packages.sh; "download_weakauras_companion"
            ;;

        p)
            gaming_menu
            ;;

        P)
            gaming_menu
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
            gaming_wow_clients_menu
            ;;
            
        esac
        unset input
        gaming_wow_clients_menu
}

emulators_menu(){
    echo "-----------------"
    echo "|   Emulators   |"
    echo "-----------------"
    echo ""
    echo ""
    echo ""
    echo ""   
    echo "(1) Dolphin                (2) Cemu"
    echo "(p) Previous Menu          (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            flatpak install --user -y flathub org.DolphinEmu.dolphin-emu
            emulators_menu
            ;;

        2) 
            source $SCRIPTS_HOME/packages.sh; "download_cemu"
            emulators_menu
            ;;

        m)
            main_menu
            ;;

        p)
            gaming_menu
            ;;

        P)
            gaming_menu
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
            emulators_menu
            ;;
            
        esac
        unset input
        emulators_menu
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
    echo "(3) KDE Okular         (4) Gnome Evince"
    echo "(5) KDE Ark            (6) Gnome File Roller"
    echo "(7) Claws-Mail         (8) Thunderbird"
    echo "(9) Bitwarden          (10) KeePassXC"         
    echo "(m) Main Menu          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            flatpak install --user -y flathub org.qownnotes.QOwnNotes
            ;;

        2)
            source $SCRIPTS_HOME/packages.sh; "remove_office"
            flatpak install --user -y flathub org.libreoffice.LibreOffice
            check_if_fedora_immutable
            ;;
        3)
            source $SCRIPTS_HOME/packages.sh; "install_okular"
            ;;

        4)
            source $SCRIPTS_HOME/packages.sh; "install_evince"
            ;;
        
        5)
            source $SCRIPTS_HOME/packages.sh; "install_kde_ark"
            ;;

        6)
            source $SCRIPTS_HOME/packages.sh; "install_file_roller"
            ;;

        7)
            source $SCRIPTS_HOME/packages.sh; "install_claws_mail"
            ;;
        
        8)
            source $SCRIPTS_HOME/packages.sh; "install_thunderbird"
            ;;

        9)
            source $SCRIPTS_HOME/packages.sh; "download_bitwarden"
            ;;

        10)
            source $SCRIPTS_HOME/packages.sh; "install_keepassxc"
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
    echo "(5) Other IDEs        (6) GitHub Desktop"
    echo "(7) Containers"
    
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
            ides_menu
            ;;

        6)
            source $SCRIPTS_HOME/packages.sh; "install_github_desktop"
            ;;

        7)
            source $SCRIPTS_HOME/packages.sh; "install_containers"
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
    echo "(1) GCC/Package Tools (2) Codeblocks"
    echo "(p) Previous Menu     (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/packages.sh; "install_package_tools"
            ;;
        
        2)
            source $SCRIPTS_HOME/packages.sh; "install_codeblocks"
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
            source $SCRIPTS_HOME/packages.sh; "install_openjdk"
            ;;

        2)
            
            source $SCRIPTS_HOME/packages.sh; "download_idea"
            ;;

        3)  
            source $SCRIPTS_HOME/packages.sh; "download_netbeans"
            ;;

        4)
            source $SCRIPTS_HOME/packages.sh; "install_scene_builder"
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
        openjdk_menu
        ;;
        
    esac
    unset input
    openjdk_menu
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
            source $SCRIPTS_HOME/packages.sh; "install_nodejs"
            ;;

        2)
            source $SCRIPTS_HOME/packages.sh; "install_lamp_stack"
            ;;

        3)
            source $SCRIPTS_HOME/packages.sh; "install_bluefish"
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
        web_dev_menu
        ;;
        
    esac
    unset input
    web_dev_menu
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
            source $SCRIPTS_HOME/packages.sh; "install_python_tools"
            ;;

        2)
            source $SCRIPTS_HOME/packages.sh; "install_eric_ide"
            ;;

        3)
            source $SCRIPTS_HOME/packages.sh; "download_pycharm"
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
        python_menu
        ;;
        
    esac
    unset input
    python_menu
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
            source $SCRIPTS_HOME/packages.sh; "install_vim"
            ;;

        2)
            source $SCRIPTS_HOME/packages.sh; "install_vscodium"
            ;;

        3)
            source $SCRIPTS_HOME/packages.sh; "install_geany"
            ;;

        4)
            source $SCRIPTS_HOME/packages.sh; "install_eclipse"
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
            source $SCRIPTS_HOME/packages.sh; "install_fmedia_writer"
            ;;

        2)
            source $SCRIPTS_HOME/packages.sh; "install_kde_iso_image_writer"
            ;;

        3)
            flatpak install --user -y flathub org.raspberrypi.rpi-imager
            ;;

        4)
            source $SCRIPTS_HOME/packages.sh; "install_kleopatra"
            ;;

        5)
            flatpak install --user -y flathub org.gtkhash.gtkhash
            ;;

        6)
            flatpak install --user -y flathub com.github.tchx84.Flatseal
            ;;

        7)
            flatpak install --user -y flathub io.missioncenter.MissionCenter
            ;;
        
        8)
            source $SCRIPTS_HOME/packages.sh; "install_virtualization"
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
            ;;

        2)
            configurations_menu
            ;;

        3)
            source $SCRIPTS_HOME/data/dsksstuff.sh; "dsksstuff_menu"
            ;;

        4)
            source $SCRIPTS_HOME/packages.sh; "remove_codecs"
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
    echo "(p) Previous Menu              (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            sudo modprobe xpad
            ;;

        2)
            source $SCRIPTS_HOME/packages.sh; "check_for_libvirt_group"
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

export SCRIPTS_HOME=$(pwd)
OS_NAME=$(source /etc/os-release ; echo $NAME)
VERSION="dev branch"
TEMP_FOLDER="missing"
GITCHECK="missing"
WGETCHECK="missing"
CURLCHECK="missing"
DOS2UNIXCHECK="missing"
ZENITYCHECK="missing"
APP_FOLDER="missing"
DISTRO=""
PKGMGR=""
VARIANT=""
make_temp
make_app_folder
distro_check