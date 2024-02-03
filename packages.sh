#!/usr/bin/bash

install_third_party_repos(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
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
        sudo zypper addrepo --refresh $OPENSUSE_NVIDIA NVIDIA
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
        sudo zypper -n install mate-menu mate-sensors-applet mate-utils\
        multimedia-menus compiz-manager fusion-icon simple-ccsm\
        compiz-plugins-experimental compiz-bcop

        sudo zypper -n install caja-extension-share mate-menu\
        libmate-sensors-applet-plugin0 compizconfig-settings-manager\
        compiz-emerald compiz-emerald-themes
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y mate-menu mate-sensors-applet mate-utils\
        fusion-icon simple-ccsm compiz-plugins-experimental compiz-bcop
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
        sudo apt-get update && sudo apt-get install firefox
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
        sudo sudo rpm-ostree refresh-md
        sudo sudo rpm-ostree install brave-browser
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
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR swap -y ffmpeg-free ffmpeg --allowerasing
        sudo $PKGMGR install -y gstreamer1-plugin-openh264 \
	    mozilla-openh264 ffmpeg ffmpeg-libs.i686 ffmpeg-libs
    elif [ $VARIANT == "ostree" ]
    then
        sudo $PKGMGR override remove libavcodec-free libavfilter-free \
        libavformat-free libavutil-free libpostproc-free \
        libswresample-free libswscale-free --install ffmpeg
        
        sudo $PKGMGR install -y gstreamer1-plugin-openh264 \
        mozilla-openh264

        check_if_immutable
    else
        echo "Unkown error has occured."
    fi
}

install_openshot(){
    source $SCRIPTS_HOME/packages/multimedia_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y $OPENSHOT_FEDORA
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_OPENSHOT
    else
        echo "Unkown error has occured."
    fi
}

install_kthreeb(){
    source $SCRIPTS_HOME/packages/multimedia_apps.conf
    if [ ! -n "$VARIANT" ]
        then
            sudo $PKGMGR install -y $KTHREEB
    elif [ $VARIANT == "ostree" ]
        then
            sudo $PKGMGR install -y $KTHREEB

            check_if_immutable
    fi
}

install_kolourpaint(){
    source $SCRIPTS_HOME/packages/multimedia_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y $KOLOURPAINT
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_KOLOURPAINT
        
    else
        echo "Unkown error has occured."
    fi
}

### games
install_steam(){
    source $SCRIPTS_HOME/packages/gaming_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y $STEAM
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_STEAM
        flatpak install --user -y $FLATPAK_GAMESCOPE
    else
        echo "Unkown error has occured."
    fi
}

install_kpat(){
    source $SCRIPTS_HOME/packages/gaming_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y $KPAT
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_KPAT
    else
        echo "Unkown error has occured."
    fi
}

install_mangohud(){
    source $SCRIPTS_HOME/packages/gaming_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y $MANGOHUD
        flatpak install --user -y $FLATPAK_MANGOHUD
    elif [ $VARIANT == "ostree" ]
    then
        sudo $PKGMGR install -y $MANGOHUD
        flatpak install --user -y $FLATPAK_MANGOHUD

        check_if_immutable
    else
        echo "Unkown error has occured."
    fi
}

### Office Apps

install_abiword(){
    source $SCRIPTS_HOME/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y $GTK_ABIWORD
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_ABIWORD
    else
        echo "Unkown error has occured."
    fi
}

install_gnumeric(){
    source $SCRIPTS_HOME/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y $GTK_GNUMERIC
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_GNUMERIC
    else
        echo "Unkown error has occured."
    fi
}

install_okular(){
    source $SCRIPTS_HOME/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y $KDE_OKULAR
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_OKULAR
    else
        echo "Unkown error has occured."
    fi
}

install_evince(){
    source $SCRIPTS_HOME/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y $GTK_EVINCE
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_EVINCE
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

install_file_roller(){
    source $SCRIPTS_HOME/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y $GTK_FILE_ROLLER
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_FILE_ROLLER
    else
        echo "Unkown error has occured."
    fi
}

install_claws_mail(){
    source $SCRIPTS_HOME/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y $GTK_CLAWS_MAIL
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_CLAWS_MAIL
    else
        echo "Unkown error has occured."
    fi
}

install_thunderbird(){
    source $SCRIPTS_HOME/packages/office_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y $THUNDERBIRD
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_THUNDERBIRD
    else
        echo "Unkown error has occured."
    fi
}

### coding apps

install_c_cpp(){
    source $SCRIPTS_HOME/packages/coding_apps.conf
    sudo $PKGMGR install -y $FEDORA_GCC
    check_if_immutable
}

install_rpm_tools(){
    source $SCRIPTS_HOME/packages/coding_apps.conf
    sudo $PKGMGR install -y $FEDORA_RPM_BUILD_TOOLS
    check_if_immutable
}

install_codeblocks(){
    source $SCRIPTS_HOME/packages/coding_apps.conf
    if [ ! -n "$VARIANT" ]
    then
         sudo $PKGMGR install -y $CODEBLOCKS
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_CODEBLOCKS
    else
        echo "Unkown error has occured."
    fi
}

install_java_jdk(){
    source $SCRIPTS_HOME/packages/coding_apps.conf
    sudo $PKGMGR install -y $JAVA_JDK
    check_if_immutable
}

install_scene_builder(){
    cd $SCRIPTS_HOME/temp
    SCENE_BUILDER="SceneBuilder-20.0.0.rpm"
    curl -o $SCENE_BUILDER https://download2.gluonhq.com/scenebuilder/20.0.0/install/linux/SceneBuilder-20.0.0.rpm
    sudo rpm -i $SCENE_BUILDER
    check_if_immutable
}

install_lamp_stack(){
    source $SCRIPTS_HOME/packages/coding_apps.conf
    sudo $PKGMGR install -y $LAMP_STACK $FEDORA_LAMP_STACK
    check_if_immutable
}

install_bluefish(){
    source $SCRIPTS_HOME/packages/coding_apps.conf
    if [ ! -n "$VARIANT" ]
    then
         sudo $PKGMGR install -y $GTK_BLUEFISH
    elif [ $VARIANT == "ostree" ]
    then
        flatpak install --user -y $FLATPAK_BLUEFISH
        
    else
        echo "Unkown error has occured."
    fi
}

install_python_tools(){
    source $SCRIPTS_HOME/packages/coding_apps.conf
    sudo $PKGMGR install -y $FEDORA_PYTHON_TOOLS
    check_if_immutable
}

install_eric_ide(){
    source $SCRIPTS_HOME/packages/coding_apps.conf
    sudo $PKGMGR install -y $QT_ERIC
    check_if_immutable
}

install_vscodium(){
    cd $SCRIPTS_HOME/modules/packages
    cp vscodium.repo.txt vscodium.repo
    sudo chown root:root vscodium.repo
    sudo mv vscodium.repo /etc/yum.repos.d/vscodium.repo
    sudo $PKGMGR install -y codium
    check_if_immutable
   
}

install_github_desktop(){
    sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
    if [ ! -n "$VARIANT" ]
        then
            sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
            sudo $PKGMGR install -y git-gui github-desktop
            
    elif [ $VARIANT == "ostree" ]
        then
            cd $SCRIPTS_HOME/temp
            curl -L -o shiftkey-gpg.key https://rpm.packages.shiftkey.dev/gpg.key
            sudo chown root:root shiftkey-gpg.key
            sudo mv shiftkey-gpg.key /etc/pki/rpm-gpg/
            sudo $PKGMGR install -y git-gui 
            sudo $PKGMGR install -y github-desktop

            check_if_immutable
    fi
}

install_containers(){
    source $SCRIPTS_HOME/packages/coding_apps.conf
    sudo $PKGMGR install -y toolbox
    sudo $PKGMGR install -y distrobox
    flatpak install --user -y $FLATPAK_PODMAN_DESKTOP
    check_if_immutable
}

### utilities

install_fmedia_writer(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y mediawriter
    elif [ $VARIANT == "ostree" ]
    then
        source $SCRIPTS_HOME/packages/utility_apps.conf
        flatpak install --user -y $FLATPAK_FMEDIA_WRITER

    else
        echo "Unkown error has occured."
    fi
}

install_kde_iso_image_writer(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y isoimagewriter
    elif [ $VARIANT == "ostree" ]
    then
        source $SCRIPTS_HOME/packages/utility_apps.conf
        flatpak install --user -y $FLATPAK_KDE_ISO_IMAGE_WRITER
    else
        echo "Unkown error has occured."
    fi
}

install_kleopatra(){
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y kleopatra
    elif [ $VARIANT == "ostree" ]
    then
        source $SCRIPTS_HOME/packages/utility_apps.conf
        flatpak install --user -y $FLATPAK_KLEOPATRA
    else
        echo "Unkown error has occured."
    fi
}

install_virtualization(){
    source $SCRIPTS_HOME/packages/utility_apps.conf
    if [ ! -n "$VARIANT" ]
    then
        sudo $PKGMGR install -y $VIRTUALIZATION
    elif [ $VARIANT == "ostree" ]
    then
        sudo $PKGMGR install -y $VIRTUALIZATION

        check_if_immutable

    else
        echo "Unkown error has occured."
    fi
    sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
    -O /etc/yum.repos.d/virtio-win.repo
    sudo $PKGMGR install -y virtio-win
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
    if [ ! -n "$VARIANT" ]
        then
            sudo $PKGMGR remove -y libreoffice*
    elif [ $VARIANT == "ostree" ]
        then
            sudo $PKGMGR remove -y libreoffice
            check_if_immutable
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

templatetwo(){
    if [ "$PKGMGR" == "dnf" ] || [ "$PKGMGR" = "rpm-ostree" ]
    then
        echo "template"
    elif [ $PKGMGR == "zypper" ]
    then
        echo "template"
    elif [ $PKGMGR == "apt-get" ]
    then
        echo "template"
    else
        echo "Unkown error has occured."
    fi
}