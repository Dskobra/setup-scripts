#!/usr/bin/bash

### All the package install functions are here. packages.conf from the data
### branch includes the links for anything that doesn't have a repository.
install_prereq(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y git curl wget zenity flatpak dnf-plugins-core
        sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf update -y
        flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install zenity dnf dnf-plugins-core
        sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo rpm-ostree apply-live
        flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y git curl wget zenity flatpak
        sudo apt-get install -y software-properties-common
        sudo apt-add-repository -y --component contrib non-free 
        sudo dpkg --add-architecture i386
        sudo apt-get update && sudo apt-get upgrade -y
        flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    else
        echo "Unkown error has occurred."
    fi
    flatpak install --user -y flathub com.github.tchx84.Flatseal
}

### Drivers/Kernel modules
install_corectrl(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y corectrl
        xdg-open https://gitlab.com/corectrl/corectrl/-/wikis/Setup
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install corectrl
        xdg-open https://gitlab.com/corectrl/corectrl/-/wikis/Setup
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        echo "deb http://deb.debian.org/debian bookworm-backports main" >> backports.list
        sudo chown root:root backports.list
        sudo mv backports.list /etc/apt/sources.list.d/backports.list
        sudo apt-get update
        sudo apt-get install -y corectrl/bookworm-backports
    else
        echo "Unkown error has occurred."
    fi
}

install_openrgb(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y openrgb
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install openrgb
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        cd $SCRIPTS_FOLDER/temp
        source $SCRIPTS_FOLDER/data/packages.conf
        curl -L -o $OPENRGB_DEB $OPENRGB_LINK
        sudo dpkg -i $OPENRGB_DEB
        sudo apt-get -f -y install   
    else
        echo "Unkown error has occurred."
    fi
}

install_cooler_control(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf copr enable -y codifryed/CoolerControl
        sudo dnf install -y coolercontrol
        sudo systemctl enable --now coolercontrold
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo dnf copr enable -y codifryed/CoolerControl
        sudo rpm-ostree install coolercontrol
        sudo rpm-ostree apply-live
        sudo systemctl enable --now coolercontrold
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt install -y curl apt-transport-https
        curl -1sLf \
        'https://dl.cloudsmith.io/public/coolercontrol/coolercontrol/setup.deb.sh' \
        | sudo -E bash
        sudo apt-get -y update
        sudo apt-get install -y coolercontrol
        sudo systemctl enable --now coolercontrold
    else
        echo "Unkown error has occurred."
    fi
}

install_nvidia(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda nvidia-xconfig nvidia-settings
        xdg-open https://rpmfusion.org/Howto/NVIDIA?highlight=%28%5CbCategoryHowto%5Cb%29#Installing_the_drivers
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia-cuda nvidia-xconfig nvidia-settings
        xdg-open https://rpmfusion.org/Howto/NVIDIA?highlight=%28%5CbCategoryHowto%5Cb%29#Installing_the_drivers
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-add-repository -y --component non-free-firmware
        sudo apt-get install -y linux-headers-amd64 dkms
        sudo apt-get install -y nvidia-driver firmware-misc-nonfree
        xdg-open https://wiki.debian.org/NvidiaGraphicsDrivers
    else
        echo "Unkown error has occurred."
    fi
}

install_v4l2loopback(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y akmod-v4l2loopback v4l2loopback
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install -y akmod-v4l2loopback v4l2loopback
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y v4l2loopback-dkms v4l2loopback-utils
        sudo echo "v4l2loopback" | sudo tee /etc/modules-load.d/v4l2loopback.conf 
        sudo echo "options v4l2loopback video_nr=10 card_label=\"OBS Video Source\" exclusive_caps=1" | sudo tee /etc/modprobe.d/v4l2loopback.conf

        sudo update-initramfs -c -k $(uname -r)
    else
        echo "Unkown error has occurred."
    fi
}

### KDE
install_kdeapps(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        packages_kde
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        if [ $PKGMGR == "rpm-ostree" ]; then
            remove_kinoite_flatpaks
        fi
        flatpak install --user -y flathub org.kde.ark
        flatpak install --user -y flathub org.kde.kcalc
        flatpak install --user -y flathub org.kde.gwenview
        flatpak install --user -y flathub org.kde.kamoso
        flatpak install --user -y flathub org.kde.kleopatra
        flatpak install --user -y flathub org.kde.krdc
     elif [ "$input" = 3 ]
     then
        package_help_page
    else
        echo "Invalid option"
    fi
}

packages_kde(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y ark kate krdc kcalc kamoso gwenview\
        kleopatra okular
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        remove_kinoite_flatpaks
        sudo rpm-ostree install ark kate krdc kcalc kamoso gwenview\
        kleopatra okular
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y ark kate krdc kcalc kamoso\
        gwenview okular kleopatra
    else
        echo "Unkown error has occurred."
    fi
}

install_openshot(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_openshot
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub org.openshot.OpenShot
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_openshot(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y openshot
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install openshot
        sudo rpm-ostree apply-live
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y openshot-qt
    else
        echo "Unkown error has occurred."
    fi
}

install_kthreeb(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y k3b
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install k3b
        sudo rpm-ostree apply-live
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y k3b
    else
        echo "Unkown error has occurred."
    fi
}

install_kpat(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_kpat
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub org.kde.kpat
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_kpat(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kpat
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install kpat
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kpat
    else
        echo "Unkown error has occurred."
    fi
}

install_fmedia_writer(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_fmedia_writer
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub org.fedoraproject.MediaWriter
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_fmedia_writer(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y mediawriter
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install mediawriter
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Fedora Mediawriter isn't available in Debian so using flatpak version instead."
        flatpak install --user -y flathub org.fedoraproject.MediaWriter
    else
        echo "Unkown error has occurred."
    fi
}

install_kde_iso_image_writer(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_kde_iso_image_writer
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub org.kde.isoimagewriter
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_kde_iso_image_writer(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y isoimagewriter
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install isoimagewriter
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="KDE ISO Image Writer isn't available in Debian so using flatpak version instead."
        flatpak install --user -y flathub org.kde.isoimagewriter
    else
        echo "Unkown error has occurred."
    fi
}

install_kleopatra(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_kleopatra
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.kde.kleopatra
    elif [ "$input" = 3 ]
    then
        package_help_page 
    else
        echo "Invalid option"
    fi
}

package_kleopatra(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kleopatra
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install kleopatra
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kleopatra
    else
        echo "Unkown error has occurred."
    fi
}

install_kolourpaint(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_kolourpaint
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.kde.kolourpaint
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_kolourpaint(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kolourpaint
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install kolourpaint
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kolourpaint
    else
        echo "Unkown error has occurred."
    fi
}

install_plasma_x11(){
    if [ $PKGMGR == "dnf" ]
    then
        FEDORA_VERSION=$(source /etc/os-release ; echo $VERSION_ID)
        if [ $FEDORA_VERSION == "40" ]
        then
            sudo dnf install -y plasma-workspace-x11
        else
            echo "This only supports Fedora 40+. 39 has x11 support by default."
        fi
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        FEDORA_VERSION=$(source /etc/os-release ; echo $VERSION_ID)
        if [ $FEDORA_VERSION == "40" ]
        then
            sudo rpm-ostree install plasma-workspace-x11
            confirm_reboot
        else
            echo "Fedora version detected as 39. Not installing x11 support."
        fi
    else
        echo "This only supports Fedora Linux 40+"
    fi
}

remove_kinoite_flatpaks(){
    flatpak remove -y org.kde.elisa  
    flatpak remove -y org.kde.gwenview
    flatpak remove -y org.kde.kcalc
    flatpak remove -y org.kde.kmahjongg  
    flatpak remove -y org.kde.kmines 
    flatpak remove -y org.kde.kolourpaint  
    flatpak remove -y org.kde.krdc  
    flatpak remove -y org.kde.okular   
    flatpak remove -y org.fedoraproject.KDE5Platform
    flatpak remove -y org.fedoraproject.KDE6Platform 
}

### gnome
install_gnome_apps(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        packages_gnome
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        if [ $PKGMGR == "rpm-ostree" ]; then
            remove_silverblue_flatpaks
        fi
        flatpak install --user -y flathub org.gnome.clocks
        flatpak install --user -y flathub org.gnome.Calendar
        flatpak install --user -y flathub org.gnome.Weather
        flatpak install --user -y flathub org.gnome.Contacts
        flatpak install --user -y flathub org.gnome.Calculator
        flatpak install --user -y flathub org.gnome.TextEditor
        flatpak install --user -y flathub org.gnome.Extensions
        flatpak install --user -y flathub org.gnome.Connections
        flatpak install --user -y flathub org.gnome.Characters
        flatpak install --user -y flathub org.gnome.font-viewer
        flatpak install --user -y flathub org.gnome.Evince
        flatpak install --user -y flathub org.gnome.Loupe
        flatpak install --user -y flathub org.gnome.Maps
        flatpak install --user -y flathub org.gnome.Snapshot
        flatpak install --user -y flathub org.gnome.FileRoller
        flatpak install --user -y flathub org.pulseaudio.pavucontrol
        flatpak install --user -y flathub ca.desrt.dconf-editor
        flatpak install --user -y flathub org.gnome.Logs
        flatpak install --user -y flathub org.gnome.baobab
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

packages_gnome(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y file-roller evince dconf-editor pavucontrol cheese\
        gnome-extensions-app
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree file-roller evince dconf-editor pavucontrol cheese\
         gnome-extensions-app
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y file-roller evince dconf-editor pavucontrol cheese\
        gnome-shell-extension-prefs 
    else
        echo "Unkown error has occurred."
    fi
}

install_gnome_tweaks(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y gnome-tweaks
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install gnome-tweaks
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y gnome-tweaks
    else
        echo "Unkown error has occurred."
    fi
}

install_mate_apps(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y mate-menu mate-sensors-applet mate-utils\
        multimedia-menus compiz-manager fusion-icon simple-ccsm\
        compiz-plugins-experimental compiz-bcop fuse

        sudo dnf install -y caja-beesu caja-share ccsm \
        compizconfig-python emerald emerald-themes simple-ccsm
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        echo "Immutable variants are unsupported"
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y mate-menu mate-sensors-applet mate-utils\
        fusion-icon simple-ccsm compiz-plugins-experimental compiz-bcop\
        emerald emerald-themes caja-open-terminal
    else
        echo "Unkown error has occurred."
    fi
}

install_xfburn(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y xfburn
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install xfburn
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y xfburn
    else
        echo "Unkown error has occurred."
    fi
}

install_remmina(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_remmina
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.remmina.Remmina
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_remmina(){
    
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y remmina
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install remmina
        sudo rpm-ostree apply-live
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y remmina
    else
        echo "Unkown error has occurred."
    fi
}

remove_silverblue_flatpaks(){
    flatpak remove -y org.fedoraproject.MediaWriter
    flatpak remove -y org.fedoraproject.Platform
    flatpak remove -y org.gnome.Calculator
    flatpak remove -y org.gnome.Calendar
    flatpak remove -y org.gnome.Characters
    flatpak remove -y org.gnome.Connections
    flatpak remove -y org.gnome.Contacts
    flatpak remove -y org.gnome.Evince
    flatpak remove -y org.gnome.Extensions
    flatpak remove -y org.gnome.Logs 
    flatpak remove -y org.gnome.Loupe
    flatpak remove -y org.gnome.Maps 
    flatpak remove -y org.gnome.Snapshot
    flatpak remove -y org.gnome.TextEditor
    flatpak remove -y org.gnome.Weather 
    flatpak remove -y org.gnome.baobab
    flatpak remove -y org.gnome.clocks
    flatpak remove -y org.gnome.font-viewer
}

### internet
install_firefox(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_firefox
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.mozilla.firefox
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_firefox(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y firefox
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        echo "Immutable variants are unsupported"
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y firefox-esr
        sudo install -d -m 0755 /etc/apt/keyrings
        wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

        gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); print "\n"$0"\n"}'

        echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
        echo '
        Package: *
        Pin: origin packages.mozilla.org
        Pin-Priority: 1000
        ' | sudo tee /etc/apt/preferences.d/mozilla
        sudo apt-get update && sudo apt-get install -y firefox
    else
        echo "Unkown error has occurred."
    fi
}

install_brave_browser(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_brave_browser
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub com.brave.Browser
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_brave_browser(){
    cd $SCRIPTS_FOLDER/temp
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
        sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        sudo dnf update -y
        sudo dnf install -y brave-browser
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
        curl -L -o brave-core.asc https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        sudo chown root:root brave-core.asc
        sudo mv brave-core.asc /etc/pki/rpm-gpg/
        sudo rpm-ostree refresh-md
        sudo rpm-ostree install brave-browser
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
        sudo apt-get update
        sudo apt-get install -y brave-browser
    else
        echo "Unkown error has occurred."
    fi
}

install_dropbox(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_dropbox
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub com.dropbox.Client
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_dropbox(){
    
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y dropbox
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install dropbox
    elif [ $PKGMGR == "apt-get" ]
    then
        package_dropbox_debian
    else
        echo "Unkown error has occurred."
    fi
}

package_dropbox_debian(){
    DESKTOP=$(echo $XDG_CURRENT_DESKTOP)
    if [ $DESKTOP == "GNOME" ]
    then
        sudo apt-get install -y nautilus-dropbox
    elif [ $DESKTOP == "MATE" ]
    then
        sudo apt-get install caja-dropbox
    else
        sudo apt-get install -y nautilus-dropbox
    fi
}

install_transmission(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_transmission
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y  flathub com.transmissionbt.Transmission
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_transmission(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y transmission-gtk
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install transmission-gtk
        sudo rpm-ostree apply-live
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y transmission-gtk
    else
        echo "Unkown error has occurred."
    fi
}

### multimedia
install_codecs(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
        sudo dnf install -y gstreamer1-plugin-openh264\
        mozilla-openh264 ffmpeg ffmpeg-libs.i686 ffmpeg-libs
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree override remove libavcodec-free libavfilter-free\
        libavformat-free libavutil-free libpostproc-free\
        libswresample-free libswscale-free --install ffmpeg

        sudo rpm-ostree install gstreamer1-plugin-openh264\
        mozilla-openh264
        sudo rpm-ostree apply-live --allow-replacement
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y ffmpeg
    else
        echo "Unkown error has occurred."
    fi
}

install_amd_codecs(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
        sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

        sudo dnf swap -y mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686
        sudo dnf swap -y mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install mesa-va-drivers-freeworld mesa-vdpau-drivers-freeworld

        sudo rpm-ostree install mesa-va-drivers-freeworld.i686 mesa-vdpau-drivers-freeworld.i686
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install mesa-va-drivers
    else
        echo "Unkown error has occurred."
    fi
}

install_vlc(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_vlc
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.videolan.VLC
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_vlc(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y vlc
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install vlc
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y vlc
    else
        echo "Unkown error has occurred."
    fi
}

install_obsstudio(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_obsstudio
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub com.obsproject.Studio
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_obsstudio(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y obs-studio
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install obs-studio
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y obs-studio
    else
        echo "Invalid option"
    fi
}

### games
install_steam(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_steam
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub com.valvesoftware.Steam
        flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
        flatpak override com.valvesoftware.Steam  --user --filesystem=xdg-config/MangoHud:ro
        zenity --info --text="steam-devices package will also be installed for controller support."
        package_steam_devices
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Unkown error has occurred."
    fi
}

package_steam(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y steam
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install steam
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo dpkg --add-architecture i386
        sudo apt-get update
        sudo apt-get install -y steam
    else
        echo "Unkown error has occurred."
    fi
}

package_steam_devices(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y steam-devices
    elif [ $PKGMGR == "rpm-ostree" ]
    then
       sudo rpm-ostree install steam-devices
       confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo dpkg --add-architecture i386
        sudo apt-get update
        sudo apt-get install -y steam-devices
    else
        echo "Unkown error has occurred."
    fi
}

install_lutris(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        lutris_package
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
            flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
            flatpak install --user -y flathub net.lutris.Lutris
            flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

lutris_package(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y lutris
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install lutris
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y lutris
    else
        echo "Unkown error has occurred."
    fi
}

install_bottles(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_bottles
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub com.usebottles.bottles
        flatpak override com.usebottles.bottles --user --filesystem=xdg-config/MangoHud:ro
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_bottles(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y bottles
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install bottles
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Bottles isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y flathub com.usebottles.bottles
        flatpak override com.usebottles.bottles --user --filesystem=xdg-config/MangoHud:ro
    else
        echo "Unkown error has occurred."
    fi
}

install_mangohud(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_mangohud
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_mangohud(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y mangohud
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install mangohud
        sudo rpm-ostree apply-live
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y mangohud
    else
        echo "Unkown error has occurred."
    fi
}

install_discord(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_discord
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub com.discordapp.Discord
        flatpak override --user com.discordapp.Discord --env=XDG_SESSION_TYPE=x11
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_discord(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y discord
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install discord
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Discord isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y flathub com.discordapp.Discord
        flatpak override --user com.discordapp.Discord --env=XDG_SESSION_TYPE=x11
    else
        echo "Unkown error has occurred."
    fi
}

install_dolphin_emu(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_dolphin_emu
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.DolphinEmu.dolphin-emu
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_dolphin_emu(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y dolphin-emu
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install dolphin-emu
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y dolphin-emu
    else
        echo "Unkown error has occurred."
    fi
}

install_discover_overlay(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_discover_overlay
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub io.github.trigg.discover_overlay
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Unkown error has occurred."
    fi
}

package_discover_overlay(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf copr enable mavit/discover-overlay
        sudo dnf install -y discover-overlay
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo dnf copr enable mavit/discover-overlay
        sudo rpm-ostree install -y discover-overlay
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="discover-overlay isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y io.github.trigg.discover_overlay
    else
        echo "Unkown error has occurred."
    fi
}

install_proton_plus(){
    ## template function for aasking to do distro package or flatpak
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_proton_plus
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub com.vysp3r.ProtonPlus
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Unkown error has occurred."
    fi
}

package_proton_plus(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf copr enable -y wehagy/protonplus
        sudo dnf install -y protonplus
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo dnf copr enable -y wehagy/protonplus
        sudo rpm-ostree install protonplus
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Proton Plus isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y flathub com.vysp3r.ProtonPlus
    else
        echo "Unkown error has occurred."
    fi
}
download_wowup(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf
    if test -f ~/Desktop/$WOWUPBINARY; then
        echo "WoWUp already downloaded."
    elif ! test -f ~/Desktop/$WOWUPBINARY; then
        cd ~/Desktop/
        curl -L -o $WOWUPBINARY $WOWUPLINK 
        chmod +x $WOWUPBINARY
    fi
}

download_warcraft_logs(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf
    if test -f ~/Desktop/$WOWLOGSBINARY; then
        echo "Warcraft Logs already downloaded."
    elif ! test -f ~/Desktop/$WOWLOGSBINARY; then
        cd ~/Desktop/
        curl -L -o $WOWLOGSBINARY $WOWLOGSLINK
        chmod +x $WOWLOGSBINARY
    fi
}

download_weakauras_companion(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf
    if test -f ~/Desktop/$WACOMPBINARY; then
        echo "WeakAuras Companion already downloaded."
    elif ! test -f  ~/Desktop/$WACOMPBINARY; then
        cd  ~/Desktop/
        curl -L -o $WACOMPBINARY $WACOMPLINK
        chmod +x $WACOMPBINARY
    fi
}

setup_game_profiles(){
    echo "-------Pick an option-------"
    echo "(1) Setup some mangohud profiles"
    echo "(2) Supported games"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        copy_game_profiles
    elif [ "$input" = 2 ]
    then
        xdg-open https://github.com/Dskobra/setup-scripts/wiki/Game-Profiles
    else
        echo "Invalid or no option given."
    fi
}

copy_game_profiles(){
    if test -f /home/$USER/.config/MangoHud/MangoHud.conf; then
        echo "MangoHud.conf exists. Not copying profiles over."
    elif ! test -f /home/$USER/.config/MangoHud/MangoHud.conf; then
        cd $SCRIPTS_FOLDER/data/game-profiles
        chown $USER:$USER *.conf
        cp *.conf $HOME/.config/MangoHud/
    fi
}

### Office Apps
install_qownnotes(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_qownnotes
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.qownnotes.QOwnNotes
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_qownnotes(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y qownnotes
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install qownnotes
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="QOwnNotes isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y flathub org.qownnotes.QOwnNotes
    else
        echo "Unkown error has occurred."
    fi
}

install_marknote(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_marknote
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub org.kde.marknote
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Unkown error has occurred."
    fi
}

package_marknote(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y marknote
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install marknote
        sudo rpm-ostree apply-live
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Marknote isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y flathub org.kde.marknote
    else
        echo "Unkown error has occurred."
    fi
}

install_libreoffice(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_libreoffice
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        source $SCRIPTS_FOLDER/packages.sh; "remove_libreoffice"
        flatpak install --user -y flathub org.libreoffice.LibreOffice
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_libreoffice(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y libreoffice
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install libreoffice
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y libreoffice
    else
        echo "Unkown error has occurred."
    fi
}

install_claws_mail(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_claws_mail
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.claws_mail.Claws-Mail
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_claws_mail(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y claws-mail
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install claws-mail
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y claws-mail
    else
        echo "Unkown error has occurred."
    fi
}

install_thunderbird(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_thunderbird
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.mozilla.Thunderbird
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_thunderbird(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y thunderbird
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install thunderbird
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y thunderbird
    else
        echo "Unkown error has occurred."
    fi
}

install_keepassxc(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_keepassxc
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.keepassxc.KeePassXC
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_keepassxc(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y keepassxc
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install keepassxc
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y keepassxc
    else
        echo "Unkown error has occurred."
    fi
}

### development
install_package_tools(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y gcc-g++ autoconf automake bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace perf strace koji\
        mock redhat-rpm-config rpm-build rpmdevtools
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install gcc-g++ autoconf automake bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace perf strace koji\
        mock redhat-rpm-config rpm-build rpmdevtools
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y automake gcc g++ bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace linux-perf strace\
        build-essential
    else
        echo "Unkown error has occurred."
    fi
}

install_openjdk(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y java-21-openjdk-devel openjfx
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install  java-21-openjdk-devel openjfx
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Using openjdk 17 as 21 isn't in stable yet."
        sudo apt-get install -y openjdk-17-jdk openjfx
    else
        echo "Unkown error has occurred."
    fi
}

install_nodejs(){
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
}

install_python_tools(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y python3-idle python3-devel
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install python3-idle python3-devel
        sudo rpm-ostree apply-live
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y idle-python3.11 python3.11-dev
    else
        echo "Unkown error has occurred."
    fi
}

install_lamp_stack(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y httpd mariadb mariadb-server\
        php phpMyAdmin
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install httpd php phpMyAdmin --allow-inactive
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y apache2 mariadb-client\
        mariadb-server php phpmyadmin
    else
        echo "Unkown error has occurred."
    fi
}

install_github_desktop(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_install_github_desktop
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub io.github.shiftey.Desktop
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Unkown error has occurred."
    fi
}

package_install_github_desktop(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
        sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
        sudo dnf install -y github-desktop
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        cd $SCRIPTS_FOLDER/temp
        curl -L -o shiftkey-gpg.key https://rpm.packages.shiftkey.dev/gpg.key
        sudo chown root:root shiftkey-gpg.key
        sudo mv shiftkey-gpg.key /etc/pki/rpm-gpg/
        sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
        sudo rpm-ostree install github-desktop
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
        sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
        sudo apt-get update && sudo apt-get install -y github-desktop
    else
        echo "Unkown error has occurred."
    fi
}

install_containers(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y toolbox distrobox
        flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install distrobox
        flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y distrobox podman-toolbox
        flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
    else
        echo "Unkown error has occurred."
    fi
}

install_codeblocks(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is distro built"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        package_codeblocks
    elif [ "$input" = 2 ]
    then
        flatpak install --user -y flathub org.codeblocks.codeblocks
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Unkown error has occurred."
    fi
}

package_codeblocks(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y codeblocks codeblocks-contrib-devel
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install codeblocks codeblocks-contrib-devel
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y codeblocks-dev
    else
        echo "Unkown error has occurred."
    fi
}

install_netbeans(){
    echo "-------Pick an option-------"
    echo "(1) download a compressed bundle"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is a bundle extracted from an archive. Stored in ~/Apps/netbeans"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        download_netbeans
    elif [ "$input" = 2 ]
    then
        flatpak install --user -y flathub org.apache.netbeans
    else
        echo "Unkown error has occurred."
    fi
}

download_netbeans(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf
    if test -d $APP_FOLDER/netbeans; then
        echo "Netbeans already downloaded."
    elif ! test -d $APP_FOLDER/netbeans; then
        cd $SCRIPTS_FOLDER/temp
        curl -L -o netbeans.zip $NETBEANS_LINK
        unzip netbeans.zip
        mv $SCRIPTS_FOLDER/temp/netbeans $APP_FOLDER/netbeans

    fi
}

install_idea(){
    echo "-------Pick an option-------"
    echo "(1) download a compressed bundle"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is a bundle extracted from an archive. Stored in ~/Apps/idea"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        download_idea
    elif [ "$input" = 2 ] 
    then
        flatpak install --user -y flathub com.jetbrains.IntelliJ-IDEA-Community
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Unkown error has occurred."
    fi
}

download_idea(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf
    
    if test -d $APP_FOLDER/idea; then
        echo "Intellij Idea already downloaded."
    elif ! test -d $APP_FOLDER/idea; then
        cd $SCRIPTS_FOLDER/temp
        curl -L -o idea.tar.gz $IDEA_LINK
        tar -xvf idea.tar.gz
        rm idea.tar.gz
        mv idea* $APP_FOLDER/idea
    fi
}

install_scene_builder(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf
    if [ $PKGMGR == "dnf" ]
    then
        curl -L -o scenebuilder.rpm $SCENE_BUILDER_RPM_LINK
        sudo rpm -i scenebuilder.rpm
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        curl -L -o scenebuilder.rpm $SCENE_BUILDER_RPM_LINK
        sudo rpm-ostree install scenebuilder.rpm
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        curl -L -o scenebuilder.deb $SCENE_BUILDER_DEB_LINK
        sudo dpkg -i scenebuilder.deb
    else
        echo "Unkown error has occurred."
    fi
}

install_bluefish(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is distro built."
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        package_bluefish
    elif [ "$input" = 2 ] 
    then
       flatpak install --user -y flathub nl.openoffice.bluefish
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_bluefish(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y bluefish
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install bluefish
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y bluefish
    else
        echo "Unkown error has occurred."
    fi
}

install_pycharm(){
    echo "-------Pick an option-------"
    echo "(1) download a compressed bundle"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is a bundle extracted from an archive. Stored in ~/Apps/pycharm"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        download_pycharm
    elif [ "$input" = 2 ] 
    then
        flatpak install --user -y flathub com.jetbrains.PyCharm-Community
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Unkown error has occurred."
    fi
}

download_pycharm(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf    
    if test -d $APP_FOLDER/pycharm; then
        echo "Pycharm already downloaded."
    elif ! test -d $APP_FOLDER/pycharm; then
        cd $SCRIPTS_FOLDER/temp
        curl -L -o pycharm.tar.gz $PYCHARM_LINK
        tar -xvf pycharm.tar.gz
        rm pycharm.tar.gz
        mv pycharm* $APP_FOLDER/pycharm
    fi
}

install_eric_ide(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y eric
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install eric
        sudo rpm-ostree apply-live
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y eric
    else
        echo "Unkown error has occurred."
    fi
}

install_vscodium(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is distro built."
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        package_vscodium
    elif [ "$input" = 2 ]
    then
        flatpak install --user -y flathub com.vscodium.codium
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Unkown error has occurred."
    fi
}

package_vscodium(){
    if [ $PKGMGR == "dnf" ]
    then
        cd $SCRIPTS_FOLDER/data
        cp vscodium.repo.txt vscodium.repo
        sudo chown root:root vscodium.repo
        sudo mv vscodium.repo /etc/yum.repos.d/vscodium.repo
        sudo dnf install -y codium
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        cd $SCRIPTS_FOLDER/data
        cp vscodium.repo.txt vscodium.repo
        sudo chown root:root vscodium.repo
        sudo mv vscodium.repo /etc/yum.repos.d/vscodium.repo
        sudo rpm-ostree install codium
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -
        sudo apt-add-repository 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main'
        sudo apt-get update && sudo apt-get install -y codium
        
    else
        echo "Unkown error has occurred."
    fi
}

install_vim(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y vim-enhanced
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install vim-enhanced
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y vim
    else
        echo "Unkown error has occurred."
    fi
}

install_geany(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is distro built."
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        package_geany
    elif [ "$input" = 2 ]
    then
        flatpak install --user -y flathub org.geany.Geany
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Unkown error has occurred."
    fi
}

package_geany(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y geany geany-plugin-markdown geany-plugin-spellcheck geany-plugin-treebrowser
    else
        echo "Invalid option"
    fi
}

install_eclipse(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf
    curl -o eclipse.tar.gz $ECLIPSE_LINK

    tar -xvf eclipse.tar.gz
    ./eclipse-installer/eclipse-inst
}

### utilities
install_rpi_imager(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_rpi_imager
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.raspberrypi.rpi-imager
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_rpi_imager(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y rpi-imager
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install rpi-imager
        #sudo rpm-ostree apply-live
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Raspberry Pi Imager isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y flathub org.raspberrypi.rpi-imager
    else
        echo "Unkown error has occurred."
    fi
}

install_gtkhash(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_gtkhash
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.gtkhash.gtkhash
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_gtkhash(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y gtkhash
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install gtkhash
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y gtkhash
    else
        echo "Unkown error has occurred."
    fi
}

install_virtualization(){
    if [ $PKGMGR == "dnf" ]
    then

        sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
        -O /etc/yum.repos.d/virtio-win.repo
        sudo dnf update -y
        sudo dnf install -y libvirt-daemon-config-network libvirt-daemon-kvm\
        qemu-kvm virt-install virt-manager virt-viewer virtio-win
        check_for_libvirt_group
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
        -O /etc/yum.repos.d/virtio-win.repo
        sudo rpm-ostree refresh-md
        sudo rpm-ostree install libvirt-daemon-config-network libvirt-daemon-kvm\
        qemu-kvm virt-install virt-manager virt-viewer virtio-win
        sudo rpm-ostree apply-live
        check_for_libvirt_group
    elif [ $PKGMGR == "apt-get" ]
    then
        cd ~/Downloads/
        curl -L -o virtio-win.iso https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso
        sudo apt-get install -y libvirt-daemon-config-network qemu-kvm virt-manager virt-viewer
    else
        echo "Unkown error has occurred."
    fi
}

### Misc
install_spinfinity_theme(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y plymouth-theme-spinfinity
        sudo plymouth-set-default-theme spinfinity -R
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        check_for_spinfinity
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y plymouth-themes
        sudo plymouth-set-default-theme spinfinity -R
    else
        echo "Unkown error has occurred."
    fi
}

check_for_spinfinity(){
    THEME="missing"
    test -d /usr/share/plymouth/themes/spinfinity/ && THEME="exists"
    if [ "$THEME" = "exists" ]
    then
        sudo plymouth-set-default-theme spinfinity -R
    elif [ "$THEME" = "missing" ]
    then
        sudo rpm-ostree install plymouth-theme-spinfinity
        SPINFINITY="Fedora Atomic editions will need to reboot first to load the package layer then rerun
        this option to apply the theme."
        zenity --warning --text="$SPINFINITY"
        confirm_reboot
    else
        echo "Unkown error has occurred."
    fi
}

### remove packages
remove_codecs(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf update -y
        sudo dnf swap -y ffmpeg libavcodec-free --allowerasing
        sudo dnf remove -y gstreamer1-plugin-openh264 \
        mozilla-openh264
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree remove ffmpeg
        sudo rpm-ostree override reset libavcodec-free libavfilter-free \
        libavformat-free libavutil-free libpostproc-free \
        libswresample-free libswscale-free
        sudo rpm-ostree override reset mesa-va-drivers mesa-vdpau-drivers-freeworld
        
        sudo rpm-ostree remove -y gstreamer1-plugin-openh264 \
        mozilla-openh264
        confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y ffmpeg
    else
        echo "Unkown error has occurred."
    fi
}

remove_libreoffice(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y libreoffice*
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree remove libreoffice
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y libreoffice*
    else
        echo "Unkown error has occurred."
    fi
}

### configurations
check_for_libvirt_group(){
    if [ $(getent group libvirt) ]; then
        sudo usermod -aG libvirt $USER
    else
        echo "Group doesn't exist. Please run the "Virtualization" option "
        echo "from the Extras menu and/or reboot first if using Kinoite etc."
    fi
}


# tempplates
package_type_template(){
    ## template function for aasking to do distro package or flatpak
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        echo "insert package function"
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        echo "insert flatpak(s)"
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Unkown error has occurred."
    fi
}

distro_package_template(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install --allow-inactive
        #sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y
        #zenity --info --text="[app name] isn't currently available in Debian. This will install the flatpak version."
    else
        echo "Unkown error has occurred."
    fi
}

package_help_page(){
    xdg-open https://github.com/Dskobra/setup-scripts/wiki/Package-install-methods
}
