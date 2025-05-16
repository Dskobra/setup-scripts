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
    echo "(7) Extra Apps                        (8) Misc"
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
            internet_menu
            ;;

        4)
            multimedia_menu
            ;;

        5)
            gaming_menu
            ;;

        6)
            native_dev_menu
            ;;

        7)
            extras_menu
            ;;

        8)
            misc_menu
            ;;

        h | H)
            "$SCRIPTS_FOLDER"/modules/core/help.sh
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
    echo "(1) Corectrl                                      (2) Nvidia Driver"
    echo "(3) CoolerControl                                 (4) OpenRGB"
    echo "(5) Virtual Camera "
    echo "(m) Main Menu                                     (0) Exit"
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
    echo "(1) KDE Patience                                  (2) Kolourpaint"
    echo "(3) Kleopatra                                     (4) KDE ISO Image Writer"
    echo "(5) Kate                                          (6) K3b"
    echo "(7) Krdc                                          (8) Krfb "
    echo "(m) Main Menu                                     (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/kde/kpat.sh
            ;;
        
        2)
            "$SCRIPTS_FOLDER"/modules/packages/kde/kolourpaint.sh
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/kde/kleopatra.sh
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/kde/kde_iso_image_writer.sh
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/kde/kate.sh
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

internet_menu(){
    echo "----------"
    echo "|Internet|"
    echo "----------"
    echo ""
    echo "(1) Firefox                                       (2) Brave Browser"
    echo "(3) Transmissionbt                                (4) Mega"
    echo "(5) Dropbox                                       (6) Rclone"
    echo "(m) Main Menu                                     (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/internet/firefox.sh
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/internet/brave.sh
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/internet/transmission.sh
            ;;

        4)  
            "$SCRIPTS_FOLDER"/modules/packages/internet/mega.sh
            ;;

        5)
            flatpak install --user -y flathub com.dropbox.Client
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/internet/rclone.sh
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
            internet_menu
            ;;
            
        esac
        unset input
        internet_menu
}

multimedia_menu(){
    echo "------------"
    echo "|Multimedia|"
    echo "------------"
    echo ""
    echo "(1) VLC Media Player                              (2) OpenShot"
    echo "(3) OBS Studio                                    (4) xfburn"
    echo "(m) Main Menu                                     (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in


        1)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/vlc.sh
            ;;
        
        2)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/openshot.sh
            ;;

        3)
            flatpak install --user -y flathub com.obsproject.Studio
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/xfburn.sh
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
            multimedia_menu
            ;;
            
        esac
        unset input
        multimedia_menu
}

gaming_menu(){
    echo "--------"
    echo "|Gaming|"
    echo "--------"
    echo ""
    echo "(1) Steam                                         (2) Lutris"
    echo "(3) Discord                                       (4) Prism Launcher"
    echo "(5) Dolphin                                       (6) Cemu"
    echo "(7) XIV Launcher                                  (8) WoWUp"
    echo "(9) Warcraft Logs                                 (10) WeakAuras"
    echo "(m) Main Menu                                     (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in


        1)  
            "$SCRIPTS_FOLDER"/modules/packages/gaming/steam.sh
            ;;

        2) 
            "$SCRIPTS_FOLDER"/modules/packages/gaming/lutris.sh
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/discord.sh
            ;;

        4)
            flatpak install --user -y flathub org.prismlauncher.PrismLauncher
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/dolphin_emu.sh
            ;;

        6)
            flatpak install --user -y flathub info.cemu.Cemu
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/xiv.sh
            ;;

        8)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/wow_clients.sh "wowup"
            ;;

        9)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/wow_clients.sh "wclogs"
            ;;

        10)
            "$SCRIPTS_FOLDER"/modules/packages/gaming/wow_clients.sh "wacompanion"
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
            gaming_menu
            ;;
            
        esac
        unset input
        gaming_menu
}

native_dev_menu(){
    echo "--------------"
    echo "|Development|"
    echo "-------------"
    echo ""
    echo "(1) VIM                                           (2) Geany"
    echo "(3) Intellij IDEA                                 (4) Pycharm"
    echo "(5) Python IDLE                                   (6) Containers"
    echo "(7) Virtualization                                (8) Git"
    echo "(9) GCC                                           (10) openJDK 21 LTS"
    echo "(11) openjfx 21 LTS                               (12) Nodejs LTS"
    echo "(13) Lamp Stack"
    echo "(m) Main Menu                                     (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in


        1)  
            "$SCRIPTS_FOLDER"/modules/packages/development/vim.sh
            ;;
        
        2)
            "$SCRIPTS_FOLDER"/modules/packages/development/geany.sh
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh "idea"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh "pycharm"
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/development/python_tools.sh
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/development/containers.sh
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/development/virtualization.sh
            ;;

        8)
            "$SCRIPTS_FOLDER"/modules/packages/development/git.sh
            ;;

        9)
            "$SCRIPTS_FOLDER"/modules/packages/development/gcc.sh
            ;;

        10)
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh "openjdk"
            ;;

        11)
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh "openjfx"
            ;;

        12)
            "$SCRIPTS_FOLDER"/modules/packages/development/nodejs.sh
            ;;

        13)
            "$SCRIPTS_FOLDER"/modules/packages/development/lamp.sh
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

extras_menu(){
    echo "--------"
    echo "|Extras|"
    echo "--------"
    echo ""
    echo "(1) LibreOffice                                   (2) QOwnNotes"
    echo "(3) Bitwarden                                     (4) RpiImager"
    echo "(5) GtkHash                                       (6) MissionCenter"
    echo "(7) Gpu-Viewer"
    echo "(m) Main Menu                                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/extras/libreoffice.sh
            ;;

        2)
            flatpak install --user -y flathub org.qownnotes.QOwnNotes
            ;;

        3)
            flatpak install --user -y flathub com.bitwarden.desktop
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/extras/rpi_imager.sh
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/extras/gtkhash.sh
            ;;

        6)
            flatpak install --user -y flathub io.missioncenter.MissionCenter
            ;;

        7)
            flatpak install --user -y flathub io.github.arunsivaramanneo.GPUViewer
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
            extras_menu
            ;;

        esac
        unset input
        extras_menu
}

misc_menu(){
    echo "--------"
    echo "|Misc fixes|"
    echo "--------"
    echo ""
    echo "AMD Codecs are the hardware acceleration codecs for ONLY AMD GPUS."
    echo "(1) Reinstall codecs                              (2) Remove codecs"
    echo "(3) AMD Codecs"
    echo "(m) Main Menu                                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            echo "override" > "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.txt
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
            ;;

        2)
            echo "remove" > "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.txt
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
            ;;

        3)
            echo "amd" > "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.txt
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
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
            misc_menu
            ;;

        esac
        unset input
        misc_menu
}
########################################
# End native menus
########################################

main_menu
