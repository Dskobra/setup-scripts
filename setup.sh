#!/usr/bin/bash

### This is the main script that contians all the menus,
### and code for determining the distro.

run_prereq_check(){
    FIRST_RUN_FILE=$SCRIPTS_HOME/.first_run_file.txt
    test -f $FIRST_RUN_FILE && FIRST_RUN_FILE="exists"
    if [ "$FIRST_RUN_FILE" = "exists" ]
    then
        echo "prereq already setup."
    else
        echo "setting up prereq"
        source $SCRIPTS_HOME/packages.sh; "install_prereq"
        touch $SCRIPTS_HOME/.first_run_file.txt
    fi
}

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

get_data(){
    echo "Will need to download extra files from data branch"
    cd $SCRIPTS_HOME
    rm -r -f data
    git clone https://github.com/Dskobra/setup-scripts -b data
    mv $SCRIPTS_HOME/setup-scripts $SCRIPTS_HOME/data
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
    echo "(1) Drivers/Modules               (2) Desktop Specific Apps"      
    echo "(3) Internet                      (4) Multimedia"
    echo "(5) Gaming                        (6) Office"
    echo "(7) Development                   (8) Utilities"
    echo "(9) Extras"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            drivers_modules_menu
            ;;

        2)
            desktop_specific_apps_menu
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

drivers_modules_menu(){
    echo "------------------------------"
    echo "|   Drivers/Kernel Modules   |"
    echo "------------------------------"
    echo ""
    echo "AMD/Nvidia drivers"
    echo ""
    echo ""     
    echo "(1) Corectrl(amd)       (2) Nvidia Driver"
    echo "(3) OpenRGB             (4) CoolerControl"
    echo "(5) v4l2loopback"
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
            source $SCRIPTS_HOME/packages.sh; "install_openrgb"
            ;;

        4)
            source $SCRIPTS_HOME/packages.sh; "install_cooler_control"
            ;;

        5)
            source $SCRIPTS_HOME/packages.sh; "install_v4l2loopback"
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
            drivers_modules_menu
            ;;
            
        esac
        unset input
        drivers_modules_menu
}

desktop_specific_apps_menu(){
    echo "-----------------------------"
    echo "|   Desktop Specific Apps   |"
    echo "-----------------------------"
    echo ""
    echo "KDE/Gnome/Mate apps"
    echo ""
    echo ""   
    echo "(1) KDE                (2) GNOME"
    echo "(3) Mate               (h) Help"     
    echo "(m) Main Menu          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/packages.sh; "kde_desktop_menu"
            ;;
        
        2)
            source $SCRIPTS_HOME/packages.sh; "install_gnome_apps"
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
            desktop_specific_apps_menu
            ;;
            
        esac
        unset input
        desktop_specific_apps_menu
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
            source $SCRIPTS_HOME/packages.sh; "install_kdeapps"
            ;;
        
        2)
            source $SCRIPTS_HOME/packages.sh; "install_plasma_x11"
            ;;

        3)
            source $SCRIPTS_HOME/packages.sh; "install_kpat"
            ;;

        4)
            source $SCRIPTS_HOME/packages.sh; "install_kde_iso_image_writer"
            ;;
        
        5)
            source $SCRIPTS_HOME/packages.sh; "install_kthreeb"
            ;;

        6)
            source $SCRIPTS_HOME/packages.sh; "install_kolourpaint"
            ;;

        7)
            source $SCRIPTS_HOME/packages.sh; "install_kleopatra"
            ;;

        h)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Features
            ;;

        H)  
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Features
            ;;

        p)
            desktop_specific_apps_menu
            ;;

        P)
            desktop_specific_apps_menu
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
            source $SCRIPTS_HOME/packages.sh; "install_gnome_apps"
            ;;
        
        2)
            source $SCRIPTS_HOME/packages.sh; "install_gnome_tweaks"
            ;;

        h)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Features
            ;;

        H)  
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Features
            ;;

        p)
            desktop_specific_apps_menu
            ;;

        P)
            desktop_specific_apps_menu
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
            source $SCRIPTS_HOME/packages.sh; "install_firefox"
            ;;

        2)
            source $SCRIPTS_HOME/packages.sh; "install_brave_browser"
            ;;
        
        3)
            source $SCRIPTS_HOME/packages.sh; "install_dropbox"
            ;;

        4)
            source $SCRIPTS_HOME/packages.sh; "install_transmission"
            ;;

        5)  
            source $SCRIPTS_HOME/packages.sh; "install_remmina"
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
    echo "(1) FFmpeg (a/v codecs)   (2) Mesa Codecs (AMD)"    
    echo "(3) VLC Media Player      (4) OBS Studio"
    echo "(5) OpenShot" 
    echo "(6) xfburn"
    echo "(m) Main Menu             (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/packages.sh; "install_codecs"
            ;;

        2)
            source $SCRIPTS_HOME/packages.sh; "install_amd_codecs"
            ;;

        3)
            source $SCRIPTS_HOME/packages.sh; "install_vlc"
            ;;
        
        4)
            source $SCRIPTS_HOME/packages.sh; "install_obsstudio"
            ;;

        5)
            source $SCRIPTS_HOME/packages.sh; "install_openshot"
            ;;

        6)
            source $SCRIPTS_HOME/packages.sh; "install_xfburn"
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
    echo "(3) WoW Clients            (4) Misc"
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
            gaming_misc_menu
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
            source $SCRIPTS_HOME/packages.sh; "install_lutris"
            ;;

        3)
            source $SCRIPTS_HOME/packages.sh; "install_bottles"
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
            source $SCRIPTS_HOME/packages.sh; "download_wowup"
            ;;

        2) 
            source $SCRIPTS_HOME/packages.sh; "download_warcraft_logs"
            ;;

        3)
            source $SCRIPTS_HOME/packages.sh; "download_weakauras_companion"

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

gaming_misc_menu(){
    echo "-----------------"
    echo "|   Misc Stuff   |"
    echo "-----------------"
    echo ""
    echo ""
    echo ""
    echo ""   
    echo "(1) Discord                (2) Minecraft"
    echo "(3) Dolphin                (4) Cemu"
    echo "(p) Previous Menu          (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            source $SCRIPTS_HOME/packages.sh; "install_discord"
            ;;

        2) 
            source $SCRIPTS_HOME/packages.sh; "download_minecraft"
            ;;

        3)
            source $SCRIPTS_HOME/packages.sh; "install_dolphin_emu"
            ;;

        4)
            flatpak install --user -y flathub info.cemu.Cemu
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
            gaming_misc_menu
            ;;
            
        esac
        unset input
        gaming_misc_menu
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
    echo "(3) Claws-Mail         (4) Thunderbird"
    echo "(5) Bitwarden          (6) KeePassXC"         
    echo "(m) Main Menu          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/packages.sh; "install_qownnotes"
            ;;

        2)
            source $SCRIPTS_HOME/packages.sh; "install_libreoffice"
            ;;

        3)
            source $SCRIPTS_HOME/packages.sh; "install_claws_mail"
            ;;
        
        4)
            source $SCRIPTS_HOME/packages.sh; "install_thunderbird"
            ;;

        5)
            flatpak install --user -y flathub com.bitwarden.desktop
            ;;

        6)
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

development_menu(){
    echo "-------------------"
    echo "|   Development   |"
    echo "-------------------"
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
        development_menu
        ;;
        
    esac
    unset input
    development_menu
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
    echo "(1) openJDK 17/21   (2) Intellij IDEA"
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
    echo "(3) GtkHash                    (4) Flatseal"
    echo "(5) MissionCenter              (6) Virtualization"
    echo "(m) Main Menu                  (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/packages.sh; "install_fmedia_writer"
            ;;

        2)
            source $SCRIPTS_HOME/packages.sh; "install_fmedia_writer"
            flatpak install --user -y flathub org.raspberrypi.rpi-imager
            ;;

        3)
            flatpak install --user -y flathub org.gtkhash.gtkhash
            ;;

        4)
            flatpak install --user -y flathub com.github.tchx84.Flatseal
            ;;

        5)
            flatpak install --user -y flathub io.missioncenter.MissionCenter
            ;;
        
        6)
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
            source $SCRIPTS_HOME/packages.sh; "check_for_libvirt_group"
            ;;

        3)
            source $SCRIPTS_HOME/packages.sh; "install_spinfinity_theme"
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
VERSION_ID=$(source /etc/os-release ; echo $VERSION_ID)
COPYRIGHT="Copyright (c) 2021-2024 Jordan Bottoms"
VERSION="4.23.2024"
TEMP_FOLDER="missing"
LOOK_FOR_APP_FOLDER="missing"
APP_FOLDER="$HOME/Apps"
FIRST_RUN_FILE="missing"
DISTRO=""
PKGMGR=""
VARIANT=""
make_temp
make_app_folder
distro_check