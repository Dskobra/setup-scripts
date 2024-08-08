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
        #source $SCRIPTS_FOLDER/packages.sh; "install_prereq"
        $SCRIPTS_FOLDER/modules/core/prereq.sh
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
    echo "(9) Misc                          (10) Update Scripts"
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
            miscellaneous_menu
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
            $SCRIPTS_FOLDER/modules/hardware/corectrl.sh
            ;;

        2)
            $SCRIPTS_FOLDER/modules/hardware/amd_codecs.sh
            ;;

        3)
            $SCRIPTS_FOLDER/modules/hardware/nvidia.sh
            ;;

        4)
            $SCRIPTS_FOLDER/modules/hardware/cooler_control.sh
            ;;

        5)
            $SCRIPTS_FOLDER/modules/hardware/openrgb.sh
            ;;

        6)
            $SCRIPTS_FOLDER/modules/hardware/v4l2loopback.sh
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
            kde_desktop_menu
            ;;
        
        2)
            gnome_desktop_menu
            ;;

        3)
            $SCRIPTS_FOLDER/modules/desktops/mate_apps.sh
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
    echo "(7) Kleopatra          (8) Kate"
    echo "(h) Help               (p) Previous Menu"
    echo "(m) Main Menu          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            $SCRIPTS_FOLDER/modules/desktops/kde/kde_apps.sh
            ;;
        
        2)
            $SCRIPTS_FOLDER/modules/desktops/kde/plasma_x11.sh
            ;;

        3)
            $SCRIPTS_FOLDER/modules/desktops/kde/kpat.sh
            ;;

        4)
            $SCRIPTS_FOLDER/modules/desktops/kde/kde_iso_image_writer.sh
            ;;
        
        5)
            $SCRIPTS_FOLDER/modules/desktops/kde/k3b.sh
            ;;

        6)
            $SCRIPTS_FOLDER/modules/desktops/kde/kolourpaint.sh
            ;;

        7)
            $SCRIPTS_FOLDER/modules/desktops/kde/kleopatra.sh
            ;;

        8)
            $SCRIPTS_FOLDER/modules/desktops/kde/kate.sh
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
            $SCRIPTS_FOLDER/modules/desktops/gnome/gnome_apps.sh
            ;;
        
        2)
            $SCRIPTS_FOLDER/modules/desktops/gnome/gnome_tweaks.sh
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
            $SCRIPTS_FOLDER/modules/internet/firefox.sh
            ;;

        2)
            $SCRIPTS_FOLDER/modules/internet/brave.sh
            ;;
        
        3)
            $SCRIPTS_FOLDER/modules/internet/dropbox.sh
            ;;

        4)
            $SCRIPTS_FOLDER/modules/internet/transmission.sh
            ;;

        5)  
            $SCRIPTS_FOLDER/modules/internet/remmina.sh
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

            $SCRIPTS_FOLDER/modules/multimedia/codecs.sh
            ;;

        2)
            $SCRIPTS_FOLDER/modules/multimedia/vlc.sh
            ;;

        3)
            $SCRIPTS_FOLDER/modules/multimedia/obs.sh
            ;;
        
        4)
            $SCRIPTS_FOLDER/modules/multimedia/openshot.sh
            ;;

        5)
            $SCRIPTS_FOLDER/modules/multimedia/xfburn.sh
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
            $SCRIPTS_FOLDER/modules/gaming/steam.sh
            ;;

        2) 
            $SCRIPTS_FOLDER/modules/gaming/lutris.sh
            ;;

        3)
            $SCRIPTS_FOLDER/modules/gaming/bottles.sh
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
            $SCRIPTS_FOLDER/modules/gaming/wowup.sh
            ;;

        2) 
            $SCRIPTS_FOLDER/modules/gaming/warcraft_logs.sh
            ;;

        3)
            $SCRIPTS_FOLDER/modules/gaming/weakauras_companion.sh
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
    echo "(3) Proton Plus"
    echo "(p) Previous Menu          (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            $SCRIPTS_FOLDER/modules/gaming/mangohud.sh
            ;;

        2)
            flatpak install --user -y com.github.Matoking.protontricks
            ;;

        3)
            $SCRIPTS_FOLDER/modules/gaming/proton_plus.sh
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
    echo "(1) Discord                (2) Minecraft"
    echo "(3) Prisim Launcher        (4) Dolphin"
    echo "(5) Cemu                   (6) Basic Game profiles"
    echo "(p) Previous Menu          (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            $SCRIPTS_FOLDER/modules/gaming/discord.sh
            ;;

        2) 
            flatpak install --user -y flathub com.mojang.Minecraft
            ;;

        3)
            flatpak install --user -y flathub org.prismlauncher.PrismLauncher
            ;;

        4)
            $SCRIPTS_FOLDER/modules/gaming/dolphin_emu.sh
            ;;

        5)
            flatpak install --user -y flathub info.cemu.Cemu
            ;;

        6)
            $SCRIPTS_FOLDER/modules/gaming/game_profiles.sh
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
            $SCRIPTS_FOLDER/modules/office/libreoffice.sh
            ;;

        2)
            $SCRIPTS_FOLDER/modules/office/qownnotes.sh
            ;;

        3)
            $SCRIPTS_FOLDER/modules/office/marknote.sh
            ;;

        4)
            $SCRIPTS_FOLDER/modules/office/claws_mail.sh
            ;;
        
        5)
            $SCRIPTS_FOLDER/modules/office/thunderbird.sh
            ;;

        6)
            flatpak install --user -y flathub com.bitwarden.desktop
            ;;

        7)
            $SCRIPTS_FOLDER/modules/office/keepassxc.sh
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
            $SCRIPTS_FOLDER/modules/development/package_tools.sh
            ;;
        
        2)
            $SCRIPTS_FOLDER/modules/development/openjdk.sh
            ;;

        3)
            $SCRIPTS_FOLDER/modules/development/nodejs.sh
            ;;

        4)
            $SCRIPTS_FOLDER/modules/development/python_tools.sh
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
            $SCRIPTS_FOLDER/modules/development/vim.sh
            ;;

        2)
            $SCRIPTS_FOLDER/modules/development/vscodium.sh
            ;;

        3)
            $SCRIPTS_FOLDER/modules/development/geany.sh
            ;;

        4)
            $SCRIPTS_FOLDER/modules/development/codeblocks.sh
            ;;

        5)
            $SCRIPTS_FOLDER/modules/development/eclipse.sh
            ;;

        6)
            $SCRIPTS_FOLDER/modules/development/idea.sh
            ;;
        
        7)
            $SCRIPTS_FOLDER/modules/development/netbeans.sh
            ;;

        8)
            $SCRIPTS_FOLDER/modules/development/scene_builder.sh
            ;;

        9)
            $SCRIPTS_FOLDER/modules/development/bluefish.sh
            ;;

        10)
            $SCRIPTS_FOLDER/modules/development/eric_ide.sh
            ;;

        11)
            $SCRIPTS_FOLDER/modules/development/pycharm.sh
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
            $SCRIPTS_FOLDER/modules/development/lamp.sh
            ;;

        2)
            $SCRIPTS_FOLDER/modules/development/github_desktop.sh
            ;;

        3)
            $SCRIPTS_FOLDER/modules/development/containers.sh
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
            $SCRIPTS_FOLDER/modules/utilities/fedora_media_writer.sh
            ;;

        2)
            $SCRIPTS_FOLDER/modules/utilities/rpi_imager.sh
            ;;

        3)
            $SCRIPTS_FOLDER/modules/utilities/gtkhash.sh
            ;;

        4)
            flatpak install --user -y flathub io.missioncenter.MissionCenter
            ;;
        
        5)
            $SCRIPTS_FOLDER/modules/utilities/virtualization.sh
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

miscellaneous_menu(){
    echo "---------------------"
    echo "|   Miscellaneous   |"
    echo "---------------------"
    echo ""
    echo ""
    echo ""
    echo ""   
    echo "(1) Reinstall prerequisites    (2)Setup xbox controller"
    echo "(3) Add user to libvirt group  (4) Spinfinity Boot Theme"
    echo "(5) Remove Audio/Video Codecs  (6) Remove AMD hardware accelerated codecs"
    echo "(m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            install_prereq
            ;;

        2)
            sudo modprobe xpad
            ;;

        3)
            $SCRIPTS_FOLDER/modules/misc/check_for_libvirt_group.sh
            ;;

        4)
            $SCRIPTS_FOLDER/modules/misc/spinfinity_theme.sh
            ;;

        5)
            $SCRIPTS_FOLDER/modules/cleanup/remove_codecs.sh
            ;;

        6)
            $SCRIPTS_FOLDER/modules/cleanup/remove_amd_codecs.sh
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
        miscellaneous_menu
        ;;
        
    esac
    unset input
    miscellaneous_menu
}

export SCRIPTS_FOLDER=$(pwd)        # stores full path for setup-scripts
export APP_FOLDER="$HOME/Apps"      # app folder thats made for some downloads
export PKGMGR=""                    # stores package manager name such as dnf/rpm-ostree etc
OS_NAME=$(source /etc/os-release ; echo $NAME)
VERSION_ID=$(source /etc/os-release ; echo $VERSION_ID)
COPYRIGHT="Copyright (c) 2021-2024 Jordan Bottoms"
VERSION="7.21.2024"
TEMP_FOLDER="missing"
LOOK_FOR_APP_FOLDER="missing"
RAN_ONCE_FILE="missing"
REPO_FOLDER="missing"               # .git folder with repository metadata
DISTRO=""                           # stores the ID (os-release info) of the os such as fedora or debian
VARIANT=""                          # only used for storing 'ostree' if fedora version is atomic
make_temp
make_app_folder
distro_check
