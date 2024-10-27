#!/usr/bin/bash

main_menu(){
    echo "---------------------------"   
    echo "|   DSK's Setup Scripts   |"
    echo "---------------------------" 
    echo ""
    echo "Version: $VERSION"
    echo "Package Type: $PACKAGE_TYPE"
    echo "$COPYRIGHT"
    echo "Released under the MIT license"
    echo ""
    echo ""
    echo "(1) Hardware/Drivers              (2) Desktop Apps"      
    echo "(3) Internet                      (4) Multimedia"
    echo "(5) Gaming                        (6) Office"
    echo "(7) Development                   (8) Utilities"
    echo "(9) Misc                          (10) Native Apps"
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
            ostree_menu
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
    echo "Note these are all native packages."
    echo "(1) Corectrl(amd)       (2) Nvidia Driver"
    echo "(3) CoolerControl       (4) OpenRGB"
    echo "(5) Virtual Camera"
    echo "(h) Help"
    echo "(m) Main Menu           (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/hardware/corectrl.sh
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/hardware/nvidia.sh
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/hardware/cooler_control.sh
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/hardware/openrgb.sh
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/hardware/v4l2loopback.sh
            ;;
        
        h)
            xdg-open "https://github.com/Dskobra/setup-scripts/wiki/Hardware"
            ;;

        H)
            xdg-open "https://github.com/Dskobra/setup-scripts/wiki/Hardware"
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
    echo "Apps for popular desktops"
    echo ""
    echo "(1) KDE                (2) GNOME"
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
    echo "(1) KDE Patience[f]       (2) Kolourpaint[f] "
    echo "(3) Kleopatra[f]          (4) KDE ISO Image Writer[f]"
    echo "(5) Kate[n]               (6) Plasma X11[n]"
    echo "(p) Previous Menu         (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/kde/kpat.sh "flatpak"
            ;;
        
        2)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/kde/kolourpaint.sh "flatpak"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/kde/kleopatra.sh "flatpak"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/kde/kde_iso_image_writer.sh "flatpak"
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/kde/kate.sh "flatpak"
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/kde/plasma_x11.sh
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
    echo "(1) Dconf Editor[f]        (2) Pavucontrol[f]"
    echo "[3] Gnome Tweaks[n]"
    echo "(p) Previous Menu          (m) Main Menu "
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/gnome/dconf_editor.sh "flatpak"
            ;;
        
        2)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/gnome/pavucontrol.sh "flatpak"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/gnome/gnome_tweaks.sh "flatpak"
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
    echo "(1) Firefox[f]             (2) Brave Browser[f]"
    echo "(3) Dropbox[f]             (4) Transmissionbt[f]"
    echo "(5) Remmina[f]"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/internet/firefox.sh "flatpak"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/internet/brave.sh "flatpak"
            ;;
        
        3)
            "$SCRIPTS_FOLDER"/modules/packages/internet/dropbox.sh "flatpak"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/internet/transmission.sh "flatpak"
            ;;

        5)  
            "$SCRIPTS_FOLDER"/modules/packages/internet/remmina.sh "flatpak"
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
    echo "(1) VLC Media Player[f]       (2) OBS Studio[f]"
    echo "(3) OpenShot[f]"
    echo "(m) Main Menu                 (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/vlc.sh "flatpak"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/obs.sh "flatpak"
            ;;
        
        3)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/openshot.sh "flatpak"
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
    echo "(1) Steam[f]                  (2) Lutris[f]"
    echo "(3) Bottles[f]"
    echo "(p) Previous Menu             (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            "$SCRIPTS_FOLDER"/modules/packages/gaming/steam.sh "flatpak"
            ;;

        2) 
            "$SCRIPTS_FOLDER"/modules/packages/gaming/lutris.sh "flatpak"
            ;;

        3)
            mkdir $HOME/bottles
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

gaming_wow_clients_menu(){
    echo "----------------------"
    echo "|  Clients  for WoW   |"
    echo "---------------- ------"
    echo ""
    echo "Addon managers and extra stuff for World of Warcraft"
    echo ""   
    echo "(1) WoWUp[o]                  (2) Warcraft Logs[o]"
    echo "(3) Weak Auras Companion[o]"
    echo "(p) Previous Menu             (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            "$SCRIPTS_FOLDER"/modules/packages/gaming/wowup.sh
            ;;

        2) 
            "$SCRIPTS_FOLDER"/modules/packages/gaming/warcraft_logs.sh
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/weakauras_companion.sh
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
    echo "(1) Mangohud[f]               (2) Protontricks[f]"
    echo "(3) Proton Plus[f]"
    echo "(p) Previous Menu             (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/mangohud.sh "flatpak"
            ;;

        2)
            flatpak install --user -y com.github.Matoking.protontricks
            ;;

        3)
            flatpak install --user -y flathub com.vysp3r.ProtonPlus
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
    echo "(1) Discord[f]                   (2) Prism Launcher[f]"
    echo "(3) Dolphin[f]                   (4) Cemu[f]"
    echo "(p) Previous Menu                (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            "$SCRIPTS_FOLDER"/modules/packages/gaming/discord.sh "flatpak"
            ;;

        2)
            flatpak install --user -y flathub org.prismlauncher.PrismLauncher
            ;;

        3)
            flatpak install --user -y flathub org.DolphinEmu.dolphin-emu
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
    echo "(1) LibreOffice[f]        (2) QOwnNotes[f]"
    echo "(3) Marknote[f]           (4) Claws-Mail[f]"
    echo "(5) Thunderbird[f]        (6) Bitwarden[f]"
    echo "(7) KeePassXC[f]"
    echo "(m) Main Menu             (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/office/libreoffice.sh "flatpak"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/office/qownnotes.sh "flatpak"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/office/marknote.sh "flatpak"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/office/claws_mail.sh "flatpak"
            ;;
        
        5)
            "$SCRIPTS_FOLDER"/modules/packages/office/thunderbird.sh "flatpak"
            ;;

        6)
            flatpak install --user -y flathub com.bitwarden.desktop
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/office/keepassxc.sh "flatpak"
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
    echo "(1) SDKs              (2) IDEs"
    echo "(3) Github Desktop[f] (4) Containers[n][f]"
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
            "$SCRIPTS_FOLDER"/modules/packages/development/github_desktop.sh "flatpak"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/development/containers.sh
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
    echo "(1) Nodejs LTS[o]     (2) openJDK 21 LTS[o]"
    echo "(3) openjfx 21 LTS[o]"
    echo "(p) Previous Menu     (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/development/nodejs.sh
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/development/openjdk.sh
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/development/openjfx.sh
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
    echo "(1) VIM[n]                            (2) VSCodium[f]"
    echo "(3) Geany[f]                          (4) Intellij IDEA[o]"
    echo "(5) Pycharm[o]"
    echo "(p) Previous Menu                     (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/development/vim.sh
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/development/vscodium.sh "flatpak"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/development/geany.sh "flatpak"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/development/idea.sh
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/development/pycharm.sh
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
    echo "(1) Fedora Media Writer[f]        (2) Raspberry Pi Imager[f]"
    echo "(3) GtkHash[f]                    (4) MissionCenter[f]"
    echo "(5) Virtualization[n]"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/utilities/fedora_media_writer.sh "flatpak"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/utilities/rpi_imager.sh "flatpak"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/utilities/gtkhash.sh "flatpak"
            ;;

        4)
            flatpak install --user -y flathub io.missioncenter.MissionCenter
            ;;
        
        5)
            "$SCRIPTS_FOLDER"/modules/packages/utilities/virtualization.sh
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
    echo "(1) Setup xbox controller       (2) Add user to libvirt group"
    echo "(m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            sudo modprobe xpad
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/misc/check_for_libvirt_group.sh
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

ostree_menu(){
    echo "--------------------------"
    echo "|   Assorted Native Apps |"
    echo "--------------------------"
    echo ""
    echo "(1) AMD Video Acceleration             (2) Audio/Video Codecs"
    echo "(3) Unhide Firefox                     (4) Brave Browser"
    echo "(5) Dropbox                            (6) Steam"
    echo "(m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/hardware/amd_codecs.sh
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/internet/firefox.sh "unhide"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/internet/brave.sh "native"
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/internet/dropbox.sh "native"
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
        ostree_menu
        ;;
        
    esac
    unset input
    ostree_menu
}

main_menu
