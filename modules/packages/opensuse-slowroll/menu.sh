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
            echo "Disabled atm"
            #hardware_menu
            ;;

        2)
            echo "Disabled atm"
            #kde_desktop_menu
            ;;

        3)
            echo "Disabled atm"
            #internet_menu
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
            echo "Disabled atm"
            #misc_menu
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
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/hardware/lact.sh
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/hardware/cooler_control.sh
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/hardware/nvidia.sh
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/hardware/openrgb.sh
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/hardware/v4l2loopback.sh
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/hardware/cpux.sh
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
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/kde/kpat.sh
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/kde/kolourpaint.sh
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/kde/kleopatra.sh
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/kde/kde_iso_image_writer.sh
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/kde/kate.sh
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/kde/k3b.sh
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/kde/krdc.sh
            ;;

        8)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/kde/krfb.sh
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
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/internet/firefox.sh
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/internet/brave.sh
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/internet/transmission.sh
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/internet/mega.sh
            ;;

        5)
            flatpak install --user -y flathub com.dropbox.Client
            ;;

        6)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/internet/rclone.sh
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/internet/remmina.sh
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
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/vlc.sh
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/openshot.sh
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/shotcut.sh
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/kdenlive.sh
            ;;

        5)
            flatpak install --user -y flathub com.obsproject.Studio
            ;;

        6)
            sudo zypper -n install xfburn
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
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/gaming/steam.sh
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/gaming/lutris.sh
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/gaming/discord.sh
            ;;

        4)
            flatpak install --user -y flathub org.prismlauncher.PrismLauncher
            ;;

        5)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/gaming/dolphin_emu.sh
            ;;

        6)
            flatpak install --user -y flathub info.cemu.Cemu
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/gaming/xiv.sh
            ;;

        8)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/gaming/wow_clients.sh "wowup"
            ;;

        9)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/gaming/wow_clients.sh "wclogs"
            ;;

        10)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/gaming/wow_clients.sh "wacompanion"
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
            sudo zypper -n install vim
            ;;

        2)
            sudo zypper -n install geany geany-plugins
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/development/java.sh "idea"
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/development/java.sh "pycharm"
            ;;

        5)
            sudo zypper -n install python3-idle python3-devel
            ;;

        6)
            sudo zypper -n install patterns-containers-container_runtime toolbox distrobox
            sudo zypper -n install docker-compose-switch
            flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
            ;;

        7)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/development/virtualization.sh
            ;;

        8)
            sudo zypper -n install git git-gui gh git-cola
            ;;

        9)
            sudo zypper -n install patterns-devel-C-C++-devel_C_C++
            ;;

        10)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/development/java.sh "openjdk"
            ;;

        11)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/development/java.sh "openjfx"
            ;;

        12)
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
            source ~/.bashrc
            nvm install lts/*
            ;;

        13)
            sudo zypper -n install apache2 mariadb php8 phpMyAdmin
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
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/extras/libreoffice.sh
            ;;

        2)
            flatpak install --user -y flathub org.qownnotes.QOwnNotes
            ;;

        3)
            flatpak install --user -y flathub com.bitwarden.desktop
            ;;

        4)
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/extras/rpi_imager.sh
            ;;

        5)
            flatpak install --user -y flathub org.gtkhash.gtkhash
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
            echo "override" > "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/codecs.txt
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/codecs.sh
            ;;

        2)
            echo "remove" > "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/codecs.txt
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/codecs.sh
            ;;

        3)
            echo "amd" > "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/codecs.txt
            "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/codecs.sh
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
