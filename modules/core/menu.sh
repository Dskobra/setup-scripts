#!/usr/bin/bash

########################################
# Native menus
########################################
native_menu(){
    echo "---------------------------"   
    echo "|   DSK's Setup Scripts   |"
    echo "---------------------------" 
    echo ""
    echo "Version: $VERSION"
    echo "$COPYRIGHT"
    echo "Released under the MIT license"
    echo ""
    echo "/NATIVE MENU/"
    echo ""
    echo "(1) Swap Menus                    (2) Hardware"
    echo "(3) Desktop Apps                  (4) Internet"
    echo "(5) Multimedia                    (6) Gaming"
    echo "(7) Office                        (8) Development"
    echo "(9) Utilities                     (10) Misc"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in


        1)
            flatpak_menu
            ;;

        2)
            native_hardware_menu
            ;;

        3)
            native_desktop_apps_menu
            ;;

        4)
            native_internet_menu
            ;;

        5)
            native_multimedia_menu
            ;;

        6)
            native_gaming_menu
            ;;

        7)
            native_office_menu
            ;;
        8)
            native_development_menu
            ;;

        9)
            native_utils_menu
            ;;

        10)
            miscellaneous_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            native_menu
            ;;

        esac
        unset input
        native_menu
}

native_hardware_menu(){
    echo "----------------"
    echo "|   Hardware   |"
    echo "----------------"
    echo ""
    echo "Hardware and device drivers etc"
    echo ""
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
            native_menu
            ;;
            
        M)
            native_menu
            ;;
        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            native_hardware_menu
            ;;
            
        esac
        unset input
        native_hardware_menu
}

native_desktop_apps_menu(){
    echo "--------------------"
    echo "|   Desktop Apps   |"
    echo "--------------------"
    echo ""
    echo "Apps for popular desktops"
    echo ""
    echo "(1) KDE                (2) GNOME"
    echo "(m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            native_kde_desktop_menu
            ;;
        
        2)
            native_gnome_desktop_menu
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/mate_apps.sh
            ;;

        m)
            native_menu
            ;;

        M)
            native_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            native_desktop_apps_menu
            ;;
            
        esac
        unset input
        native_desktop_apps_menu
}

native_kde_desktop_menu(){
    echo "-----------"
    echo "|   KDE   |"
    echo "-----------"
    echo ""
    echo "(1) KDE Patience          (2) Kolourpaint "
    echo "(3) Kleopatra             (4) KDE ISO Image Writer"
    echo "(5) Kate                  (6) Plasma X11"
    echo "(7) K3b"
    echo "(f) Flatpak Apps"
    echo "(p) Previous Menu         (m) Main Menu "
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/kde/kpat.sh "native"
            ;;
        
        2)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/kde/kolourpaint.sh "native"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/kde/kleopatra.sh "native"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/kde/kde_iso_image_writer.sh "native"
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/kde/kate.sh "native"
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/kde/plasma_x11.sh 
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/kde/k3b.sh
            ;;

        f | F)
            flatpak_kde_desktop_menu
            ;;

        p | P)
            native_desktop_apps_menu
            ;;

        m | M)
            native_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            native_kde_desktop_menu
            ;;
            
        esac
        unset input
        native_kde_desktop_menu
}

native_gnome_desktop_menu(){
    echo "-----------"
    echo "|   Gnome  |"
    echo "-----------"
    echo ""
    echo "(1) Dconf Editor           (2) Pavucontrol"
    echo "(3) Gnome Tweaks           (4) Gnome X11"
    echo "(f) Flatpak Apps"
    echo "(p) Previous Menu          (m) Main Menu "
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/gnome/dconf_editor.sh "native"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/gnome/pavucontrol.sh "native"
            ;;
        
        3)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/gnome/gnome_tweaks.sh "native"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/desktops/gnome/gnome_x11.sh
            ;;

        f | F)
            flatpak_gnome_desktop_menu
            ;;

        p | P)
            native_desktop_apps_menu
            ;;

        m | M)
            native_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            native_gnome_desktop_menu
            ;;
            
        esac
        unset input
        native_gnome_desktop_menu
}

native_internet_menu(){
    echo "----------------"
    echo "|   Internet   |"
    echo "----------------"
    echo ""
    echo "(1) Firefox                (2) Brave Browser"
    echo "(3) Dropbox                (4) Transmissionbt"
    echo "(5) Remmina"
    echo "(f) Flatpak Apps"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/internet/firefox.sh "native"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/internet/brave.sh "native"
            ;;
        
        3)
            "$SCRIPTS_FOLDER"/modules/packages/internet/dropbox.sh "native"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/internet/transmission.sh "native"
            ;;

        5)  
            "$SCRIPTS_FOLDER"/modules/packages/internet/remmina.sh "native"
            ;;

        f | F)
            flatpak_gnome_desktop_menu
            ;;

        m | M)
            native_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            native_internet_menu
            ;;
            
        esac
        unset input
        native_internet_menu
}

native_multimedia_menu(){
    echo "------------------"
    echo "|   Multimedia   |"
    echo "------------------"
    echo ""
    echo "(1) VLC Media Player       (2) OpenShot"
    echo "(3) xfburn                 (4) Audio/Video Codecs"
    echo "(f) Flatpak Apps"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/vlc.sh "native"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/openshot.sh "native"
            ;;
        
        3)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/xfburn.sh
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
            ;;

        f | F)
            flatpak_multimedia_menu
            ;;
        
        m | M)
            native_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            native_multimedia_menu
            ;;
            
        esac
        unset input
        native_multimedia_menu
}

native_gaming_menu(){
    echo "--------------"
    echo "|   Gaming   |"
    echo "--------------"
    echo ""
    echo "(1) Game Clients           (2) Tools"
    echo "(f) Flatpak Apps"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            native_gaming_clients_menu
            ;;

        2) 
            native_gaming_tools_menu
            ;;

        f | F)
            flatpak_gaming_menu
            ;;
        m | M)
            native_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            native_gaming_menu
            ;;
            
        esac
        unset input
        native_gaming_menu
}

native_gaming_clients_menu(){
    echo "----------------------"
    echo "|   Gaming Clients   |"
    echo "---------------- ------"
    echo ""
    echo "(1) Steam                  (2) Lutris"
    echo "(f) Flatpak Apps"
    echo "(p) Previous Menu          (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            "$SCRIPTS_FOLDER"/modules/packages/gaming/steam.sh "native"
            ;;

        2) 
            "$SCRIPTS_FOLDER"/modules/packages/gaming/lutris.sh "native"
            ;;

        f | F)
            flatpak_gaming_clients_menu
            ;;

        p | P)
            native_gaming_menu
            ;;

        m | M)
            native_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            native_gaming_clients_menu
            ;;
            
        esac
        unset input
        native_gaming_clients_menu
}

native_gaming_tools_menu(){
    echo "--------------------"
    echo "|   Gaming Tools   |"
    echo "--------------------"
    echo ""
    echo "Runtimes include mangohud, gamescope and gamemode"
    echo ""
    echo "(1) Runtimes"
    echo "(f) Flatpak Apps"
    echo "(p) Previous Menu          (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/game_runtimes.sh "native"
            ;;

        2)
            flatpak install --user -y com.github.Matoking.protontricks
            ;;

        3)
            flatpak install --user -y flathub com.vysp3r.ProtonPlus
            ;;

        f | F)
            flatpak_gaming_tools_menu
            ;;

        p | P)
            native_gaming_menu
            ;;
        
        P)
            native_gaming_menu
            ;;

        m | M)
            native_menu
            ;;
        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            native_gaming_tools_menu
            ;;
            
        esac
        unset input
        native_gaming_tools_menu
}

native_office_menu(){
    echo "--------------"
    echo "|   Office   |"
    echo "--------------"
    echo ""
    echo "(1) LibreOffice               (2) QOwnNotes"
    echo "(3) Marknote                  (4) Claws-Mail"
    echo "(5) Thunderbird               (6) KeePassXC"
    echo "(f) Flatpak Apps"
    echo "(m) Main Menu                 (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/office/libreoffice.sh "native"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/office/qownnotes.sh "native"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/office/marknote.sh "native"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/office/claws_mail.sh "native"
            ;;
        
        5)
            "$SCRIPTS_FOLDER"/modules/packages/office/thunderbird.sh "native"
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/office/keepassxc.sh "native"
            ;;

        f | F)
            flatpak_office_menu
            ;;

        m | M)
            native_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            native_office_menu
            ;;
            
        esac
        unset input
        native_office_menu
}

native_development_menu(){
    echo "-------------------"
    echo "|   Development   |"
    echo "-------------------"
    echo ""
    echo "Mostly IDEs and compilers."
    echo ""
    echo "(1) SDKs              (2) IDEs"
    echo "(3) Github Desktop    (4) Containers"
    echo "(5) Lamp Stack"
    echo "(f) Flatpak Apps"
    echo "(m) Main Menu         (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            native_sdks_menu
            ;;
        2)
            native_ides_menu
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/development/github_desktop.sh "native"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/development/containers.sh
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/development/lamp.sh
            ;;

        f | F)
            flatpak_development_menu
            ;;

        m | M)
            native_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        native_development_menu
        ;;
        
    esac
    unset input
    native_development_menu
}

native_sdks_menu(){
    echo "-----------"
    echo "|  SDKs   |"
    echo "-----------"
    echo ""
    echo "(1) C/C++ Compiler        (2) Python Dev Packages"
    echo "(p) Previous Menu         (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/development/package_tools.sh
            ;;
        
        2)
            "$SCRIPTS_FOLDER"/modules/packages/development/python_tools.sh
            ;;
        f | F)
            flatpak_sdks_menu
            ;;
        p | P)
            native_development_menu
            ;;
        
        m | M)
            native_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        native_sdks_menu
        ;;
        
    esac
    unset input
    native_sdks_menu
}

native_ides_menu(){
    echo "------------"
    echo "|   IDEs   |"
    echo "------------"
    echo ""
    echo "(1) VIM                               (2) VSCodium"
    echo "(3) Geany"
    echo "(f) Flatpak Apps"
    echo "(p) Previous Menu                     (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/development/vim.sh
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/development/vscodium.sh "native"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/development/geany.sh "native"
            ;;

        F | F)
            flatpak_ides_menu
            ;;

        p | P)
            native_development_menu
            ;;

        m | M)
            native_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        native_ides_menu
        ;;
        
    esac
    unset input
    native_ides_menu
}

native_utils_menu(){
    echo "-----------------"
    echo "|   Utilities   |"
    echo "-----------------"
    echo ""
    echo "(1) Fedora Media Writer           (2) Raspberry Pi Imager"
    echo "(3) GtkHash                       (4) Virtualization"
    echo "(f) Flatpak Apps"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/utilities/fedora_media_writer.sh "native"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/utilities/rpi_imager.sh "native"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/utilities/gtkhash.sh "native"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/utilities/virtualization.sh
            ;;

        f | F)
            flatpak_utils_menu
            ;;

        m | M)
            native_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        native_utils_menu
        ;;
        
    esac
    unset input
    native_utils_menu
}

miscellaneous_menu(){
    echo "---------------------"
    echo "|   Miscellaneous   |"
    echo "---------------------"
    echo ""
    echo "(1) Setup xbox controller      (2) Add user to libvirt group"
    echo "(3) Remove Audio/Video Codecs  (4) Remove AMD hardware accelerated codecs "
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

        3)
            "$SCRIPTS_FOLDER"/modules/misc/remove_codecs.sh
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/misc/remove_amd_codecs.sh
            ;;

        m)
            native_menu
            ;;

        M)
            native_menu
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
########################################
# End native menus
########################################

########################################
# Flatpak/other menus
########################################
flatpak_menu(){
    echo "---------------------------"   
    echo "|   DSK's Setup Scripts   |"
    echo "---------------------------" 
    echo ""
    echo "Version: $VERSION"
    echo "$COPYRIGHT"
    echo "Released under the MIT license"
    echo ""
    echo "/FLATPAK MENU/"
    echo ""
    echo "(1) Swap Menus                    (2) Desktop Apps"      
    echo "(3) Internet                      (4) Multimedia"
    echo "(5) Gaming                        (6) Office"
    echo "(7) Development                   (8) Utilities"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            native_menu
            ;;

        2)
            flatpak_desktop_apps_menu
            ;;

        3)
            flatpak_internet_menu
            ;;

        4)
            flatpak_multimedia_menu
            ;;

        5)
            flatpak_gaming_menu
            ;;

        6)
            flatpak_office_menu
            ;;
        7)
            flatpak_development_menu
            ;;

        8)
            flatpak_utils_menu
            ;;

        9)
            miscellaneous_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            flatpak_menu
            ;;

        esac
        unset input
        flatpak_menu
}

flatpak_desktop_apps_menu(){
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
            flatpak_kde_desktop_menu
            ;;
        
        2)
            flatpak_gnome_desktop_menu
            ;;

        m)
            flatpak_menu
            ;;

        M)
            flatpak_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            flatpak_desktop_apps_menu
            ;;
            
        esac
        unset input
        flatpak_desktop_apps_menu
}

flatpak_kde_desktop_menu(){
    echo "-----------"
    echo "|   KDE   |"
    echo "-----------"
    echo ""   
    echo "(1) KDE Patience       (2) Kolourpaint"
    echo "(3) Kleopatra          (4) KDE ISO Image Writer"
    echo "(n) Native Apps"
    echo "(p) Previous Menu      (m) Main Menu"
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

        n | N)
            native_kde_desktop_menu
            ;;
        p | P)
            flatpak_desktop_apps_menu
            ;;

        m | M)
            flatpak_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            flatpak_kde_desktop_menu
            ;;
            
        esac
        unset input
        flatpak_kde_desktop_menu
}

flatpak_gnome_desktop_menu(){
    echo "-----------"
    echo "|   Gnome  |"
    echo "-----------"
    echo ""
    echo "(1) Dconf Editor           (2) Pavucontrol"
    echo "(n) Native Apps"
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

        n | N)
            native_gnome_desktop_menu
            ;;
        p | P)
            flatpak_desktop_apps_menu
            ;;

        m | M)
            flatpak_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            flatpak_gnome_desktop_menu
            ;;
            
        esac
        unset input
        flatpak_gnome_desktop_menu
}

flatpak_internet_menu(){
    echo "----------------"
    echo "|   Internet   |"
    echo "----------------"
    echo ""
    echo "(1) Firefox                (2) Brave Browser"
    echo "(3) Dropbox                (4) Transmissionbt"
    echo "(5) Remmina"
    echo "(n) Native Apps"
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

        n | N)
            native_internet_menu
            ;;

        m | M)
            flatpak_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            flatpak_internet_menu
            ;;
            
        esac
        unset input
        flatpak_internet_menu
}

flatpak_multimedia_menu(){
    echo "------------------"
    echo "|   Multimedia   |"
    echo "------------------"
    echo ""
    echo "(1) VLC Media Player          (2) OBS Studio"
    echo "(3) OpenShot"
    echo "(m) Main Menu                 (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/vlc.sh "flatpak"
            ;;

        2)
            flatpak install --user -y flathub com.obsproject.Studio
            ;;
        
        3)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/openshot.sh "flatpak"
            ;;

        n | N)
            native_multimedia_menu
            ;;
        
        m | M)
            flatpak_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            flatpak_multimedia_menu
            ;;
            
        esac
        unset input
        flatpak_multimedia_menu
}

flatpak_gaming_menu(){
    echo "--------------"
    echo "|   Gaming   |"
    echo "--------------"
    echo ""
    echo "(1) Game Clients           (2) Tools"
    echo "(3) WoW Clients            (4) Other"
    echo "(n) Native Apps"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            flatpak_gaming_clients_menu
            ;;

        2) 
            flatpak_gaming_tools_menu
            ;;

        3)
            other_gaming_wow_clients_menu
            ;;

        4)
            flatpak_gaming_other_menu
            ;;

        n | N)
            native_gaming_menu
            ;;

        m | M)
            flatpak_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            flatpak_gaming_menu
            ;;
            
        esac
        unset input
        flatpak_gaming_menu
}

flatpak_gaming_clients_menu(){
    echo "----------------------"
    echo "|   Gaming Clients   |"
    echo "---------------- ------"
    echo ""
    echo "(1) Steam                     (2) Lutris"
    echo "(3) Bottles"
    echo "(n) Native Apps"
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

        n | N)
            native_gaming_clients_menu
            ;;

        p | P)
            flatpak_gaming_menu
            ;;


        m | M)
            flatpak_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            flatpak_gaming_clients_menu
            ;;
            
        esac
        unset input
        flatpak_gaming_clients_menu
}

other_gaming_wow_clients_menu(){
    echo "----------------------"
    echo "|  Clients  for WoW   |"
    echo "---------------- ------"
    echo ""
    echo "Addon managers and extra stuff for World of Warcraft"
    echo ""   
    echo "(1) WoWUp                     (2) Warcraft Logs"
    echo "(3) Weak Auras Companion"
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
            flatpak_gaming_menu
            ;;

        P)
            flatpak_gaming_menu
            ;;


        m)
            flatpak_menu
            ;;

        M)
            flatpak_menu
            ;;
        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            other_gaming_wow_clients_menu
            ;;
            
        esac
        unset input
        other_gaming_wow_clients_menu
}

flatpak_gaming_tools_menu(){
    echo "--------------------"
    echo "|   Gaming Tools   |"
    echo "--------------------"
    echo ""
    echo "Runtimes include mangohud, gamescope and gamemode"
    echo ""   
    echo "(1) Runtimes                  (2) Protontricks"
    echo "(3) Proton Plus"
    echo "(n) Native Apps"
    echo "(p) Previous Menu             (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/game_runtimes.sh "flatpak"
            ;;

        2)
            flatpak install --user -y com.github.Matoking.protontricks
            ;;

        3)
            flatpak install --user -y flathub com.vysp3r.ProtonPlus
            ;;

        n | N)
            native_gaming_tools_menu
            ;;

        p | P)
            flatpak_gaming_menu
            ;;

        m | M)
            flatpak_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            flatpak_gaming_tools_menu
            ;;
            
        esac
        unset input
        flatpak_gaming_tools_menu
}

flatpak_gaming_other_menu(){
    echo "-----------------"
    echo "|   Misc Stuff   |"
    echo "-----------------"
    echo ""   
    echo "(1) Discord                (2) Vesktop"
    echo "(3) Prism Launcher         (4) Dolphin"
    echo "(5) Cemu                   (6) XIVLauncher"
    echo "(p) Previous Menu          (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            "$SCRIPTS_FOLDER"/modules/packages/gaming/discord.sh "flatpak"
            ;;

        2)
            flatpak install --user -y flathub dev.vencord.Vesktop
            ;;
        
        3)
            flatpak install --user -y flathub org.prismlauncher.PrismLauncher
            ;;

        4)
            flatpak install --user -y flathub org.DolphinEmu.dolphin-emu
            ;;

        5)
            flatpak install --user -y flathub info.cemu.Cemu
            ;;

        6)
            flatpak install --user -y flathub dev.goats.xivlauncher
            ;;

        m)
            flatpak_menu
            ;;

        p)
            flatpak_gaming_menu
            ;;

        P)
            flatpak_gaming_menu
            ;;

        M)
            flatpak_menu
            ;;
        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            flatpak_gaming_other_menu
            ;;
            
        esac
        unset input
        flatpak_gaming_other_menu
}

flatpak_office_menu(){
    echo "--------------"
    echo "|   Office   |"
    echo "--------------"
    echo ""
    echo "(1) LibreOffice           (2) QOwnNotes"
    echo "(3) Marknote              (4) Claws-Mail"
    echo "(5) Thunderbird           (6) Bitwarden"
    echo "(7) KeePassXC"
    echo "(n) Native Apps"
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

        n | N)
            native_office_menu
            ;;

        m | M)
            flatpak_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            flatpak_office_menu
            ;;
            
        esac
        unset input
        flatpak_office_menu
}

flatpak_development_menu(){
    echo "-------------------"
    echo "|   Development   |"
    echo "-------------------"
    echo ""
    echo "(1) SDKs              (2) IDEs"
    echo "(3) Github Desktop    (4) Podman Desktop"
    echo "(n) Native Apps"
    echo "(m) Main Menu         (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            flatpak_sdks_menu
            ;;
        2)
            flatpak_ides_menu
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/development/github_desktop.sh "flatpak"
            ;;

        4)
            flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
            ;;
        n | N)
            native_development_menu
            ;;

        m | M)
            flatpak_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        flatpak_development_menu
        ;;
        
    esac
    unset input
    flatpak_development_menu
}

flatpak_sdks_menu(){
    echo "-----------"
    echo "|  SDKs   |"
    echo "-----------"
    echo ""
    echo "(1) Nodejs LTS        (2) openJDK 21 LTS"
    echo "(3) openjfx 21 LTS"
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

        n | N)
            native_sdks_menu
            ;;
        
        p | P)
            flatpak_development_menu
            ;;
        
        m | M)
            flatpak_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        flatpak_sdks_menu
        ;;
        
    esac
    unset input
    flatpak_sdks_menu
}

flatpak_ides_menu(){
    echo "------------"
    echo "|   IDEs   |"
    echo "------------"
    echo ""   
    echo "(1) VSCodium                          (2) Geany"
    echo "(3) Intellij IDEA                     (4) Pycharm"
    echo "(p) Previous Menu                     (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/development/vscodium.sh "flatpak"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/development/geany.sh "flatpak"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/development/idea.sh
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/development/pycharm.sh
            ;;

        n | N)
            native_ides_menu
            ;;

        p)
            flatpak_development_menu
            ;;

        P)
            flatpak_development_menu
            ;;

        m)
            flatpak_menu
            ;;

        M)
            flatpak_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        flatpak_ides_menu
        ;;
        
    esac
    unset input
    flatpak_ides_menu
}

flatpak_utils_menu(){
    echo "-----------------"
    echo "|   Utilities   |"
    echo "-----------------"
    echo ""
    echo "(1) Fedora Media Writer           (2) Raspberry Pi Imager"
    echo "(3) GtkHash                       (4) MissionCenter"
    echo "(n) Native Apps"
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

        n | N)
            native_utils_menu
            ;;

        m | M)
            flatpak_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        flatpak_utils_menu
        ;;
        
    esac
    unset input
    flatpak_utils_menu
}

########################################
# End flatpak/other menus
########################################
package_type_chooser(){
    echo "Please input the package type you'd like to use."
    echo "----------------------------------------"
    echo "[1] Native [2] Flatpak [3] Help [0] Exit"
    echo "----------------------------------------"
    echo "(empty) default option which is native"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        native_menu
    elif [ "$input" = 2 ] 
    then
        flatpak_menu
    elif [ "$input" = 3 ]
    then
        "$SCRIPTS_FOLDER"/modules/core/packages_help_page.sh
        package_type_chooser
    elif [ "$input" = 0 ]
    then
        echo "Will now exit."
        exit
    else
        echo "Invalid option or error has occurred."
    fi
}

package_type_chooser