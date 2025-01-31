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
    echo "(3) Internet Apps                     (4) Office Apps"
    echo "(5) Development Apps                  (6) Utility Apps"
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
    echo "(1) IDEs/SDKs         (2) Github Desktop"
    echo "(3) Containers        (4) Lamp Stack"
    echo "(f) Flatpak/Other"
    echo "(m) Main Menu         (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            native_ides_sdks_menu
            ;;

        2)
            "$SCRIPTS_FOLDER"/modules/packages/development/github_desktop.sh "native"
            ;;

        3)
            "$SCRIPTS_FOLDER"/modules/packages/development/containers.sh
            ;;

        4)
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

native_ides_sdks_menu(){
    echo "---------------------"
    echo "|IDE's/SDKs|[NATIVE]|"
    echo "---------------------"
    echo ""
    echo "(1) VIM                               (2) VSCodium"
    echo "(3) Geany                             (4) C/C++ Compiler"
    echo "(5) Python Dev Packages"
    echo "(f) Flatpak/Other"
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

        4)
            "$SCRIPTS_FOLDER"/modules/packages/development/package_tools.sh
            ;;
        
        5)
            "$SCRIPTS_FOLDER"/modules/packages/development/python_tools.sh
            ;;

        f | F)
            flatpak_ides_sdks_menu
            ;;

        p | P)
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
        native_ides_sdks_menu
        ;;
        
    esac
    unset input
    native_ides_sdks_menu
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

flatpak_office_menu(){
    echo "-----------------------------"
    echo "|Office Apps|[FLATPAK/OTHER]|"
    echo "-----------------------------"
    echo ""
    echo "(1) LibreOffice           (2) Marknote"
    echo "(3) Claws-Mail            (5) Thunderbird"
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
    echo "(1) IDEs/SDKs         (2) Github Desktop"
    echo "(3) Podman Desktop"
    echo "(n) Native Apps"
    echo "(m) Main Menu         (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            flatpak_ides_sdks_menu
            ;;
        2)
            "$SCRIPTS_FOLDER"/modules/packages/development/github_desktop.sh "flatpak"
            ;;

        3)
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

flatpak_ides_sdks_menu(){

    echo "---------------------------"
    echo "|IDEs/SDKs|[FLATPAK/OTHER]|"
    echo "---------------------------"
    echo ""   
    echo "(1) Nodejs LTS                        (2) openJDK 21 LTS"
    echo "(3) openjfx 21 LTS                    (4) Intellij IDEA"
    echo "(5) Pycharm"
    echo "(n) Native Apps"
    echo "(p) Previous Menu                     (m) Main Menu"
    echo "(0) Exit"
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

        n | N)
            native_ides_sdks_menu
            ;;

        p)
            flatpak_development_menu
            ;;

        P)
            flatpak_development_menu
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
        flatpak_ides_sdks_menu
        ;;
        
    esac
    unset input
    flatpak_ides_sdks_menu
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