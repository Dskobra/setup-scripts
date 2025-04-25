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
    echo "(h) Help                              (0) Exit"
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

        h | H)
            help
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
    echo "----------"
    echo "|Hardware|"
    echo "----------"
    echo ""
    echo "Hardware and device drivers etc"
    echo ""
    echo "/app name/            /source/                    /app name/                      /source/"
    echo "(1) Corectrl          (fedora)                    (2) Nvidia Driver               (rpmfusion)"
    echo "(3) CoolerControl     (fedora copr)               (4) OpenRGB                     (fedora)"
    echo "(5) Virtual Camera    (rpmfusion)"
    echo "(m) Main Menu                                     (h) Help"
    echo "(0) Exit"
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

        m)
            main_menu
            ;;
            
        M)
            main_menu
            ;;

        h | H)
            help
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
    echo "-----"
    echo "|KDE|"
    echo "-----"
    echo ""
    echo "/app name/            /source/                    /app name/                      /source/"
    echo "(1) KDE Patience      (fedora)                    (2) Kolourpaint                 (fedora)"
    echo "(3) Kleopatra         (fedora)                    (4) KDE ISO Image Writer        (fedora)"
    echo "(5) Kate              (fedora)                    (6) K3b                         (fedora)"
    echo "(7) Krdc              (fedora)                    (8) Krfb                        (fedora)"
    echo "(f) Non-native                                    (m) Main Menu"
    echo "(h) Help                                          (0) Exit"
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
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
            "$SCRIPTS_FOLDER"/modules/packages/kde/k3b.sh
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/kde/krdc.sh
            ;;

        8)
            "$SCRIPTS_FOLDER"/modules/packages/kde/krfb.sh
            ;;

        f | F)
            non_native_kde_desktop_menu
            ;;

        h | H)
            help
            ;;

        m | M)
            main_menu
            ;;

        h | H)
            help
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
    echo "----------"
    echo "|Internet|"
    echo "----------"
    echo ""
    echo "/app name/            /source/                    /app name/                      /source/"
    echo "(1) Firefox           (fedora)                    (2) Brave Browser               (brave)"
    echo "(3) Transmissionbt    (fedora)                    (4) Remmina                     (fedora)"
    echo "(5) Rclone            (fedora)"
    echo "(f) Non-native                                    (m) Main Menu"
    echo "(h) Help                                          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
            "$SCRIPTS_FOLDER"/modules/packages/internet/firefox.sh "native"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
            "$SCRIPTS_FOLDER"/modules/packages/internet/brave.sh "native"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/internet/transmission.sh "native"
            ;;

        4)  
            "$SCRIPTS_FOLDER"/modules/packages/internet/remmina.sh "native"
            ;;

        f | F)
            non_native_internet_menu
            ;;

        h | H)
            help
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
    echo "------------"
    echo "|Multimedia|"
    echo "------------"
    echo ""
    echo "/app name/            /source/                    /app name/                      /source/"
    echo "(1) VLC Media Player  (fedora)                    (2) OpenShot                    (fedora)"
    echo "(3) xfburn            (fedora)"
    echo "(f) Non-native                                    (m) Main Menu"
    echo "(h) Help                                          (0) Exit"
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
            non_native_multimedia_menu
            ;;
        m | M)
            main_menu
            ;;

        h | H)
            help
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
    echo "--------"
    echo "|Gaming|"
    echo "--------"
    echo ""
    echo "/app name/            /source/                    /app name/                      /source/"
    echo "(1) Steam             (rpmfusion)                 (2) Lutris                      (fedora)"
    echo "(f) Non-native                                    (m) Main Menu"
    echo "(h) Help                                          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in


        1)  
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
            "$SCRIPTS_FOLDER"/modules/packages/gaming/game_tools.sh "native"
            "$SCRIPTS_FOLDER"/modules/packages/gaming/steam.sh "native"
            ;;

        2) 
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
            "$SCRIPTS_FOLDER"/modules/packages/gaming/game_tools.sh "native"
            "$SCRIPTS_FOLDER"/modules/packages/gaming/lutris.sh "native"
            ;;

        f | F)
            non_native_gaming_menu
            ;;

        m | M)
            main_menu
            ;;

        h | H)
            help
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
    echo "--------------"
    echo "|Development|"
    echo "-------------"
    echo ""
    echo "/app name/            /source/                    /app name/                      /source/"
    echo "(1) Git               (fedora)                    (2) Kommit                      (fedora)"
    echo "(3) VIM               (fedora)                    (4) VSCodium                    (codium)"
    echo "(5) Geany             (fedora)                    (6) C/C++ Compiler              (fedora)"
    echo "(7) openJDK 21 LTS    (adoptium)                  (8) Python IDLE                 (fedora)"
    echo "(9) Containers        (fedora)                    (10) Virtualization             (fedora)"
    echo "(11) Lamp Stack       (fedora)"
    echo "(f) Non-native                                    (m) Main Menu"
    echo "(h) Help                                          (0) Exit"
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
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh "openjdk"
            ;;
        
        8)
            "$SCRIPTS_FOLDER"/modules/packages/development/python_tools.sh
           
            ;;

        9)
            "$SCRIPTS_FOLDER"/modules/packages/development/containers.sh
            ;;

        10)
            "$SCRIPTS_FOLDER"/modules/packages/development/virtualization.sh
            ;;

        11)
            "$SCRIPTS_FOLDER"/modules/packages/development/lamp.sh
            ;;

        f | F)
            non_native_dev_menu
            ;;

        m | M)
            main_menu
            ;;

         h | H)
            help
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
    echo "--------"
    echo "|Extras|"
    echo "--------"
    echo ""
    echo "/app name/            /source/                    /app name/                      /source/"
    echo "(1) LibreOffice       (fedora)                    (2) KeePassXC                   (fedora)"
    echo "(f) Non-native"
    echo "(m) Main Menu                                     (h) Help"
    echo "(0) Exit"
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
            non_native_extras_menu
            ;;

        m | M)
            main_menu
            ;;

        h | H)
            help
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
non_native_kde_desktop_menu(){
    echo "-----"
    echo "|KDE|"
    echo "-----"
    echo ""
    echo "/app name/            /source/                    /app name/                      /source/"
    echo "(1) KDE Patience      (flatpak)                   (2) Kolourpaint                 (flatpak)"
    echo "(3) Kleopatra         (flatpak)                   (4) KDE ISO Image Writer        (flatpak)"
    echo "(n) Native                                        (m) Main Menu"
    echo "(h) Help                                          (0) Exit"
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

        h | H)
            help
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            non_native_kde_desktop_menu
            ;;
            
        esac
        unset input
        non_native_kde_desktop_menu
}

non_native_internet_menu(){
    echo "----------"
    echo "|Internet|"
    echo "----------"
    echo ""
    echo "/app name/            /source/                    /app name/                      /source/"
    echo "(1) Firefox           (flatpak)                   (2) Brave Browser               (flatpak)"
    echo "(3) Dropbox           (flatpak)                   (4) Transmissionbt              (flatpak)"
    echo "(5) Remmina           (flatpak)           "
    echo "(n) Native                                        (m) Main Menu"
    echo "(h) Help                                          (0) Exit"
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

        h | H)
            help
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            non_native_internet_menu
            ;;
            
        esac
        unset input
        non_native_internet_menu
}

non_native_multimedia_menu(){
    echo "------------"
    echo "|Multimedia|"
    echo "------------"
    echo ""
    echo "/app name/            /source/                    /app name/                      /source/"
    echo "(1) VLC Media Player  (flatpak)                   (2) OBS Studio                  (flatpak)"
    echo "(3) OpenShot          (flatpak)"
    echo "(n) Native                                        (m) Main Menu"
    echo "(h) Help                                          (0) Exit"
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

        h | H)
            help
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            non_native_multimedia_menu
            ;;
            
        esac
        unset input
        non_native_multimedia_menu
}

non_native_gaming_menu(){
    echo "--------"
    echo "|Gaming|"
    echo "--------"
    echo ""
    echo "/app name/            /source/                    /app name/                      /source/"
    echo "(1) Steam             (flatpak)                   (2) Lutris                      (flatpak)"
    echo "(3) Discord           (discord)                   (4) Prism Launcher              (flatpak)"                
    echo "(5) Dolphin           (flatpak)                   (6) Cemu                        (flatpak)"
    echo "(7) WoWUp             (appimage)                  (8) Warcraft Logs               (appimage)"
    echo "(9) WeakAuras         (appimage)"
    echo "(n) Native                                        (m) Main Menu"
    echo "(h) Help                                          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in


        1) 
            "$SCRIPTS_FOLDER"/modules/packages/gaming/game_tools.sh "flatpak"
            "$SCRIPTS_FOLDER"/modules/packages/gaming/steam.sh "flatpak"
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/game_tools.sh "flatpak"
            "$SCRIPTS_FOLDER"/modules/packages/gaming/lutris.sh "flatpak"
            ;;


        3)  
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
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

        h | H)
            help
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            non_native_gaming_menu
            ;;
            
        esac
        unset input
        non_native_gaming_menu
}

non_native_dev_menu(){
    echo "--------------"
    echo "|Development|"
    echo "-------------"
    echo "/app name/            /source/                    /app name/                      /source/"
    echo "(1) Intellij IDEA     (jetbrains/tarball)         (2) Pycharm                     (jetbrains/tarball)"
    echo "(3) Podman Desktop    (flatpak)                   (4) Nodejs LTS                  (nvm script)"
    echo "(5) openjfx 21 LTS    (gluon/tarball)"
    echo "(n) Native                                        (m) Main Menu"
    echo "(h) Help                                          (0) Exit"
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
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh "openjfx"
            ;;

        n | N)
            native_dev_menu
            ;;

        m | M)
            main_menu
            ;;

        h | H)
            help
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        non_native_dev_menu
        ;;
        
    esac
    unset input
    non_native_dev_menu
}

non_native_extras_menu(){
    echo "--------"
    echo "|Extras|"
    echo "--------"
    echo ""
    echo "/app name/            /source/                    /app name/                      /source/"
    echo "(1) LibreOffice       (flatpak)                   (2) Bookup                      (flatpak) "
    echo "(3) Bitwarden         (flatpak)                   (4) KeePassXC                   (flatpak) "
    echo "(5) RpiImager         (flatpak)                   (6) GtkHash                     (flatpak)"
    echo "(7) MissionCenter     (flatpak)                   (8) Gpu-Viewer                  (flatpak) "
    echo "(n) Native                                        (m) Main Menu"
    echo "(h) Help                                          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/extras/libreoffice.sh "flatpak"
            ;;

        2)
            flatpak install --user -y flathub org.gnome.gitlab.ilhooq.Bookup
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

        h | H)
            help
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            non_native_extras_menu
            ;;
            
        esac
        unset input
        non_native_extras_menu
}

help(){
    echo "native        -      applications that are built either by your distro or provided by 3rd party/community repository. These are"
    echo "                     rpm files and built/optimized specifically for your distro. Generally the recommended choice."
    echo ""
    echo ""
    echo "flatpak       -      applications built for all distros. Often maintained by developers directly. Automatically handles codecs"
    echo "                     like ffmpeg and mesa with gpu acceleration that won't break on updates. OBS is an example where the flatpak"
    echo "                     release is directly maintained by developers."
    echo ""
    echo ""
    echo "appimage      -      applications with their required components built into a single file. wowup for example only offers an appimage."
    echo ""
    echo ""
    echo "tarball       -      compressed file similar to a zip file. The folder is laid out just like it is when normally installed except"
    echo "                     it's ready to use and requires no installation. Generally you copy this somewhere like /opt or /usr/local/share"
    echo "                     and create a shortcut."
}
########################################
# End flatpak/other menus
########################################

main_menu