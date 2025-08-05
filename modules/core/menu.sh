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
            kde_desktop_menu
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
            dev_menu
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
    echo "Drivers and tools for managing hardware"
    echo ""
    echo "(1) Lact                                          (2) CoolerControl"
    echo "(3) Nvidia Driver                                 (4) OpenRGB"
    echo "(5) Virtual Camera                                (6) CPU-X"
    echo "(7) Gpu-Viewer"
    echo "(m) Main Menu                                     (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            "$SCRIPTS_FOLDER"/modules/packages/hardware/lact.sh
            ;;

        2)
            sudo dnf copr enable -y codifryed/CoolerControl
            sudo dnf install -y coolercontrol
            sudo systemctl enable --now coolercontrold
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/hardware/nvidia.sh
            ;;

        4)
            sudo dnf install -y openrgb
            ;;

        5)
            sudo dnf install -y akmod-v4l2loopback v4l2loopback
            sudo akmods --rebuild --force
            sudo dracut --regenerate-all --force
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/hardware/cpux.sh
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
            hardware_menu
            ;;
            
        esac
        unset input
        hardware_menu
}

kde_desktop_menu(){
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
            sudo dnf install -y k3b
            ;;

        7)
            sudo dnf install -y krdc
            ;;

        8)
            sudo dnf install -y krfb
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
            kde_desktop_menu
            ;;
            
        esac
        unset input
        kde_desktop_menu
}

internet_menu(){
    echo "----------"
    echo "|Internet|"
    echo "----------"
    echo ""
    echo "(1) Firefox                                       (2) Brave Browser"
    echo "(3) Transmissionbt                                (4) Mega"
    echo "(5) Dropbox                                       (6) Rclone"
    echo "(7) Remmina"
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
            "$SCRIPTS_FOLDER"/modules/packages/shared/rclone.sh
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/internet/remmina.sh
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
    echo "(3) Shotcut                                       (4) Kdenlive"
    echo "(5) OBS Studio                                    (6) xfburn"
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
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/shotcut.sh
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/multimedia/kdenlive.sh
            ;;

        5)
            flatpak install --user -y flathub com.obsproject.Studio
            ;;

        6)
            sudo dnf install -y xfburn
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
            "$SCRIPTS_FOLDER"/modules/packages/shared/xiv.sh
            ;;

        8)
            "$SCRIPTS_FOLDER"/modules/packages/shared/wow_clients.sh "wowup"
            ;;

        9)
            "$SCRIPTS_FOLDER"/modules/packages/shared/wow_clients.sh "wclogs"
            ;;

        10)
            "$SCRIPTS_FOLDER"/modules/packages/shared/wow_clients.sh "wacompanion"
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

dev_menu(){
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
            sudo dnf install -y vim-enhanced
            ;;
        
        2)
            sudo dnf install -y geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/shared/java.sh "idea"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/shared/java.sh "pycharm"
            ;;

        5)
            sudo dnf install -y python3-idle python3-devel
            ;;

        6)
            sudo dnf install -y toolbox distrobox docker-compose-switch
            flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/development/virtualization.sh
            ;;

        8)
            sudo dnf install -y git git-gui gh git-cola
            ;;

        9)
            sudo dnf4 groupinstall -y "Development Tools"
            sudo dnf4 groupinstall -y "C Development Tools and Libraries"
            ;;

        10)
            "$SCRIPTS_FOLDER"/modules/packages/development/java.sh
            ;;

        11)
            "$SCRIPTS_FOLDER"/modules/packages/shared/java.sh "openjfx"
            ;;

        12)
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
            source ~/.bashrc
            nvm install lts/*
            ;;

        13)
            sudo dnf install -y httpd mariadb mariadb-server php phpMyAdmin
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
        dev_menu
        ;;
        
    esac
    unset input
    dev_menu
}

extras_menu(){
    echo "--------"
    echo "|Extras|"
    echo "--------"
    echo ""
    echo "(1) LibreOffice                                   (2) QOwnNotes"
    echo "(3) Bitwarden                                     (4) RpiImager"
    echo "(5) GtkHash                                       (6) MissionCenter"
    echo "(7) Gear Lever"
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
            flatpak install --user -y flathub it.mijorus.gearlever
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
    echo "AMD GPU codecs are the mesa hardware accelerated audio/video codecs"
    echo "for AMD GPUS ONLY. They do nothing for Nvidia."
    echo "(1) Reinstall codecs                              (2) Remove codecs"
    echo "(3) AMD GPU codecs"
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
