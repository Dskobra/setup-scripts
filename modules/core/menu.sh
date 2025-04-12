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
    echo "(1) Hardware                          (2) KDE Apps"
    echo "(3) Internet Apps                     (4) Multimedia Apps"
    echo "(5) Gaming Apps                       (6) Dev Apps"
    echo "(7) Extra Apps"
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
            native_dev_menu
            ;;

        7)
            native_extras_menu
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
    echo "------------------------"
    echo "|Hardware|[NATIVE(RPM)]|"
    echo "------------------------"
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
    echo "------------------------"
    echo "|KDE Apps|[NATIVE(RPM)]|"
    echo "------------------------"
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
    echo "-----------------------------"
    echo "|Internet Apps|[NATIVE(RPM)]|"
    echo "-----------------------------"
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
    echo "-------------------------------"
    echo "|Multimedia Apps|[NATIVE(RPM)]|"
    echo "-------------------------------"
    echo ""
    echo "(1) VLC Media Player      (2) OpenShot"
    echo "(3) xfburn"
    echo "(f) Flatpak/Other"
    echo "(m) Main Menu             (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in


        1)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/vlc.sh "native"
            ;;
        
        2)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/openshot.sh "native"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
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
    echo "---------------------------"
    echo "|Gaming Apps|[NATIVE(RPM)]|"
    echo "---------------------------"
    echo ""
    echo "(1) Steam                  (2) Lutris"
    echo "(f) Flatpak/Other"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in


        1)  
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
            "$SCRIPTS_FOLDER"/modules/packages/gaming/game_runtimes.sh "native"
            "$SCRIPTS_FOLDER"/modules/packages/gaming/steam.sh "native"
            ;;

        2) 
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
            "$SCRIPTS_FOLDER"/modules/packages/gaming/game_runtimes.sh "native"
            "$SCRIPTS_FOLDER"/modules/packages/gaming/lutris.sh "native"
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

native_dev_menu(){
    echo "------------------------"
    echo "|Dev Apps|[NATIVE(RPM)]|"
    echo "------------------------"
    echo ""
    echo "(1) Git                        (2) Kommit"
    echo "(3) VIM                        (4) VSCodium"
    echo "(5) Geany                      (6) C/C++ Compiler"
    echo "(7) Python Dev Packages        (8) Containers"
    echo "(9) Virtualization             (10) Lamp Stack"
    echo "(f) Flatpak/Other"
    echo "(m) Main Menu                  (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in


        1)  
            "$SCRIPTS_FOLDER"/modules/packages/development/git.sh "git"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/development/git.sh "kommit"
            ;;
        
        3)
            "$SCRIPTS_FOLDER"/modules/packages/development/vim.sh
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/development/vscodium.sh "native"
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/development/geany.sh "native"
            ;;
        
        6)
            "$SCRIPTS_FOLDER"/modules/packages/development/package_tools.sh
            
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/development/python_tools.sh
           
            ;;

        8)
            "$SCRIPTS_FOLDER"/modules/packages/development/containers.sh
            ;;

        9)
            "$SCRIPTS_FOLDER"/modules/packages/development/virtualization.sh
            ;;

        10)
            "$SCRIPTS_FOLDER"/modules/packages/development/lamp.sh
            ;;

        f | F)
            flatpak_dev_menu
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
        native_dev_menu
        ;;
        
    esac
    unset input
    native_dev_menu
}

native_extras_menu(){
    echo "--------------------------"
    echo "|Extra Apps|[NATIVE(RPM)]|"
    echo "--------------------------"
    echo ""
    echo "(1) LibreOffice               (2) KeePassXC"
    echo "(f) Flatpak/Other"
    echo "(m) Main Menu                 (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/extras/libreoffice.sh "native"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/extras/keepassxc.sh "native"
            ;;

        f | F)
            flatpak_extras_menu
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
            native_extras_menu
            ;;
            
        esac
        unset input
        native_extras_menu
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
    echo "(1) Steam                   (2) Lutris"
    echo "(3) Discord                 (4) Prism Launcher"                
    echo "(5) Dolphin                 (6) Cemu "
    echo "(7) WoWUp                   (8) Warcraft Logs"
    echo "(9) WeakAuras Companion"
    echo "(n) Native Apps"
    echo "(m) Main Menu               (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in


        1) 
            "$SCRIPTS_FOLDER"/modules/packages/gaming/game_runtimes.sh "flatpak"
            "$SCRIPTS_FOLDER"/modules/packages/gaming/steam.sh "flatpak"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/game_runtimes.sh "flatpak"
            "$SCRIPTS_FOLDER"/modules/packages/gaming/lutris.sh "flatpak"
            ;;


        3)  
            "$SCRIPTS_FOLDER"/modules/packages/gaming/discord.sh "other"
            ;;
        
        4)
            flatpak install --user -y flathub org.prismlauncher.PrismLauncher
            ;;

        5)
            flatpak install --user -y flathub org.DolphinEmu.dolphin-emu
            ;;

        6)
            flatpak install --user -y flathub info.cemu.Cemu
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/wow_clients.sh "wowup"
            ;;

        8)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/wow_clients.sh "wclogs"
            ;;

        9)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/wow_clients.sh "wacompanion"
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

flatpak_dev_menu(){
    echo "--------------------------"
    echo "|Dev Apps|[FLATPAK/OTHER]|"
    echo "--------------------------"
    echo ""
    echo "(1) Intellij IDEA                 (2) Pycharm"
    echo "(3) Podman Desktop                (4) Nodejs LTS"
    echo "(5) openJDK 21 LTS                (6) openjfx 21 LTS"
    echo "(n) Native Apps"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in


        1)
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh "idea"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh "pycharm"
            
            ;;

        3)
            flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/development/nodejs.sh
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh "openjdk"
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh "openjfx"
            ;;

        n | N)
            native_dev_menu
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
        flatpak_dev_menu
        ;;
        
    esac
    unset input
    flatpak_dev_menu
}

flatpak_extras_menu(){
    echo "----------------------------"
    echo "|Extra Apps|[FLATPAK/OTHER]|"
    echo "----------------------------"
    echo ""
    echo "(1) LibreOffice               (2) Bookup"
    echo "(3) Bitwarden                 (4) KeePassXC"
    echo "(5) Raspberry Pi Imager       (6) GtkHash"
    echo "(7) MissionCenter             (8) Gpu-Viewer"
    echo "(n) Native Apps"
    echo "(m) Main Menu                 (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/extras/libreoffice.sh "flatpak"
            ;;

        2)
            flatpak install --user flathub org.gnome.gitlab.ilhooq.Bookup
            ;;

        3)
            flatpak install --user -y flathub com.bitwarden.desktop
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/extras/keepassxc.sh "flatpak"
            ;;

        5)
            flatpak install --user -y flathub org.raspberrypi.rpi-imager
            ;;

        6)
            flatpak install --user -y flathub org.gtkhash.gtkhash
            ;;

        7)
            flatpak install --user -y flathub io.missioncenter.MissionCenter
            ;;

        8)
            flatpak install --user -y flathub io.github.arunsivaramanneo.GPUViewer
            ;;

        n | N)
            native_extras_menu
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
            flatpak_extras_menu
            ;;
            
        esac
        unset input
        flatpak_extras_menu
}

########################################
# End flatpak/other menus
########################################

main_menu