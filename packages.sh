#!/usr/bin/bash

### All the packages are here. packages.conf from the data
### branch includes the links for pycharm, intellij idea
### community edition, netbeans, scenebuilder, eclipse 
### and wowup

### Scripts need git to pull from data branch, curl to get
### icons and repository info, wget for nodejs and other repositories,
### and zenity for displaying some info.
install_prereq(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y git curl wget zenity flatpak
        sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf update -y
        flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install wget zenity
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
        echo "Unkown error has occured."
    fi
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
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        echo "deb http://deb.debian.org/debian bookworm-backports main" >> backports.list
        sudo chown root:root backports.list
        sudo mv backports.list /etc/apt/sources.list.d/backports.list
        sudo apt-get update
        sudo apt-get install -y corectrl/bookworm-backports
    else
        echo "Unkown error has occured."
    fi
}

install_openrgb(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y openrgb
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install openrgb
        check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        cd $SCRIPTS_HOME/temp
        source $SCRIPTS_HOME/data/packages.conf
        curl -L -o $OPENRGB_DEB $OPENRGB_LINK
        sudo dpkg -i $OPENRGB_DEB
        sudo apt-get -f -y install   
    else
        echo "Unkown error has occured."
    fi
}

install_cooler_control(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y dnf-plugins-core
        sudo dnf copr enable codifryed/CoolerControl
        sudo dnf install -y coolercontrol
        sudo systemctl enable --now coolercontrold
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        cd $SCRIPTS_HOME/temp
        source $SCRIPTS_HOME/data/packages.conf
        curl -L -o $COOLERCONTROL_FILE $COOLERCONTROL_LINK
        sudo chown root:root $COOLERCONTROL_FILE
        sudo mv $COOLERCONTROL_FILE /etc/yum.repos.d/
        sudo rpm-ostree install coolercontrol
        sudo rpm-ostree apply-live
        sudo systemctl enable --now coolercontrold
        #check_if_fedora_immutable
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
        echo "Unkown error has occured."
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
        check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-add-repository -y --component non-free-firmware
        sudo apt-get install -y linux-headers-amd64 dkms
        sudo apt-get install -y nvidia-driver firmware-misc-nonfree
        xdg-open https://wiki.debian.org/NvidiaGraphicsDrivers
    else
        echo "Unkown error has occured."
    fi
}

install_v4l2loopback(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y akmod-v4l2loopback v4l2loopback
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install -y akmod-v4l2loopback v4l2loopback
        check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y v4l2loopback-dkms v4l2loopback-utils
        sudo echo "v4l2loopback" | sudo tee /etc/modules-load.d/v4l2loopback.conf 
        sudo echo "options v4l2loopback video_nr=10 card_label=\"OBS Video Source\" exclusive_caps=1" | sudo tee /etc/modprobe.d/v4l2loopback.conf

        sudo update-initramfs -c -k $(uname -r)
    else
        echo "Unkown error has occured."
    fi
}

### KDE/Qt Apps
install_kdeapps(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        packages_kde
    elif [ $input == "2" ]
    then
        remove_kinoite_flatpaks
        flatpak install --user -y flathub org.kde.ark
        flatpak install --user -y flathub org.kde.kcalc
        flatpak install --user -y flathub org.kde.gwenview
        flatpak install --user -y flathub org.kde.kamoso
        flatpak install --user -y flathub org.kde.kleopatra
    else
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
    fi
}

install_openshot(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_openshot
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.openshot.OpenShot
    else
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
    fi
}

install_kpat(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_kpat
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.kde.kpat
    else
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
    fi
}

install_fmedia_writer(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_fmedia_writer
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.fedoraproject.MediaWriter
    else
        echo "Unkown error has occured."
    fi
}

package_fmedia_writer_(){
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
        echo "Unkown error has occured."
    fi
}

install_kde_iso_image_writer(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_kde_iso_image_writer
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.kde.isoimagewriter
    else
        echo "Unkown error has occured."
    fi
}

package_kde_iso_image_writer(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y isoimagewriter
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="KDE ISO Image Writer isn't available in Debian so using flatpak version instead."
        flatpak install --user -y flathub org.kde.isoimagewriter
    else
        echo "Unkown error has occured."
    fi
}

install_kleopatra(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_kleopatra
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.kde.kleopatra
    else
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
    fi
}

install_kolourpaint(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_kolourpaint
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.kde.kolourpaint
    else
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
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
            echo "Fedora version detected as 39. Not installing x11 support."
        fi
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        FEDORA_VERSION=$(source /etc/os-release ; echo $VERSION_ID)
        if [ $FEDORA_VERSION == "40" ]
        then
            sudo rpm-ostree install plasma-workspace-x11
            check_if_fedora_immutable
        else
            echo "Fedora version detected as 39. Not installing x11 support."
        fi
    else
        echo "Unkown error has occured."
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

### gnome Apps
install_gnome_apps(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        packages_gnome
    elif [ $input == "2" ]
    then
        flatpak install --user -y flathub org.gnome.Extensions
        flatpak install --user -y flathub ca.desrt.dconf-editor
        flatpak install --user -y flathub org.gnome.FileRoller
        flatpak install --user -y flathub org.gnome.Evince
        flatpak install --user -y flathub org.pulseaudio.pavucontrol
        flatpak install --user -y flathub org.gnome.Cheese
    else
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
    fi
}

install_gnome_tweaks(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y gnome-tweaks
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree gnome-tweaks
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y gnome-tweaks
    else
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
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
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y xfburn
    else
        echo "Unkown error has occured."
    fi
}

install_remmina(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_remmina
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.remmina.Remmina
    else
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
    fi
}

### internet
install_firefox(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_firefox
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.mozilla.firefox
    else
        echo "Unkown error has occured."
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
        sudo apt-get remove firefox-esr
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
        echo "Unkown error has occured."
    fi
}

install_brave_browser(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_brave_browser
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub com.brave.Browser
    else
        echo "Unkown error has occured."
    fi
}

package_brave_browser(){
    cd $SCRIPTS_HOME/temp
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
        sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        sudo dnf update -y
        sudo dnf install -y brave-browser
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        curl -L -o brave-browser.repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
        sudo chown root:root brave-browser.repo
        sudo mv brave-browser.repo /etc/yum.repos.d/

        curl -L -o brave-core.asc https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        sudo chown root:root brave-core.asc
        sudo mv brave-core.asc /etc/pki/rpm-gpg/
        sudo rpm-ostree refresh-md
        sudo rpm-ostree install brave-browser
        sudo rpm-ostree apply-live
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
        sudo apt-get update
        sudo apt-get install -y brave-browser
    else
        echo "Unkown error has occured."
    fi
}

install_dropbox(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        dropbox_package
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub com.dropbox.Client
    else
        echo "Unkown error has occured."
    fi
}

dropbox_package(){
    
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y dropbox
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install dropbox
    elif [ $PKGMGR == "apt-get" ]
    then
        dropbox_debian_package
    else
        echo "Unkown error has occured."
    fi
}

dropbox_debian_package(){
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
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        transmission_package
    elif [ $input == "2" ]
    then
       flatpak install --user -y  flathub com.transmissionbt.Transmission
    else
        echo "Unkown error has occured."
    fi
}

transmission_package(){
    
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
        echo "Unkown error has occured."
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
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y ffmpeg
    else
        echo "Unkown error has occured."
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
        echo "unfinished"
        sudo rpm-ostree install mesa-va-drivers-freeworld mesa-vdpau-drivers-freeworld

        sudo rpm-ostree install mesa-va-drivers-freeworld.i686 mesa-vdpau-drivers-freeworld.i686
        check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        echo "unfinished"
    else
        echo "Unkown error has occured."
    fi
}

install_vlc(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        vlc_package
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.videolan.VLC
    else
        echo "Unkown error has occured."
    fi
}

vlc_package(){
    
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y vlc
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install vlc
        sudo rpm-ostree apply-live
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y vlc
    else
        echo "Unkown error has occured."
    fi
}

install_obsstudio(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        obsstudio_package
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub com.obsproject.Studio
    else
        echo "Unkown error has occured."
    fi
}

obsstudio_package(){
    
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y obs-studio
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install obs-studio
        sudo rpm-ostree apply-live
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y obs-studio
    else
        echo "Unkown error has occured."
    fi
}
### games
install_steam(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        steam_package
    elif [ $input == "2" ]
    then
        flatpak install --user -y flathub com.valvesoftware.Steam
        flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
        flatpak override com.valvesoftware.Steam  --user --filesystem=xdg-config/MangoHud:ro
        zenity --info --text="steam-devices package will also be installed for controller support."
        install_steam_devices
    else
        echo "Unkown error has occured."
    fi
}

steam_package(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y steam
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install steam
        check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo dpkg --add-architecture i386
        sudo apt-get update
        sudo apt-get install -y steam
    else
        echo "Unkown error has occured."
    fi
}

install_steam_devices(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y steam-devices
    elif [ $PKGMGR == "rpm-ostree" ]
    then
       sudo rpm-ostree install steam-devices
       check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo dpkg --add-architecture i386
        sudo apt-get update
        sudo apt-get install -y steam-devices
    else
        echo "Unkown error has occured."
    fi
}

install_lutris(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        lutris_package
    elif [ $input == "2" ]
    then
            flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
            flatpak install --user -y flathub net.lutris.Lutris
            flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro
    else
        echo "Unkown error has occured."
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
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y lutris
    else
        echo "Unkown error has occured."
    fi
}

install_bottles(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        bottles_package
    elif [ $input == "2" ]
    then
        flatpak install --user -y flathub com.usebottles.bottles
        flatpak override com.usebottles.bottles --user --filesystem=xdg-config/MangoHud:ro
    else
        echo "Unkown error has occured."
    fi
}

bottles_package(){
    
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y bottles
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install bottles
        sudo rpm-ostree apply-live
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Bottles isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y flathub com.usebottles.bottles
        flatpak override com.usebottles.bottles --user --filesystem=xdg-config/MangoHud:ro
    else
        echo "Unkown error has occured."
    fi
}

install_mangohud(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        mangohud_package
    elif [ $input == "2" ]
    then
       flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
    else
        echo "Unkown error has occured."
    fi
}

mangohud_package(){
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
        echo "Unkown error has occured."
    fi
}

install_discord(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        discord_package
    elif [ $input == "2" ]
    then
        flatpak install --user -y flathub com.discordapp.Discord
    else
        echo "Unkown error has occured."
    fi
}

discord_package(){
    
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y discord
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install discord
        sudo rpm-ostree apply-live
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        flatpak install --user -y flathub com.discordapp.Discord
    else
        echo "Unkown error has occured."
    fi
}

install_dolphin_emu(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_dolphin_emu
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.DolphinEmu.dolphin-emu
    else
        echo "Unkown error has occured."
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
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y dolphin-emu
    else
        echo "Unkown error has occured."
    fi
}

download_wowup(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf
    if test -f ~/Desktop/$WOWUPBINARY; then
        echo "WoWUp already downloaded."
    elif ! test -f ~/Desktop/$WOWUPBINARY; then
        cd ~/Desktop/
        curl -L -o $WOWUPBINARY $WOWUPLINK 
        chmod +x $WOWUPBINARY
    fi
}

download_warcraft_logs(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf
    if test -f ~/Desktop/$WOWLOGSBINARY; then
        echo "Warcraft Logs already downloaded."
    elif ! test -f ~/Desktop/$WOWLOGSBINARY; then
        cd ~/Desktop/
        curl -L -o $WOWLOGSBINARY $WOWLOGSLINK
        chmod +x $WOWLOGSBINARY
    fi
}

download_weakauras_companion(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf
    if test -f ~/Desktop/$WACOMPBINARY; then
        echo "WeakAuras Companion already downloaded."
    elif ! test -f  ~/Desktop/$WACOMPBINARY; then
        cd  ~/Desktop/
        curl -L -o $WACOMPBINARY $WACOMPLINK
        chmod +x $WACOMPBINARY
    fi
}

download_minecraft(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf    
    if test -f ~/Desktop/minecraft-launcher; then
        echo "Minecraft already downloaded."
    elif ! test -f ~/Desktop/minecraft-launcher; then
        cd $SCRIPTS_HOME/temp
        curl -L -o $MINECRAFT_ARCHIVE $MINECRAFT_LINK
        tar -xvf Minecraft.tar.gz
        cd minecraft-launcher
        chmod +x minecraft-launcher
        mv minecraft-launcher ~/Desktop/
    fi
}

download_raiderio(){
    echo "Pending removal"
}

### Office Apps
install_qownnotes(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_qownnotes
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.qownnotes.QOwnNotes
    else
        echo "Unkown error has occured."
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
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        flatpak install --user -y flathub org.qownnotes.QOwnNotes
    else
        echo "Unkown error has occured."
    fi
}

install_libreoffice(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_libreoffice
    elif [ $input == "2" ]
    then
        source $SCRIPTS_HOME/packages.sh; "remove_libreoffice"
        flatpak install --user -y flathub org.libreoffice.LibreOffice
    else
        echo "Unkown error has occured."
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
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y libreoffice
    else
        echo "Unkown error has occured."
    fi
}

install_claws_mail(){
    ## template function for aasking to do distro package or flatpak
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_claws_mail
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.claws_mail.Claws-Mail
    else
        echo "Unkown error has occured."
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
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y claws-mail
    else
        echo "Unkown error has occured."
    fi
}

install_thunderbird(){
    ## template function for aasking to do distro package or flatpak
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_thunderbird
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.mozilla.Thunderbird
    else
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
    fi
}

install_keepassxc(){
    ## template function for aasking to do distro package or flatpak
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_keepassxc
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.keepassxc.KeePassXC
    else
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
    fi
}

### coding apps

install_package_tools(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y gcc-g++ autoconf automake bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace perf strace koji\
        mock redhat-rpm-config rpm-build rpmdevtools
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        WARNING_ONE="Installing gcc and package build tools is not supported"
        WARNING_TWO="outside of containers on"
        WARNING_THREE="Fedora Atomic editions."
        zenity --warning --text="$WARNING_ONE $WARNING_TWO $WARNING_THREE"
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y automake gcc g++ bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace linux-perf strace\
        build-essential
    else
        echo "Unkown error has occured."
    fi
}

install_codeblocks(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y codeblocks codeblocks-contrib-devel
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.codeblocks.codeblocks
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y codeblocks
    else
        echo "Unkown error has occured."
    fi
}

install_openjdk(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y java-21-openjdk-devel
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install  java-21-openjdk-devel
        check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Using openjdk 17 as 21 isn't in stable yet."
        sudo apt-get install -y openjdk-17-jdk
    else
        echo "Unkown error has occured."
    fi
}

download_idea(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf
    
    if test -d $APP_FOLDER/idea; then
        echo "Intellij Idea already downloaded."
    elif ! test -d $APP_FOLDER/idea; then
        cd $SCRIPTS_HOME/temp
        curl -L -o idea.tar.gz $IDEA_LINK
        tar -xvf idea.tar.gz
        rm idea.tar.gz
        mv idea* $APP_FOLDER/idea
    fi
}

download_netbeans(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf
    if test -d $APP_FOLDER/netbeans; then
        echo "Netbeans already downloaded."
    elif ! test -d $APP_FOLDER/netbeans; then
        cd $SCRIPTS_HOME/temp
        curl -L -o netbeans.zip $NETBEANS_LINK
        unzip netbeans.zip
        mv $SCRIPTS_HOME/temp/netbeans $APP_FOLDER/netbeans

    fi
}

install_scene_builder(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y openjfx
        curl -L -o scenebuilder.rpm $SCENE_BUILDER_RPM_LINK
        sudo rpm -i scenebuilder.rpm
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install openjfx
        curl -L -o scenebuilder.rpm $SCENE_BUILDER_RPM_LINK
        sudo rpm-ostree install scenebuilder.rpm
        check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y openjfx
        curl -L -o scenebuilder.deb $SCENE_BUILDER_DEB_LINK
        sudo dpkg -i scenebuilder.deb
    else
        echo "Unkown error has occured."
    fi
}

install_lamp_stack(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y httpd mariadb mariadb-server\
        php phpMyAdmin
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install httpd php phpMyAdmin
        check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y apache2 mariadb-client\
        mariadb-server php phpmyadmin
    else
        echo "Unkown error has occured."
    fi
}

install_bluefish(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_bluefish
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub nl.openoffice.bluefish
    else
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
    fi
}

download_pycharm(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf    
    if test -d $APP_FOLDER/pycharm; then
        echo "Pycharm already downloaded."
    elif ! test -d $APP_FOLDER/pycharm; then
        cd $SCRIPTS_HOME/temp
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
        echo "Unkown error has occured."
    fi
}

install_vscodium(){
    if [ $PKGMGR == "dnf" ]
    then
        cd $SCRIPTS_HOME/data
        cp vscodium.repo.txt vscodium.repo
        sudo chown root:root vscodium.repo
        sudo mv vscodium.repo /etc/yum.repos.d/vscodium.repo
        sudo dnf install -y codium
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        cd $SCRIPTS_HOME/data
        cp vscodium.repo.txt vscodium.repo
        sudo chown root:root vscodium.repo
        sudo mv vscodium.repo /etc/yum.repos.d/vscodium.repo
        sudo rpm-ostree install codium
        check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -
        sudo apt-add-repository 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main'
        sudo apt-get update && sudo apt-get install -y codium
        
    else
        echo "Unkown error has occured."
    fi
}

install_vim(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y vim-enhanced
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install vim-enhanced
        check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y vim
    else
        echo "Unkown error has occured."
    fi
}

install_geany(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
    elif [ $PKGMGR == "apt-get" ]
    then
        flatpak install --user -y flathub org.geany.Geany 
    else
        echo "Unkown error has occured."
    fi
}

install_eclipse(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf
    curl -o eclipse.tar.gz $ECLIPSE_LINK

    tar -xvf eclipse.tar.gz
    ./eclipse-installer/eclipse-inst
}

install_github_desktop(){
    ## template function for aasking to do distro package or flatpak
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_install_github_desktop
    elif [ $input == "2" ]
    then
        flatpak install --user -y flathub io.github.shiftey.Desktop
    else
        echo "Unkown error has occured."
    fi
}

package_install_github_desktop(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
        sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
        sudo dnf install -y git-gui github-desktop
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        cd $SCRIPTS_HOME/temp
        curl -L -o shiftkey-gpg.key https://rpm.packages.shiftkey.dev/gpg.key
        sudo chown root:root shiftkey-gpg.key
        sudo mv shiftkey-gpg.key /etc/pki/rpm-gpg/
        sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
        sudo rpm-ostree install git-gui github-desktop
        check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
        sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
        sudo apt-get update && sudo apt-get install -y github-desktop
    else
        echo "Unkown error has occured."
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
        check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y distrobox podman-toolbox
        flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
    else
        echo "Unkown error has occured."
    fi
}

### utilities
install_gtkhash(){
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        package_gtkhash
    elif [ $input == "2" ]
    then
       flatpak install --user -y flathub org.gtkhash.gtkhash
    else
        echo "Unkown error has occured."
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
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y gtkhash
    else
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
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
        check_if_fedora_immutable
    else
        echo "Unkown error has occured."
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
        check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y ffmpeg
    else
        echo "Unkown error has occured."
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
        echo "Unkown error has occured."
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
 
package_type_template(){
    ## template function for aasking to do distro package or flatpak
    echo "Install distro built app (1) or distro neutral flatpak(2)?"
    echo "Flatpaks can include better codec support and faster updates."
    printf "Option: "
    read -r input
    if [ $input == "1" ]
    then
        echo "insert package function"
    elif [ $input == "2" ]
    then
       echo "insert flatpak(s)"
    else
        echo "Unkown error has occured."
    fi
}

standard_package_template(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install 
        #sudo rpm-ostree apply-live
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y
    else
        echo "Unkown error has occured."
    fi
}