#!/usr/bin/bash

########################################
# Native menus
########################################
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
    echo "(1) Hardware Apps                     (2) KDE Apps"
    echo "(3) Internet Apps                     (4) Multimedia Apps"
    echo "(5) Gaming Apps                       (6) Office Apps"
    echo "(7) Development Apps                  (8) Utility Apps"
    echo "(9) Misc"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in


        1)
            hardware_menu
            ;;

        2)
            native_kde_desktop_menu
            ;;

        3)
            native_internet_menu
            ;;

        4)
            native_multimedia_menu
            ;;

        5)
            native_gaming_menu
            ;;

        6)
            native_office_menu
            ;;
        7)
            native_development_menu
            ;;

        8)
            native_utils_menu
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
            main_menu
            ;;

        esac
        unset input
        main_menu
}

hardware_menu(){
    echo "-------------------"
    echo "|Hardware|[NATIVE]|"
    echo "-------------------"
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

native_kde_desktop_menu(){
    echo "-------------------"
    echo "|KDE Apps|[NATIVE]|"
    echo "-------------------"
    echo ""
    echo "(1) KDE Patience          (2) Kolourpaint "
    echo "(3) Kleopatra             (4) KDE ISO Image Writer"
    echo "(5) Kate                  (6) K3b"
    echo "(7) Krdc                  (8) Krfb"
    echo "(f) Flatpak/Other         (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/kde/kpat.sh "native"
            ;;
        
        2)
            "$SCRIPTS_FOLDER"/modules/packages/kde/kolourpaint.sh "native"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/kde/kleopatra.sh "native"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/kde/kde_iso_image_writer.sh "native"
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/kde/kate.sh "native"
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/kde/k3b.sh
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/kde/krdc.sh
            ;;

        8)
            "$SCRIPTS_FOLDER"/modules/packages/kde/krfb.sh
            ;;

        f | F)
            flatpak_kde_desktop_menu
            ;;

        m | M)
            main_menu
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

native_internet_menu(){
    echo "------------------------"
    echo "|Internet Apps|[NATIVE]|"
    echo "------------------------"
    echo ""
    echo "(1) Firefox                (2) Brave Browser"
    echo "(3) Transmissionbt         (4) Remmina"
    echo "(f) Flatpak/Other"
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
            "$SCRIPTS_FOLDER"/modules/packages/internet/transmission.sh "native"
            ;;

        4)  
            "$SCRIPTS_FOLDER"/modules/packages/internet/remmina.sh "native"
            ;;

        f | F)
            flatpak_internet_menu
            ;;

        m | M)
            main_menu
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
    echo "--------------------------"
    echo "|Multimedia Apps|[NATIVE]|"
    echo "--------------------------"
    echo ""
    echo "(1) Audio/Video Codecs    (2) VLC Media Player"
    echo "(3) OpenShot              (4) xfburn "
    echo "(f) Flatpak/Other"
    echo "(m) Main Menu             (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/vlc.sh "native"
            ;;
        
        3)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/openshot.sh "native"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/xfburn.sh
            ;;

        f | F)
            flatpak_multimedia_menu
            ;;
        
        m | M)
            main_menu
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
    echo "----------------------"
    echo "|Gaming Apps|[NATIVE]|"
    echo "----------------------"
    echo ""
    echo "(1) Clients/Tools"
    echo "(f) Flatpak/Other"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            native_gaming_clients_tools_menu
            ;;

        f | F)
            flatpak_gaming_menu
            ;;
        m | M)
            main_menu
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

native_gaming_clients_tools_menu(){
    echo "------------------------"
    echo "|Clients/Tools|[NATIVE]|"
    echo "------------------------"
    echo ""
    echo "Runtimes include mangohud, gamescope and gamemode"
    echo ""
    echo "(1) Steam                  (2) Lutris"
    echo "(3) Runtimes"
    echo "(f) Flatpak/Other"
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

        3)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/game_runtimes.sh "native"
            ;;

        f | F)
            flatpak_gaming_clients_tools_menu
            ;;

        p | P)
            native_gaming_menu
            ;;

        m | M)
            main_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            native_gaming_clients_tools_menu
            ;;
            
        esac
        unset input
        native_gaming_clients_tools_menu
}

native_office_menu(){
    echo "----------------------"
    echo "|Office Apps|[NATIVE]|"
    echo "----------------------"
    echo ""
    echo "(1) LibreOffice               (2) Marknote"
    echo "(3) Claws-Mail                (4) Thunderbird"
    echo "(5) KeePassXC"
    echo "(f) Flatpak/Other"
    echo "(m) Main Menu                 (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/office/libreoffice.sh "native"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/office/marknote.sh "native"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/office/claws_mail.sh "native"
            ;;
        
        4)
            "$SCRIPTS_FOLDER"/modules/packages/office/thunderbird.sh "native"
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/office/keepassxc.sh "native"
            ;;

        f | F)
            flatpak_office_menu
            ;;

        m | M)
            main_menu
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
    echo "---------------------------"
    echo "|Development Apps|[NATIVE]|"
    echo "---------------------------"
    echo ""
    echo "Mostly IDEs and compilers."
    echo ""
    echo "(1) VIM                        (2) VSCodium"
    echo "(3) Geany                      (4) C/C++ Compiler"
    echo "(5) Python Dev Packages        (6) Github Desktop"
    echo "(7) Containers                 (8) Lamp Stack"
    echo "(f) Flatpak/Other"
    echo "(m) Main Menu                  (0) Exit"
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

        4)
            "$SCRIPTS_FOLDER"/modules/packages/development/package_tools.sh
            ;;
        
        5)
            "$SCRIPTS_FOLDER"/modules/packages/development/python_tools.sh
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/development/github_desktop.sh "native"
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/development/containers.sh
            ;;

        8)
            "$SCRIPTS_FOLDER"/modules/packages/development/lamp.sh
            ;;

        f | F)
            flatpak_development_menu
            ;;

        m | M)
            main_menu
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

native_utils_menu(){
    echo "-----------------------"
    echo "|Utility Apps|[NATIVE]|"
    echo "-----------------------"
    echo ""
    echo "(1) Raspberry Pi Imager           (2) GtkHash"
    echo "(3) Virtualization"
    echo "(f) Flatpak/Other"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in


        1)
            "$SCRIPTS_FOLDER"/modules/packages/utilities/rpi_imager.sh "native"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/utilities/gtkhash.sh "native"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/utilities/virtualization.sh
            ;;

        f | F)
            flatpak_utils_menu
            ;;

        m | M)
            main_menu
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
    echo "(3) Remove Audio/Video Codecs"
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
########################################
# End native menus
########################################

########################################
# Flatpak/other menus
########################################
flatpak_kde_desktop_menu(){
    echo "--------------------------"
    echo "|KDE Apps|[FLATPAK/OTHER]|"
    echo "--------------------------"
    echo ""   
    echo "(1) KDE Patience       (2) Kolourpaint"
    echo "(3) Kleopatra          (4) KDE ISO Image Writer"
    echo "(n) Native Apps        (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/kde/kpat.sh "flatpak"
            ;;
        
        2)
            "$SCRIPTS_FOLDER"/modules/packages/kde/kolourpaint.sh "flatpak"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/kde/kleopatra.sh "flatpak"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/kde/kde_iso_image_writer.sh "flatpak"
            ;;

        n | N)
            native_kde_desktop_menu
            ;;

        m | M)
            main_menu
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

flatpak_internet_menu(){
    echo "-------------------------------"
    echo "|Internet Apps|[FLATPAK/OTHER]|"
    echo "-------------------------------"
    echo ""
    echo "(1) Firefox                (2) Brave Browser"
    echo "(3) Dropbox                (4) Transmissionbt"
    echo "(5) Remmina                (6) Rclone/Browser"
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
            flatpak install --user -y flathub com.dropbox.Client
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/internet/transmission.sh "flatpak"
            ;;

        5)  
            "$SCRIPTS_FOLDER"/modules/packages/internet/remmina.sh "flatpak"
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/internet/rclone.sh
            ;;

        n | N)
            native_internet_menu
            ;;

        m | M)
            main_menu
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
    echo "----------------------------------"
    echo "|Multimedia Apps|[FLATPAK/OTHER]|"
    echo "---------------------------------"
    echo ""
    echo "(1) VLC Media Player          (2) OBS Studio"
    echo "(3) OpenShot"
    echo "(n) Native Apps"
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
            main_menu
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
    echo "-----------------------------"
    echo "|Gaming Apps|[FLATPAK/OTHER]|"
    echo "-----------------------------"
    echo ""
    echo "(1) Clients/Tools          (2) Other"
    echo "(n) Native Apps"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            flatpak_gaming_clients_tools_menu
            ;;

        2) 
            flatpak_gaming_other_menu
            ;;

        n | N)
            native_gaming_menu
            ;;

        m | M)
            main_menu
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

flatpak_gaming_clients_tools_menu(){
    echo "-------------------------------"
    echo "|Clients/Tools|[FLATPAK/OTHER]|"
    echo "-------------------------------"
    echo ""
    echo "Runtimes include mangohud, gamescope and gamemode"
    echo ""
    echo "(1) Steam                     (2) Lutris"
    echo "(3) Runtimes                  (4) ProtonPlus"
    echo "(5) Protontricks"
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
            "$SCRIPTS_FOLDER"/modules/packages/gaming/game_runtimes.sh "flatpak"
            ;;

        4)
            flatpak install --user -y flathub com.vysp3r.ProtonPlus
            ;;

        5)
            flatpak install --user -y flathub com.github.Matoking.protontricks
            ;;

        n | N)
            native_gaming_clients_tools_menu
            ;;

        p | P)
            flatpak_gaming_menu
            ;;


        m | M)
            main_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            flatpak_gaming_clients_tools_menu
            ;;
            
        esac
        unset input
        flatpak_gaming_clients_tools_menu
}

flatpak_gaming_other_menu(){
    echo "----------------------------------"
    echo "|Misc Gaming Apps|[FLATPAK/OTHER]|"
    echo "----------------------------------"
    echo ""   
    echo "(1) Discord                (2) Vesktop"
    echo "(3) Prism Launcher         (4) Dolphin"
    echo "(5) Cemu                   (6) WoWUp"
    echo "(7) Warcraft Logs          (8) WeakAuras Companion"
    echo "(n) Native Apps"
    echo "(p) Previous Menu          (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            "$SCRIPTS_FOLDER"/modules/packages/gaming/discord.sh "other"
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
            "$SCRIPTS_FOLDER"/modules/packages/gaming/wow_clients.sh "wowup"
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/wow_clients.sh "wclogs"
            ;;

        8)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/wow_clients.sh "wacompanion"
            ;;

        n | N)
            native_gaming_other_menu
            ;;

        m)
            main_menu
            ;;

        p)
            flatpak_gaming_menu
            ;;

        P)
            flatpak_gaming_menu
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
            flatpak_gaming_other_menu
            ;;
            
        esac
        unset input
        flatpak_gaming_other_menu
}

flatpak_office_menu(){
    echo "-----------------------------"
    echo "|Office Apps|[FLATPAK/OTHER]|"
    echo "-----------------------------"
    echo ""
    echo "(1) LibreOffice           (2) Marknote"
    echo "(3) Claws-Mail            (4) Thunderbird"
    echo "(5) Bitwarden             (6) KeePassXC"
    echo "(n) Native Apps"
    echo "(m) Main Menu             (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/office/libreoffice.sh "flatpak"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/office/marknote.sh "flatpak"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/office/claws_mail.sh "flatpak"
            ;;
        
        4)
            "$SCRIPTS_FOLDER"/modules/packages/office/thunderbird.sh "flatpak"
            ;;

        5)
            flatpak install --user -y flathub com.bitwarden.desktop
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/office/keepassxc.sh "flatpak"
            ;;

        n | N)
            native_office_menu
            ;;

        m | M)
            main_menu
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
    echo "----------------------------------"
    echo "|Development Apps|[FLATPAK/OTHER]|"
    echo "----------------------------------"
    echo ""
    echo "(1) Nodejs LTS                 (2) openJDK 21 LTS"
    echo "(3) openjfx 21 LTS             (4) Intellij IDEA"
    echo "(5) Pycharm                    (6) Github Desktop"
    echo "(7) Podman Desktop"
    echo "(n) Native Apps"
    echo "(m) Main Menu                  (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in


        1)
            "$SCRIPTS_FOLDER"/modules/packages/development/nodejs.sh
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh "openjdk"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh "openjfx"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh "idea"
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh "pycharm"
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/development/github_desktop.sh "flatpak"
            ;;

        7)
            flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
            ;;

        n | N)
            native_development_menu
            ;;

        m | M)
            main_menu
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

flatpak_utils_menu(){
    echo "------------------------------"
    echo "|Utility Apps|[FLATPAK/OTHER]|"
    echo "------------------------------"
    echo ""
    echo "(1) Raspberry Pi Imager           (2) GtkHash"
    echo "(3) MissionCenter                 (4) Gpu-Viewer"
    echo "(n) Native Apps"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/utilities/rpi_imager.sh "flatpak"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/utilities/gtkhash.sh "flatpak"
            ;;

        3)
            flatpak install --user -y flathub io.missioncenter.MissionCenter
            ;;

        4)
            flatpak install --user -y flathub io.github.arunsivaramanneo.GPUViewer
            ;;

        n | N)
            native_utils_menu
            ;;

        m | M)
            main_menu
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

main_menu