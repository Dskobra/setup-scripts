#!/usr/bin/bash

install_third_party_repos(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper ar -cfp 90 https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/Essentials/ packman-essentials
        sudo zypper dup --from packman-essentials --allow-vendor-change
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y software-properties-common
        sudo apt-add-repository -y --component contrib non-free
    else
        echo "Unkown error has occured."
    fi
}

install_flatpak(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y flatpak
        flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install flatpak
        flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y flatpak
        flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    else
        echo "Unkown error has occured."
    fi
}

### desktop features
install_corectrl(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y corectrl
        xdg-open https://gitlab.com/corectrl/corectrl/-/wikis/Setup
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install corectrl
        xdg-open https://gitlab.com/corectrl/corectrl/-/wikis/Setup
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper addrepo https://download.opensuse.org/repositories/home:Dead_Mozay/openSUSE_Tumbleweed/home:Dead_Mozay.repo
        sudo zypper refresh
        sudo zypper -n install corectrl
        xdg-open https://gitlab.com/corectrl/corectrl/-/wikis/Setup
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
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper addrepo --refresh https://download.nvidia.com/opensuse/tumbleweed NVIDIA
        sudo zypper install-new-recommends --repo NVIDIA
        xdg-open https://en.opensuse.org/SDB:NVIDIA_drivers
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

install_cheese(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y cheese
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.gnome.Cheese
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install cheese
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y cheese
    else
        echo "Unkown error has occured."
    fi
}

install_kamoso(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kamoso
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.kde.kamoso
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install kamoso
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kamoso
    else
        echo "Unkown error has occured."
    fi
}

install_kdeapps(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kate kmouth krdc kgpg kcalc kontact\
        signon-kwallet-extension gwenview
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install kmouth krdc signon-kwallet-extension
        flatpak install --user -y flathub org.kde.kcalc
        flatpak install --user -y flathub org.kde.gwenview
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install kate kmouth krdc kgpg kcalc kontact\
        signon-kwallet-extension gwenview5
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kate kmouth krdc kgpg kcalc kontact\
        signon-kwallet-extension gwenview
    else
        echo "Unkown error has occured."
    fi
}

install_xfce_apps(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y catfish orage galculator mousepad ristretto seahorse\
        xfce4-clipman-plugin menulibre

        sudo dnf install -y xfce4-battery-plugin xfce4-calculator-plugin xfce4-cpufreq-plugin\
        xfce4-cpugraph-plugin xfce4-diskperf-plugin xfce4-docklike-plugin xfce4-eyes-plugin\
        xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-mailwatch-plugin xfce4-mount-plugin\
        xfce4-netload-plugin xfce4-notes-plugin xfce4-sensors-plugin xfce4-smartbookmark-plugin\
        xfce4-systemload-plugin xfce4-time-out-plugin xfce4-timer-plugin xfce4-verve-plugin\
        xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin\
        xfce4-mpc-plugin

        sudo dnf install -y xfce4-clipman-plugin xfce4-dict-plugin python3-distutils-extra\
        xfce4-statusnotifier-plugin
        install_mugshot
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        echo "Immutable variants are unsupported"
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install catfish orage galculator mousepad ristretto seahorse\
        xfce4-clipman-plugin menulibre

        sudo zypper -n install xfce4-battery-plugin xfce4-calculator-plugin xfce4-cpufreq-plugin\
        xfce4-cpugraph-plugin xfce4-diskperf-plugin xfce4-docklike-plugin xfce4-eyes-plugin\
        xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-mailwatch-plugin xfce4-mount-plugin\
        xfce4-netload-plugin xfce4-notes-plugin xfce4-sensors-plugin xfce4-smartbookmark-plugin\
        xfce4-systemload-plugin xfce4-time-out-plugin xfce4-timer-plugin xfce4-verve-plugin\
        xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin\
        xfce4-mpc-plugin

        sudo zypper -n install xfce4-panel-plugin-dict mugshot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y catfish orage galculator mousepad ristretto seahorse xfce4-clipman-plugin menulibre
        sudo apt-get install -y xfce4-battery-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin\
        xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin\
        xfce4-mailwatch-plugin xfce4-mount-plugin xfce4-netload-plugin xfce4-sensors-plugin\
        xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-timer-plugin xfce4-verve-plugin\
        xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin 
    else
        echo "Unkown error has occured."
    fi
}

install_mugshot(){
    MUGSHOT_FOLDER="mugshot-0.4.3"
    cd $SCRIPTS_HOME/temp/
    curl -L -o $MUGSHOT_FOLDER.tar.gz https://github.com/bluesabre/mugshot/releases/download/mugshot-0.4.3/mugshot-0.4.3.tar.gz
    tar -xvf $MUGSHOT_FOLDER.tar.gz
    cd $MUGSHOT_FOLDER
    sudo python3 setup.py install
    sudo mkdir /usr/local/share/glib-2.0/schemas
    cd data/glib-2.0/schemas/
    sudo cp org.bluesabre.mugshot.gschema.xml  /usr/local/share/glib-2.0/schemas
    sudo glib-compile-schemas /usr/local/share/glib-2.0/schemas
}

install_mate_apps(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y mate-menu mate-sensors-applet mate-utils\
        multimedia-menus compiz-manager fusion-icon simple-ccsm\
        compiz-plugins-experimental compiz-bcop

        sudo dnf install -y caja-beesu caja-share ccsm \
        compizconfig-python emerald emerald-themes simple-ccsm
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        echo "Immutable variants are unsupported"
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install mate-menu compiz-manager fusion-icon\
        simple-ccsm compiz-plugins-experimental compiz-bcop

        sudo zypper -n install caja-extension-share mate-menu\
        libmate-sensors-applet-plugin0 compizconfig-settings-manager\
        compiz-emerald compiz-emerald-themes
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y mate-menu mate-sensors-applet mate-utils\
        fusion-icon simple-ccsm compiz-plugins-experimental compiz-bcop\
        emerald emerald-themes
    else
        echo "Unkown error has occured."
    fi
}

### internet
install_firefox(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y firefox
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        echo "Immutable variants are unsupported"
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install MozillaFirefox
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo install -d -m 0755 /etc/apt/keyrings
        sudo apt-get install -y wget
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
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
        sudo zypper -n install brave-browser
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y curl
        sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
        sudo apt-get update
        sudo apt-get install -y brave-browser
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
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install ffmpeg-6 mozilla-openh264\
        gstreamer-plugin-openh264
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y ffmpeg
    else
        echo "Unkown error has occured."
    fi
}

install_openshot(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y openshot
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.openshot.OpenShot
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install openshot-qt
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
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install k3b
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y k3b
    else
        echo "Unkown error has occured."
    fi
}

install_kolourpaint(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kolourpaint
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.kde.kolourpaint
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install kolourpaint
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kolourpaint
    else
        echo "Unkown error has occured."
    fi
}

### games
install_steam(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y steam
    elif [ $PKGMGR == "rpm-ostree" ]
    then
       flatpak install --user -y flathub com.valvesoftware.Steam 
       flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install steam
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo dpkg --add-architecture i386
        sudo apt-get update
        sudo apt-get install -y steam
    else
        echo "Unkown error has occured."
    fi
}

install_kpat(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kpat
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.kde.kpat
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install kpat
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kpat
    else
        echo "Unkown error has occured."
    fi
}

install_mangohud(){
    mkdir "$HOME"/.config/MangoHud/
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y mangohud goverlay
        flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install mangohud goverlay
        flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install mangohud goverlay
        flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y mangohud goverlay
        flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
    else
        echo "Unkown error has occured."
    fi
}
### Office Apps

install_abiword(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y abiword
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub com.abisource.AbiWord
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install abiword
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y abiword
    else
        echo "Unkown error has occured."
    fi
}

install_gnumeric(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y gnumeric
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.gnumeric.Gnumeric
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install gnumeric
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y gnumeric
    else
        echo "Unkown error has occured."
    fi
}

install_okular(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y okular
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.kde.okular
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install okular
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y okular
    else
        echo "Unkown error has occured."
    fi
}

install_evince(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y evince
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.gnome.Evince
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install evince
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y evince
    else
        echo "Unkown error has occured."
    fi
}

install_kde_ark(){
    source $SCRIPTS_HOME/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y $KDE_ARK
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_ARK
    else
        echo "Unkown error has occured."
    fi
}

install_kde_ark(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y ark
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.kde.ark
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install ark
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y ark
    else
        echo "Unkown error has occured."
    fi
}

install_file_roller(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y file-roller
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.gnome.FileRoller
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install file-roller
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y file-roller
    else
        echo "Unkown error has occured."
    fi
}

install_claws_mail(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y claws-mail
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.claws_mail.Claws-Mail
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install claws-mail
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y claws-mail
    else
        echo "Unkown error has occured."
    fi
}

install_thunderbird(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y thunderbird
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.mozilla.Thunderbird
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install thunderbird
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y thunderbird
    else
        echo "Unkown error has occured."
    fi
}
### coding apps

install_c_cpp(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y gcc-g++ autoconf automake bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace perf strace
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install gcc-g++ autoconf automake bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace perf strace
        check_if_fedora_immutable 
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install gcc-c++ autoconf automake bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace perf strace
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y automake gcc g++ bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace linux-perf strace
    else
        echo "Unkown error has occured."
    fi
}

install_package_tools(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y koji mock redhat-rpm-config\
        rpm-build rpmdevtools
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install koji mock redhat-rpm-config\
        rpm-build rpmdevtools
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install rpm-build build inst-source-utils
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y build-essential
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
    elif [ $PKGMGR == "zypper" ]
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
        sudo dnf install -y java-17-openjdk-devel
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install  java-17-openjdk-devel
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install java-17-openjdk-devel
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y openjdk-17-jdk
    else
        echo "Unkown error has occured."
    fi
}

install_idea(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/temp/data/packages.conf
    IDEA_LINK=https://download.jetbrains.com/idea/ideaIC-2023.3.2.tar.gz
    IDEA_ARCHIVE="ideaIC-2023.3.2.tar.gz"
    IDEA_OLD_FOLDER="idea-IC*"
    IDEA_FOLDER="idea"
    
    if test -d /opt/$IDEA_FOLDER; then
        echo "Intellij already downloaded."
    elif ! test -d /opt/$IDEA_FOLDER; then
        rm "$HOME/Desktop/idea"       # symlink gets put in idea folder if its present on desktop
        cd $SCRIPTS_HOME/temp
        curl -L -o $IDEA_ARCHIVE $IDEA_LINK
        tar -xvf $IDEA_ARCHIVE
        chmod +x $IDEA_OLD_FOLDER
        sudo mv $IDEA_OLD_FOLDER /opt/$IDEA_FOLDER
        ln -s "/opt/idea/bin/idea.sh" "$HOME/Desktop/idea"

    fi
}
install_scene_builder(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/temp/data/packages.conf
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y openjfx
        curl -L -o $SCENE_BUILDER_RPM $SCENE_BUILDER_RPM_LINK
        sudo rpm -i $SCENE_BUILDER_RPM
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install openjfx
        curl -L -o $SCENE_BUILDER_RPM $SCENE_BUILDER_RPM_LINK
        sudo rpm -i $SCENE_BUILDER_RPM
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install openjfx
        curl -L -o $SCENE_BUILDER_RPM $SCENE_BUILDER_RPM_LINK
        echo "Please use Yast to install this by going into the scripts main folder -> Temp and right clicking 'SceneBuilder-*.rpm'"
        echo "and choosing to open with YaST Software. You'll need to hit ignore to allow the installation."
        xdg-open $SCRIPTS_HOME/temp
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y openjfx
        curl -L -o $SCENE_BUILDER_DEB $SCENE_BUILDER_DEB_LINK
        sudo dpkg -i $SCENE_BUILDER_DEB
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
        sudo rpm-ostree install httpd php phpMyAdmin mariadb\
        mariadb-server
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install apache2 mariadb php8 phpMyAdmin
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y apache2 mariadb-client\
        mariadb-server php phpmyadmin
    else
        echo "Unkown error has occured."
    fi
}

install_bluefish(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y bluefish
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub nl.openoffice.bluefish
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install bluefish
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y bluefish
    else
        echo "Unkown error has occured."
    fi
}

install_python_tools(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y python3-idle python3-devel
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install python3-idle python3-devel
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install python311-idle python311-devel
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y idle-python3.11 python3.11-dev
    else
        echo "Unkown error has occured."
    fi
}

install_eric_ide(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y eric
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install eric
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install eric
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
        cd $SCRIPTS_HOME/packages
        cp vscodium.repo.txt vscodium.repo
        sudo chown root:root vscodium.repo
        sudo mv vscodium.repo /etc/yum.repos.d/vscodium.repo
        sudo dnf install -y codium
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        cd $SCRIPTS_HOME/modules/packages
        cp vscodium.repo.txt vscodium.repo
        sudo chown root:root vscodium.repo
        sudo mv vscodium.repo /etc/yum.repos.d/vscodium.repo
        sudo rpm-ostree install codium
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        cd $SCRIPTS_HOME/packages
        cp vscodium.repo.txt vscodium.repo
        sudo chown root:root vscodium.repo
        sudo mv vscodium.repo /etc/zypp/repos.d/vscodium.repo
        sudo zypper refresh
        sudo zypper -n install codium
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
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install vim
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
        sudo dnf remove -y geany
        flatpak install --user -y flathub org.geany.Geany
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.geany.Geany 
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install geany
    elif [ $PKGMGR == "apt-get" ]
    then
        flatpak install --user -y flathub org.geany.Geany 
    else
        echo "Unkown error has occured."
    fi
}

install_github_desktop(){
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
        sudo rpm-ostree install git-gui github-desktop
        check_if_fedora_immutable
    elif [ $PKGMGR == "zypper" ]
    then
        sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
        sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/zypp/repos.d/shiftkey-packages.repo'
        sudo zypper refresh
        sudo zypper -n install git-gui github-desktop
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
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install toolbox distrobox
        flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y distrobox
        flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
    else
        echo "Unkown error has occured."
    fi
}

### utilities
install_fmedia_writer(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y mediawriter
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.fedoraproject.MediaWriter
    elif [ $PKGMGR == "zypper" ]
    then
        flatpak install --user -y flathub org.fedoraproject.MediaWriter
    elif [ $PKGMGR == "apt-get" ]
    then
        flatpak install --user -y flathub org.fedoraproject.MediaWriter
    else
        echo "Unkown error has occured."
    fi
}

install_kde_iso_image_writer(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y isoimagewriter
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.kde.isoimagewriter
    elif [ $PKGMGR == "zypper" ]
    then
        flatpak install --user -y flathub org.kde.isoimagewriter
    elif [ $PKGMGR == "apt-get" ]
    then
        flatpak install --user -y flathub org.kde.isoimagewriter
    else
        echo "Unkown error has occured."
    fi
}

install_kleopatra(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kleopatra
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.kde.kleopatra
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install kleopatra
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kleopatra
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
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
        -O /etc/yum.repos.d/virtio-win.repo
    elif [ $PKGMGR == "zypper" ]
    then
        sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
        -O /etc/zypp/repos.d/virtio-win.repo
        
        sudo zypper refresh
        sudo zypper -n install libvirt-daemon-config-network\
        qemu-kvm virt-install virt-manager virt-viewer libvirt\
        libvirt-daemon-driver-lxc libvirt-daemon-lxc\
        libvirt-daemon-driver-storage-gluster\
        libvirt-daemon-hooks libvirt-daemon-plugin-sanlock\
        libvirt-daemon-qemu libvirt-daemon-config-network\
        qemu-kvm virt-install virt-manager virt-viewer
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y curl
        cd ~/Downloads/
        curl -L -o virtio-win.iso https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso
        sudo apt-get install -y libvirt-daemon-config-network qemu-kvm virt-manager virt-viewer
    else
        echo "Unkown error has occured."
    fi
}

wowup(){
    WOWUPLINK=https://github.com/WowUp/WowUp.CF/releases/download/v2.11.0/WowUp-CF-2.11.0.AppImage
    WOWUPBINARY=WowUp-CF-2.11.0.AppImage

    if test -f /home/$USER/Desktop/$WOWUPBINARY; then
        echo "WoWUp already downloaded."
    elif ! test -f /home/$USER/Desktop/$WOWUPBINARY; then
        cd "$HOME"/Desktop
        curl -L -o $WOWUPBINARY $WOWUPLINK 
        chmod +x $WOWUPBINARY
    fi
}

minecraft(){
    MINECRAFT_LINK=https://launcher.mojang.com/download/Minecraft.tar.gz
    MINECRAFT_ARCHIVE=Minecraft.tar.gz
    
    if test -f /home/$USER/Desktop/minecraft-launcher; then
        echo "Minecraft already downloaded."
    elif ! test -f /home/$USER/Desktop/minecraft-launcher; then
        cd $SCRIPTS_HOME/temp
        curl -L -o $MINECRAFT_ARCHIVE $MINECRAFT_LINK
        tar -xvf Minecraft.tar.gz
        cd minecraft-launcher
        chmod +x minecraft-launcher
        mv minecraft-launcher "$HOME"/Desktop
    fi
}

install_nodejs(){
    echo "This downloads the nvm or Node Version Manager script to install"
    echo "the latest nodejs long term support release."
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
}

install_eclipse(){
    cd $SCRIPTS_HOME/temp
    ECLIPSE="eclipse-inst-jre-linux64.tar.gz"
    curl -o $ECLIPSE https://eclipse.mirror.rafal.ca/oomph/epp/2023-09/R/eclipse-inst-jre-linux64.tar.gz

    tar -xvf $ECLIPSE
    ./eclipse-installer/eclipse-inst
}



install_netbeans(){
    NETBEANS_LINK=https://dlcdn.apache.org/netbeans/netbeans/20/netbeans-20-bin.zip
    NETBEANS_ARCHIVE=netbeans-20-bin.zip
    NETBEANS_FOLDER=netbeans
    
    if test -d /opt/$NETBEANS_FOLDER; then
        echo "Netbeans already downloaded."
    elif ! test -d /opt/$$NETBEANS_FOLDER; then
        rm "$HOME/Desktop/netbeans"       # symlink gets put in folder if its present on desktop
        cd $SCRIPTS_HOME/temp
        curl -L -o $NETBEANS_ARCHIVE $NETBEANS_LINK
        unzip $NETBEANS_ARCHIVE
        chmod +x $NETBEANS_FOLDER
        sudo mv $NETBEANS_FOLDER /opt/$NETBEANS_FOLDER
        ln -s "/opt/netbeans/bin/netbeans" "$HOME/Desktop/netbeans"

    fi
}

install_pycharm(){
    PYCHARM_LINK=https://download.jetbrains.com/python/pycharm-community-2023.3.2.tar.gz
    PYCHARM_ARCHIVE=pycharm-community-2023.3.2.tar.gz
    PYCHARM_OLD_FOLDER=pycharm-community-2023.3.2
    PYCHARM_FOLDER=pycharm
    
    if test -d /opt/$PYCHARM_FOLDER; then
        echo "Pycharm already downloaded."
    elif ! test -d /opt/$PYCHARM_FOLDER; then
        rm "$HOME/Desktop/pycharm"       # symlink gets put in pycharm folder if its present on desktop
        cd $SCRIPTS_HOME/temp
        curl -L -o $PYCHARM_ARCHIVE $PYCHARM_LINK
        tar -xvf $PYCHARM_ARCHIVE
        chmod +x $PYCHARM_OLD_FOLDER
        sudo mv $PYCHARM_OLD_FOLDER /opt/$PYCHARM_FOLDER
        ln -s "/opt/pycharm/bin/pycharm.sh" "$HOME/Desktop/pycharm"

    fi
}
### remove packages

remove_codecs(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR swap -y ffmpeg libavcodec-free --allowerasing
        sudo $PKGMGR swap -y mesa-va-drivers-freeworld mesa-va-drivers 
        sudo $PKGMGR swap -y mesa-vdpau-drivers-freeworld mesa-vdpau-drivers 
    elif [ $VARIANT == "ostree" ]
    then
        sudo $PKGMGR remove ffmpeg
        sudo $PKGMGR override reset libavcodec-free libavfilter-free \
        libavformat-free libavutil-free libpostproc-free \
        libswresample-free libswscale-free
        sudo $PKGMGR override reset mesa-va-drivers mesa-vdpau-drivers-freeworld
        
        sudo $PKGMGR remove -y gstreamer1-plugin-openh264 \
        mozilla-openh264

        
        check_if_immutable
    else
        echo "Unkown error has occured."
    fi
}

remove_office(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y libreoffice*
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree remove libreoffice
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install libreoffice*
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y libreoffice*
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
 
template(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install 
    elif [ $PKGMGR == "zypper" ]
    then
        sudo zypper -n install
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y
    else
        echo "Unkown error has occured."
    fi
}