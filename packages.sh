#!/usr/bin/bash

### All the packages are here. packages.conf from the data
### branch includes the links for pycharm, intellij idea
### community edition, netbeans, scenebuilder, eclipse 
### and wowup

### Scripts need git to pull from data branch, curl to get
### icons and repository info, wget for nodejs and other repositories,
### and zenity for displaying some info.
install_git(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y git
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y git
    else
        echo "Unkown error has occured."
    fi
}

install_curl(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y curl
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y curl
    else
        echo "Unkown error has occured."
    fi
}

install_wget(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y wget
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y wget
    else
        echo "Unkown error has occured."
    fi
}

install_zenity(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y zenity
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install zenity
        sudo rpm-ostree apply-live
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y zenity
    else
        echo "Unkown error has occured."
    fi
}

install_third_party_repos(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo rpm-ostree apply-live
        #check_if_fedora_immutable
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
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y flatpak
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
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y ark kate krdc kcalc kamoso gwenview\
        kleopatra okular signon-kwallet-extension
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        remove_kinoite_flatpaks
        sudo rpm-ostree install krdc signon-kwallet-extension
        flatpak install --user -y flathub org.kde.ark
        flatpak install --user -y flathub org.kde.kcalc
        flatpak install --user -y flathub org.kde.gwenview
        flatpak install --user -y flathub org.kde.kamoso
        flatpak install --user -y flathub org.kde.kleopatra
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y ark kate krdc kcalc kamoso\
        gwenview okular kleopatra signon-kwallet-extension
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
        #check_if_fedora_immutable
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y k3b
    else
        echo "Unkown error has occured."
    fi
}

install_kpat(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kpat
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kpat
    else
        echo "Unkown error has occured."
    fi
}

install_fmedia_writer(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y mediawriter
    elif [ $PKGMGR == "rpm-ostree" ]
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
    elif [ $PKGMGR == "apt-get" ]
    then
        flatpak install --user -y flathub org.kde.isoimagewriter
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

### gtk Apps
install_gnome_apps(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y file-roller evince dconf-editor gnome-tweaks pavucontrol\
        cheese libgtop2-devel lm_sensors # last 2 needed for vitals extension
        flatpak install -y --user flathub org.gnome.Extensions
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree gnome-tweaks dconf-editor libgtop2-devel lm_sensors # last 2 needed for vitals extension
        flatpak install -y --user flathub org.gnome.Extensions
        flatpak install --user -y flathub org.gnome.FileRoller
        flatpak install --user -y flathub org.gnome.Evince
        flatpak install --user -y flathub org.pulseaudio.pavucontrol
        flatpak install --user -y flathub org.gnome.Cheese
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y file-roller evince dconf-editor gnome-tweaks cheese\
        gir1.2-gtop-2.0 lm-sensors # last 2 needed for vitals extension
        flatpak install -y --user flathub org.gnome.Extensions
    else
        echo "Unkown error has occured."
    fi
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
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y remmina
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.remmina.Remmina
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y remmina
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
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y claws-mail
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

### games
install_steam(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y steam
    elif [ $PKGMGR == "rpm-ostree" ]
    then
       flatpak install --user -y flathub com.valvesoftware.Steam 
       flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
       flatpak override com.valvesoftware.Steam  --user --filesystem=xdg-config/MangoHud:ro
       sudo rpm-ostree install steam-devices
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

install_mangohud(){
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

download_wowup(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf
    if test -f /opt/AppInstalls/data/$WOWUPBINARY; then
        echo "WoWUp already downloaded."
    elif ! test -f /opt/AppInstalls/data/$WOWUPBINARY; then
        cd /opt/AppInstalls/data
        curl -L -o $WOWUPBINARY $WOWUPLINK 
        chmod +x $WOWUPBINARY
        cp $SCRIPTS_HOME/data/launchers/wowup.sh /opt/AppInstalls/launchers/wowup.sh
        cp $SCRIPTS_HOME/data/shortcuts/WoWUp.desktop $HOME/.local/share/applications/WoWUp.desktop
        #chown $USER:$USER $HOME/.local/share/applications/WoWUp.desktop
        chmod +x $HOME/.local/share/applications/WoWUp.desktop
        curl -L -o /opt/AppInstalls/icons/wowup.png $WOWUP_IMAGE_LINK
        ln -s "$HOME/.local/share/applications/WoWUp.desktop" "$HOME/Desktop/WoWUp.desktop"
        #ln -s "/opt/AppInstalls/launchers/wowup.sh" "$HOME/Desktop/wowup"          old shorcut link   
    fi
}

download_warcraft_logs(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf
    if test -f /opt/AppInstalls/data/$WOWLOGSBINARY; then
        echo "Warcraft Logs already downloaded."
    elif ! test -f /opt/AppInstalls/data/$WOWLOGSBINARY; then
        cd /opt/AppInstalls/data
        curl -L -o $WOWLOGSBINARY $WOWLOGSLINK
        chmod +x $WOWLOGSBINARY
        cp $SCRIPTS_HOME/data/launchers/warcraft_logs.sh /opt/AppInstalls/launchers/warcraft_logs.sh 
        cp $SCRIPTS_HOME/data/shortcuts/Warcraft_Logs.desktop $HOME/.local/share/applications/Warcraft_Logs.desktop
        chmod +x $HOME/.local/share/applications/Warcraft_Logs.desktop
        curl -L -o /opt/AppInstalls/icons/warcraft_logs.png $WOWLOGS_IMAGE_LINK
        ln -s "$HOME/.local/share/applications/Warcraft_Logs.desktop" "$HOME/Desktop/Warcraft_Logs.desktop"  
    fi
}

download_weakauras_companion(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf
    if test -f /opt/AppInstalls/data/$WACOMPBINARY; then
        echo "WeakAuras Companion already downloaded."
    elif ! test -f /opt/AppInstalls/data/$WACOMPBINARY; then
        cd /opt/AppInstalls/data
        curl -L -o $WACOMPBINARY $WACOMPLINK
        chmod +x $WACOMPBINARY
        cp $SCRIPTS_HOME/data/launchers/weakauras_companion.sh /opt/AppInstalls/launchers/weakauras_companion.sh
        cp $SCRIPTS_HOME/data/shortcuts/WeakAuras_Companion.desktop $HOME/.local/share/applications/WeakAuras_Companion.desktop
        chmod +x $HOME/.local/share/applications/WeakAuras_Companion.desktop
        curl -L -o /opt/AppInstalls/icons/weakauras.png $WAC_IMAGE_LINK
        ln -s "$HOME/.local/share/applications/WeakAuras_Companion.desktop" "$HOME/Desktop/WeakAuras_Companion.desktop"  
    fi
}

download_minecraft(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf    
    if test -f /opt/AppInstalls/data/minecraft-launcher; then
        echo "Minecraft already downloaded."
    elif ! test -f /opt/AppInstalls/data/minecraft-launcher; then
        cd $SCRIPTS_HOME/temp
        curl -L -o $MINECRAFT_ARCHIVE $MINECRAFT_LINK
        tar -xvf Minecraft.tar.gz
        cd minecraft-launcher
        chmod +x minecraft-launcher
        mv minecraft-launcher /opt/AppInstalls/data
        cp $SCRIPTS_HOME/data/launchers/minecraft.sh /opt/AppInstalls/launchers/minecraft.sh
        cp $SCRIPTS_HOME/data/shortcuts/Minecraft.desktop $HOME/.local/share/applications/Minecraft.desktop
        chmod +x $HOME/.local/share/applications/Minecraft.desktop
        curl -L -o /opt/AppInstalls/icons/minecraft.png $MINECRAFT_IMAGE_LINK
        ln -s "$HOME/.local/share/applications/Minecraft.desktop" "$HOME/Desktop/Minecraft.desktop"
    fi
}

download_raiderio(){
    source $SCRIPTS_HOME/data/packages.conf  
    if test -f /opt/AppInstalls/data/RaiderIO.AppImage; then
        echo "Raider.IO already downloaded."
    elif ! test -f /opt/AppInstalls/data/RaiderIO.AppImage; then
        RAIDERIO_WARNING_ONE="Please download the RaiderIO client from https://raider.io/addon, name it as RaiderIO.AppImage"
        RAIDERIO_WARNING_TWO=", mark it as executable (right click and select properties) and place it in /opt/AppInstalls/data"
        zenity --info --text="$RAIDERIO_WARNING_ONE $RAIDERIO_WARNING_TWO"

        #FILEWARNINGONE="Please make sure Raider.IO is in the downloads folder and the filetype"
        #FILEWARNINGTWO="is saved as .AppImage (capital A and I in AppImage) then hit OK."
        #zenity --info --text="$FILEWARNINGONE $FILEWARNINGTWO"
        #chmod +x $HOME/Downloads/RaiderIO.AppImage
        #mv $HOME/Downloads/RaiderIO.AppImage /opt/AppInstalls/data/RaiderIO.AppImage
        
        
        cp $SCRIPTS_HOME/data/launchers/raiderio.sh /opt/AppInstalls/launchers/raiderio.sh
        cp $SCRIPTS_HOME/data/shortcuts/Raider.IO.desktop $HOME/.local/share/applications/Raider.IO.desktop
        chmod +x $HOME/.local/share/applications/Raider.IO.desktop
        curl -L -o /opt/AppInstalls/icons/raiderio.png $RAIDERIO_IMAGE_LINK
        ln -s "$HOME/.local/share/applications/Raider.IO.desktop" "$HOME/Desktop/Raider.IO.desktop"
    fi
}

download_cemu(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf
    if test -f /opt/AppInstalls/data/$CEMU_BINARY; then
        echo "Cemu already downloaded."
    elif ! test -f /opt/AppInstalls/data/$CEMU_BINARY; then
        cd /opt/AppInstalls/data
        curl -L -o $CEMU_BINARY $CEMU_LINK
        chmod +x $CEMU_BINARY
        cp $SCRIPTS_HOME/data/launchers/cemu.sh /opt/AppInstalls/launchers/cemu.sh
        cp $SCRIPTS_HOME/data/shortcuts/Cemu.desktop $HOME/.local/share/applications/Cemu.desktop
        #chown $USER:$USER $HOME/.local/share/applications/Cemu.desktop
        chmod +x $HOME/.local/share/applications/Cemu.desktop
        curl -L -o /opt/AppInstalls/icons/cemu.png $CEMU_IMAGE_LINK
        ln -s "$HOME/.local/share/applications/Cemu.desktop" "$HOME/Desktop/Cemu.desktop"
    fi
}
### Office Apps

install_thunderbird(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y thunderbird
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.mozilla.Thunderbird
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y thunderbird
    else
        echo "Unkown error has occured."
    fi
}

download_bitwarden(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf
    if test -f /opt/AppInstalls/data/$BITWARDEN_BINARY; then
        echo "Bitwarden already downloaded."
    elif ! test -f /opt/AppInstalls/data/$BITWARDEN_BINARY; then
        cd /opt/AppInstalls/data
        curl -L -o $BITWARDEN_BINARY $BITWARDEN_LINK 
        chmod +x $BITWARDEN_BINARY
        cp $SCRIPTS_HOME/data/launchers/bitwarden.sh /opt/AppInstalls/launchers/bitwarden.sh
        cp $SCRIPTS_HOME/data/shortcuts/Bitwarden.desktop $HOME/.local/share/applications/Bitwarden.desktop
        chmod +x $HOME/.local/share/applications/Bitwarden.desktop
        curl -L -o /opt/AppInstalls/icons/bitwarden.png $BITWARDEN_IMAGE_LINK
        ln -s "$HOME/.local/share/applications/Bitwarden.desktop" "$HOME/Desktop/Bitwarden.desktop"
    fi
}

install_keepassxc(){
    if [ $PKGMGR == "dnf" ]
    then
        flatpak install --user -y flathub org.keepassxc.KeePassXC
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.keepassxc.KeePassXC
    elif [ $PKGMGR == "apt-get" ]
    then
        flatpak install --user -y flathub org.keepassxc.KeePassXC
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
    
    if test -d /opt/AppInstalls/data/idea; then
        echo "Intellij Idea already downloaded."
    elif ! test -d /opt/AppInstalls/data/idea; then
        cd $SCRIPTS_HOME/temp
        curl -L -o idea.tar.gz $IDEA_LINK
        tar -xvf idea.tar.gz
        rm idea.tar.gz
        mv idea* /opt/AppInstalls/data/idea
        cp $SCRIPTS_HOME/data/shortcuts/Intelij_Idea.desktop $HOME/.local/share/applications/Intelij_Idea.desktop
        ##chown $USER:$USER $HOME/.local/share/applications/Intelij_Idea.desktop
        ln -s "$HOME/.local/share/applications/Intelij_Idea.desktop" "$HOME/Desktop/Intelij_Idea.desktop"

    fi
}

download_netbeans(){
    cd $SCRIPTS_HOME/temp
    source $SCRIPTS_HOME/data/packages.conf
    if test -d /opt/AppInstalls/data/netbeans; then
        echo "Netbeans already downloaded."
    elif ! test -d /opt/AppInstalls/data/netbeans; then
        cd $SCRIPTS_HOME/temp
        curl -L -o netbeans.zip $NETBEANS_LINK
        unzip netbeans.zip
        mv $SCRIPTS_HOME/temp/netbeans /opt/AppInstalls/data/netbeans
        cp $SCRIPTS_HOME/data/shortcuts/Netbeans.desktop $HOME/.local/share/applications/Netbeans.desktop
        #chown $USER:$USER $HOME/.local/share/applications/Netbeans.desktop
        chmod +x $HOME/.local/share/applications/Netbeans.desktop
        curl -L -o /opt/AppInstalls/icons/netbeans.png $NETBEANS_IMAGE_LINK
        ln -s "$HOME/.local/share/applications/Netbeans.desktop" "$HOME/Desktop/Netbeans.desktop"

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
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y bluefish
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub nl.openoffice.bluefish
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
        check_if_fedora_immutable
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
    if test -d /opt/AppInstalls/data/pycharm; then
        echo "Pycharm already downloaded."
    elif ! test -d /opt/AppInstalls/data/pycharm; then
        cd $SCRIPTS_HOME/temp
        curl -L -o pycharm.tar.gz $PYCHARM_LINK
        tar -xvf pycharm.tar.gz
        rm pycharm.tar.gz
        mv pycharm* /opt/AppInstalls/data/pycharm
        cp $SCRIPTS_HOME/data/shortcuts/Pycharm_Community.desktop $HOME/.local/share/applications/Pycharm_Community.desktop
        #chown $USER:$USER $HOME/.local/share/applications/Pycharm_Community.desktop
        ln -s "$HOME/.local/share/applications/Pycharm_Community.desktop" "$HOME/Desktop/Pycharm_Community.desktop"

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
        sudo dnf remove -y geany
        flatpak install --user -y flathub org.geany.Geany
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        flatpak install --user -y flathub org.geany.Geany 
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
        sudo apt-get install -y distrobox
        flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
    else
        echo "Unkown error has occured."
    fi
}

### utilities


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

remove_office(){
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
 
template(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install 
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y
    else
        echo "Unkown error has occured."
    fi
}