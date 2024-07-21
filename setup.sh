#!/usr/bin/bash

### Main launch script which includes menus, distro
### determination and making app/temp folders.

run_prereq_check(){
    ### make sure git, curl, wget, zenity
    ### and flatpak are installed.
    RAN_ONCE_FILE=$SCRIPTS_FOLDER/.ranonce.txt
    test -f $RAN_ONCE_FILE && RAN_ONCE_FILE="exists"
    if [ "$RAN_ONCE_FILE" = "exists" ]
    then
        echo "Skipping first run steps."
    else
        echo "Installing required software"
        source $SCRIPTS_FOLDER/packages.sh; "install_prereq"
        touch $SCRIPTS_FOLDER/.ranonce.txt
        zenity --info --text="Required packages now installed and enabled 3rd party repositories. May now proceed to text menu."
    fi
}

make_temp(){
    test -d $SCRIPTS_FOLDER/temp && TEMP_FOLDER=exists
    if [ "$TEMP_FOLDER" = "exists" ];
        then
           TEMP_FOLDER=exists 
    elif [ "$TEMP_FOLDER" = "missing" ];
        then
        mkdir $SCRIPTS_FOLDER/temp        # make a temp folder for all files to be downloaded to   
    fi
}

make_app_folder(){
    ### Store netbeans, intellij idea and pycharm
    ### in ~/Apps  
    test -d $HOME/Apps && LOOK_FOR_APP_FOLDER=exists
    if [ "$LOOK_FOR_APP_FOLDER" = "exists" ];
        then
           LOOK_FOR_APP_FOLDER=exists 
    elif [ "$LOOK_FOR_APP_FOLDER" = "missing" ];
        then
            mkdir $APP_FOLDER
    fi
}

distro_check(){
    DISTRO=$(source /etc/os-release ; echo $ID)
    if [ $DISTRO == "fedora" ]
    then
        fedora_release_check
    elif [ $DISTRO == "debian" ]
    then
        debian_release_check
    else
        echo "Unsupported distro"
    fi

}

fedora_release_check(){
    if [ $VERSION_ID == "39" ] || [ $VERSION_ID == "40" ]
    then
        fedora_variant_check
    else
        echo "These scripts only support Fedora 39/40"
    fi

}

debian_release_check(){
    if [ $VERSION_ID == "12" ]
    then
        PKGMGR="apt-get"
        run_prereq_check
        get_data
        main_menu
    else
        echo "These scripts only support Debian 12"
    fi

}

fedora_variant_check(){
    # Fedora Workstation/Server and Desktop Spins
    # use dnf as their package manager while
    # Atomic Desktop Editions use rpm-ostree
    # which is very different. Some commands need
    # to be run differently.
    test -f /run/ostree-booted && VARIANT=ostree
    if [ ! -n "$VARIANT" ]
    then
        PKGMGR="dnf"
        run_prereq_check
        get_data
        main_menu
    elif [ $VARIANT == "ostree" ]
    then
        PKGMGR="rpm-ostree"
        run_prereq_check
        get_data
        main_menu
    fi
}

confirm_reboot(){
    # Some packages cannot be applied live without restarting.
    # Things like adding system groups, installing boot themes,
    # steam udev rules (aka steam-devices)
    # require rebooting first in order for them to be usable.
    echo "================================================"
    echo "Some packages won't be availble until a "
    echo "restart is performed."
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

get_data(){
    # data branch includes links I can update more frequently and
    # my personal mangohud profiles (positioned for my liking).
    echo "Will need to download extra files from data branch"
    cd $SCRIPTS_FOLDER
    rm -r -f data
    git clone https://github.com/Dskobra/setup-scripts -b data
    mv $SCRIPTS_FOLDER/setup-scripts $SCRIPTS_FOLDER/data
}

get_updates(){
    test -d $SCRIPTS_FOLDER/.git && REPO_FOLDER=exists
    if [ "$REPO_FOLDER" = "exists" ];
        then
            cd $SCRIPTS_FOLDER
            rm $SCRIPTS_FOLDER/.ranonce.txt
            rm -r -f data
            git pull
            zenity --info --text="Please rerun setup.sh now."
            exit
    elif [ "$REPO_FOLDER" = "missing" ];
        then
            zenity --info --text="No valid .git folder found. Please redownload them."
    fi
}

main_menu(){
    echo "---------------------------"   
    echo "|   DSK's Setup Scripts   |"
    echo "---------------------------" 
    echo ""
    echo "Version: $VERSION"
    echo "$COPYRIGHT"
    echo "Released under the MIT license"
    echo ""
    echo ""
    echo "(1) Hardware/Drivers              (2) Desktop Apps"      
    echo "(3) Internet                      (4) Multimedia"
    echo "(5) Gaming                        (6) Office"
    echo "(7) Development                   (8) Utilities"
    echo "(9) Extras                        (10) Update Scripts"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            hardware_drivers_menu
            ;;

        2)
            desktop_apps_menu
            ;;

        3)
            internet_menu
            ;;

        4)
            multimedia_menu
            ;;

        5)
            gaming_menu
            ;;

        6)
            office_menu
            ;;
        7)
            development_menu
            ;;

        8)
            utils_menu
            ;;

        9)
            extras_menu
            ;;

        10)
            get_updates
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

hardware_drivers_menu(){
    echo "------------------------"
    echo "|   Hardware/Drivers   |"
    echo "------------------------"
    echo ""
    echo "Hardware and device drivers etc"
    echo ""
    echo ""     
    echo "(1) Corectrl(amd)       (2) AMD Video Acceleration"
    echo "(3) Nvidia Driver       (4) CoolerControl"
    echo "(5) OpenRGB             (6) Virtual Camera"
    echo "(h) Help"
    echo "(m) Main Menu           (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_FOLDER/packages.sh; "install_corectrl"
            ;;

        2)
            source $SCRIPTS_FOLDER/packages.sh; "install_amd_codecs"
            ;;

        3)
            source $SCRIPTS_FOLDER/packages.sh; "install_nvidia"
            ;;

        4)
            source $SCRIPTS_FOLDER/packages.sh; "install_cooler_control"
            ;;

        5)
            source $SCRIPTS_FOLDER/packages.sh; "install_openrgb"
            ;;

        6)
            source $SCRIPTS_FOLDER/packages.sh; "install_v4l2loopback"
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
            hardware_drivers_menu
            ;;
            
        esac
        unset input
        hardware_drivers_menu
}

desktop_apps_menu(){
    echo "--------------------"
    echo "|   Desktop Apps   |"
    echo "--------------------"
    echo ""
    echo "Specific Desktop Enviroment apps."
    echo ""
    echo ""   
    echo "(1) KDE                (2) GNOME"
    echo "(3) Mate               (h) Help"     
    echo "(m) Main Menu          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_FOLDER/packages.sh; "kde_desktop_menu"
            ;;
        
        2)
            gnome_desktop_menu
            ;;

        3)
            source $SCRIPTS_FOLDER/packages.sh; "install_mate_apps"
            ;;

        h)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Apps
            ;;

        H)  
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Apps
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
            desktop_apps_menu
            ;;
            
        esac
        unset input
        desktop_apps_menu
}

kde_desktop_menu(){
    echo "-----------"
    echo "|   KDE   |"
    echo "-----------"
    echo ""
    echo ""
    echo ""
    echo ""   
    echo "(1) Core Apps          (2) Plasma X11"
    echo "(3) KDE Patience       (4) KDE ISO Image Writer"
    echo "(5) K3b                (6) Kolourpaint"
    echo "(7) Kleopatra"
    echo "(h) Help               (p) Previous Menu"
    echo "(m) Main Menu          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_FOLDER/packages.sh; "install_kdeapps"
            ;;
        
        2)
            source $SCRIPTS_FOLDER/packages.sh; "install_plasma_x11"
            ;;

        3)
            source $SCRIPTS_FOLDER/packages.sh; "install_kpat"
            ;;

        4)
            source $SCRIPTS_FOLDER/packages.sh; "install_kde_iso_image_writer"
            ;;
        
        5)
            source $SCRIPTS_FOLDER/packages.sh; "install_kthreeb"
            ;;

        6)
            source $SCRIPTS_FOLDER/packages.sh; "install_kolourpaint"
            ;;

        7)
            source $SCRIPTS_FOLDER/packages.sh; "install_kleopatra"
            ;;

        h)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Apps#gnome
            ;;

        H)  
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Apps#gnome
            ;;

        p)
            desktop_apps_menu
            ;;

        P)
            desktop_apps_menu
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
            kde_desktop_menu
            ;;
            
        esac
        unset input
        kde_desktop_menu
}

gnome_desktop_menu(){
    echo "-----------"
    echo "|   Gnome  |"
    echo "-----------"
    echo ""
    echo ""
    echo ""
    echo ""   
    echo "(1) Core Apps          (2) Gnome Tweaks"
    echo "(h) Help               (p) Previous Menu"
    echo "(m) Main Menu          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_FOLDER/packages.sh; "install_gnome_apps"
            ;;
        
        2)
            source $SCRIPTS_FOLDER/packages.sh; "install_gnome_tweaks"
            ;;

        h)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Apps#gnome
            ;;

        H)  
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Apps#gnome
            ;;

        p)
            desktop_apps_menu
            ;;

        P)
            desktop_apps_menu
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
            gnome_desktop_menu
            ;;
            
        esac
        unset input
        gnome_desktop_menu
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
    echo "(5) Remmina"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_FOLDER/packages.sh; "install_firefox"
            ;;

        2)
            source $SCRIPTS_FOLDER/packages.sh; "install_brave_browser"
            ;;
        
        3)
            source $SCRIPTS_FOLDER/packages.sh; "install_dropbox"
            ;;

        4)
            source $SCRIPTS_FOLDER/packages.sh; "install_transmission"
            ;;

        5)  
            source $SCRIPTS_FOLDER/packages.sh; "install_remmina"
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
    echo "(1) Audio/Video Codecs    (2) VLC Media Player"
    echo "(3) OBS Studio            (4) OpenShot"
    echo "(5) xfburn"
    echo "(m) Main Menu             (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_FOLDER/packages.sh; "install_codecs"
            ;;

        2)
            source $SCRIPTS_FOLDER/packages.sh; "install_vlc"
            ;;

        3)
            source $SCRIPTS_FOLDER/packages.sh; "install_obsstudio"
            ;;
        
        4)
            source $SCRIPTS_FOLDER/packages.sh; "install_openshot"
            ;;

        5)
            source $SCRIPTS_FOLDER/packages.sh; "install_xfburn"
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
    echo "(3) WoW Clients            (4) Other"
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
            gaming_other_menu
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
            source $SCRIPTS_FOLDER/packages.sh; "install_steam"
            ;;

        2) 
            mkdir "$HOME"/Games
            source $SCRIPTS_FOLDER/packages.sh; "install_lutris"
            ;;

        3)
            source $SCRIPTS_FOLDER/packages.sh; "install_bottles"
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

gaming_wow_clients_menu(){
    echo "----------------------"
    echo "|  Clients  for WoW   |"
    echo "---------------- ------"
    echo ""
    echo "Addon managers and extra stuff for World of Warcraft"
    echo ""
    echo ""   
    echo "(1) WoWUp                 (2) Warcraft Logs"
    echo "(3) Weak Auras Companion"
    echo "(p) Previous Menu          (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            source $SCRIPTS_FOLDER/packages.sh; "download_wowup"
            ;;

        2) 
            source $SCRIPTS_FOLDER/packages.sh; "download_warcraft_logs"
            ;;

        3)
            source $SCRIPTS_FOLDER/packages.sh; "download_weakauras_companion"

            ;;

        4)
            source $SCRIPTS_FOLDER/packages.sh; "download_weakauras_companion"
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

gaming_tools_menu(){
    echo "--------------------"
    echo "|   Gaming Tools   |"
    echo "--------------------"
    echo ""
    echo "Mangohud and proton tools"
    echo ""
    echo ""   
    echo "(1) Mangohud               (2) Protontricks"
    echo "(3) ProtonUp Qt            (4) Proton Plus"
    echo "(p) Previous Menu          (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_FOLDER/packages.sh; "install_mangohud"
            ;;

        2)
            flatpak install --user -y com.github.Matoking.protontricks
            ;;
        
        3)
            flatpak install --user -y flathub net.davidotek.pupgui2
            ;;

        4)
            source $SCRIPTS_FOLDER/packages.sh; "install_proton_plus"
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

gaming_other_menu(){
    echo "-----------------"
    echo "|   Misc Stuff   |"
    echo "-----------------"
    echo ""
    echo ""
    echo ""
    echo ""   
    echo "(1) Discord                (2) Discord Overlay"
    echo "(3) Minecraft              (4) Prisim Launcher"
    echo "(5) Dolphin                (6) Cemu"
    echo "(7) Basic Game profiles"
    echo "(p) Previous Menu          (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            source $SCRIPTS_FOLDER/packages.sh; "install_discord"
            ;;
        
        2)
            source $SCRIPTS_FOLDER/packages.sh; "install_discover_overlay"
            ;;

        3) 
            flatpak install --user -y flathub com.mojang.Minecraft
            ;;

        4)
            flatpak install --user -y flathub org.prismlauncher.PrismLauncher
            ;;

        5)
            source $SCRIPTS_FOLDER/packages.sh; "install_dolphin_emu"
            ;;

        6)
            flatpak install --user -y flathub info.cemu.Cemu
            ;;

        7)
            source $SCRIPTS_FOLDER/packages.sh; "setup_game_profiles"
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
            gaming_other_menu
            ;;
            
        esac
        unset input
        gaming_other_menu
}

office_menu(){
    echo "--------------"
    echo "|   Office   |"
    echo "--------------"
    echo ""
    echo "Office and note taking apps."
    echo ""
    echo ""   
    echo "(1) LibreOffice        (2) QOwnNotes"          
    echo "(3) Marknote           (4) Claws-Mail"
    echo "(5) Thunderbird        (6) Bitwarden"
    echo "(7) KeePassXC"         
    echo "(m) Main Menu          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_FOLDER/packages.sh; "install_libreoffice"
            ;;

        2)
            source $SCRIPTS_FOLDER/packages.sh; "install_qownnotes"
            ;;

        3)
            source $SCRIPTS_FOLDER/packages.sh; "install_marknote"
            ;;

        4)
            source $SCRIPTS_FOLDER/packages.sh; "install_claws_mail"
            ;;
        
        5)
            source $SCRIPTS_FOLDER/packages.sh; "install_thunderbird"
            ;;

        6)
            flatpak install --user -y flathub com.bitwarden.desktop
            ;;

        7)
            source $SCRIPTS_FOLDER/packages.sh; "install_keepassxc"
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

development_menu(){
    echo "-------------------"
    echo "|   Development   |"
    echo "-------------------"
    echo ""
    echo "Mostly IDEs and compilers."
    echo ""
    echo ""   
    echo ""
    echo "(1) SDKs              (2) IDEs"
    echo "(3) Other"
    echo "(m) Main Menu         (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            sdks_menu
            ;;
        2)
            ides_menu
            ;;

        3)
            dev_other_menu
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
        development_menu
        ;;
        
    esac
    unset input
    development_menu
}

sdks_menu(){
    echo "-----------"
    echo "|  SDKs   |"
    echo "-----------"
    echo ""
    echo ""   
    echo ""
    echo "(1) C/C++ Compiler    (2) openJDK 17/21"
    echo "(3) Nodejs LTS        (4) Python Dev Packages"
    echo "(p) Previous Menu     (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_FOLDER/packages.sh; "install_package_tools"
            ;;
        
        2)
            source $SCRIPTS_FOLDER/packages.sh; "install_openjdk"
            ;;

        3)
            source $SCRIPTS_FOLDER/packages.sh; "install_nodejs"
            ;;

        4)
            source $SCRIPTS_FOLDER/packages.sh; "install_python_tools"
            ;;
        
        p)
            development_menu
            ;;
        
        P)
            development_menu
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
        sdks_menu
        ;;
        
    esac
    unset input
    sdks_menu
}

ides_menu(){
    echo "------------"
    echo "|   IDEs   |"
    echo "------------"
    echo ""
    echo ""
    echo ""   
    echo "(1) VIM                            (2) VSCodium"
    echo "(3) Geany                          (4) CodeBlocks"
    echo "(5) Eclipse                        (6) Intellij IDEA"
    echo "(7) Netbeans                       (8) Scene Builder"
    echo "(9) Bluefish                       (10) Eric IDE"
    echo "(11) Pycharm"
    echo "(p) Previous Menu                  (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_FOLDER/packages.sh; "install_vim"
            ;;

        2)
            source $SCRIPTS_FOLDER/packages.sh; "install_vscodium"
            ;;

        3)
            source $SCRIPTS_FOLDER/packages.sh; "install_geany"
            ;;

        4)
            source $SCRIPTS_FOLDER/packages.sh; "install_codeblocks"
            ;;

        5)
            source $SCRIPTS_FOLDER/packages.sh; "install_eclipse"
            ;;

        6)
            source $SCRIPTS_FOLDER/packages.sh; "install_idea"
            ;;
        
        7)
            source $SCRIPTS_FOLDER/packages.sh; "install_netbeans"
            ;;

        8)
            source $SCRIPTS_FOLDER/packages.sh; "install_scene_builder"
            ;;

        9)
            source $SCRIPTS_FOLDER/packages.sh; "install_bluefish"
            ;;

        10)
            source $SCRIPTS_FOLDER/packages.sh; "install_eric_ide"
            ;;

        11)
            source $SCRIPTS_FOLDER/packages.sh; "install_pycharm"
            ;;

        p)
            development_menu
            ;;

        P)
            development_menu
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

dev_other_menu(){
    echo "-------------"
    echo "|   Other   |"
    echo "-------------"
    echo ""
    echo ""
    echo ""   
    echo "(1) Lamp Stack            (2) Github Desktop"
    echo "(3) Containers"
    echo "(p) Previous Menu         (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_FOLDER/packages.sh; "install_lamp_stack"
            ;;

        2)
            source $SCRIPTS_FOLDER/packages.sh; "install_github_desktop"
            ;;

        3)
            source $SCRIPTS_FOLDER/packages.sh; "install_containers"
            ;;

        p)
            development_menu
            ;;

        P)
            development_menu
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
        dev_other_menu
        ;;
        
    esac
    unset input
    dev_other_menu
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
    echo "(1) Fedora Media Writer        (2) Raspberry Pi Imager"
    echo "(3) GtkHash                    (4) MissionCenter"
    echo "(5) Virtualization"
    echo "(m) Main Menu                  (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_FOLDER/packages.sh; "install_fmedia_writer"
            ;;

        2)
            source $SCRIPTS_FOLDER/packages.sh; "install_rpi_imager"
            ;;

        3)
            source $SCRIPTS_FOLDER/packages.sh; "install_gtkhash"
            ;;

        4)
            flatpak install --user -y flathub io.missioncenter.MissionCenter
            ;;
        
        5)
            source $SCRIPTS_FOLDER/packages.sh; "install_virtualization"
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
    echo "(3) Remove Codecs"
    echo "(m) Main Menu                  (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_FOLDER/data/fedora_upgrade_helper.sh; "launch_menu"
            ;;

        2)
            configurations_menu
            ;;

        3)
            source $SCRIPTS_FOLDER/packages.sh; "remove_codecs"
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
    echo "(3) Spinfinity Boot Theme"
    echo "(p) Previous Menu              (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            sudo modprobe xpad
            ;;

        2)
            source $SCRIPTS_FOLDER/packages.sh; "check_for_libvirt_group"
            ;;

        3)
            source $SCRIPTS_FOLDER/packages.sh; "install_spinfinity_theme"
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

export SCRIPTS_FOLDER=$(pwd)
OS_NAME=$(source /etc/os-release ; echo $NAME)
VERSION_ID=$(source /etc/os-release ; echo $VERSION_ID)
COPYRIGHT="Copyright (c) 2021-2024 Jordan Bottoms"
VERSION="7.21.2024"
TEMP_FOLDER="missing"
LOOK_FOR_APP_FOLDER="missing"
APP_FOLDER="$HOME/Apps"
RAN_ONCE_FILE="missing"
REPO_FOLDER="missing"
DISTRO=""
PKGMGR=""
VARIANT=""
make_temp
make_app_folder
distro_check
