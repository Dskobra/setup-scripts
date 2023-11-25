#!/usr/bin/bash

fbasic(){
    echo "Setting up flathub for user"
    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install --user -y flathub com.dropbox.Client

}

fgames(){
    flatpak install --user -y flathub net.davidotek.pupgui2
    flatpak install --user -y flathub com.github.Matoking.protontricks
    flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08

    flatpak install --user -y flathub com.discordapp.Discord
    flatpak install --user -y flathub org.kde.kpat
    flatpak install --user -y flathub net.lutris.Lutris
    flatpak install --user -y flathub io.github.trigg.discover_overlay
    
    # run once to ensure folders/runtimes are setup
    flatpak run net.lutris.Lutris
}

fmedia(){
    flatpak install --user -y flathub org.kde.kolourpaint
    flatpak install --user -y flathub org.videolan.VLC
    flatpak install --user -y flathub org.openshot.OpenShot
    flatpak install --user -y flathub com.obsproject.Studio

}

futils(){
    flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
    flatpak install --user -y flathub org.kde.kleopatra
	flatpak install --user -y flathub org.gtkhash.gtkhash
    flatpak install --user -y flathub com.github.tchx84.Flatseal
}

fextras(){
    flatpak install --user -y flathub org.libreoffice.LibreOffice
	flatpak install --user -y flathub org.qownnotes.QOwnNotes
    flatpak install --user -y flathub com.transmissionbt.Transmission

    flatpak install --user -y flathub org.fedoraproject.MediaWriter
    flatpak install --user -y flathub org.kde.isoimagewriter
    flatpak install --user -y flathub org.raspberrypi.rpi-imager

}

wowup(){
    WOWUPLINK=https://github.com/WowUp/WowUp.CF/releases/download/v2.10.0/WowUp-CF-2.10.0.AppImage
    WOWUPBINARY=WowUp-CF-2.10.0.AppImage

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

game_profiles(){
    ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/net.lutris.Lutris/config/"

    if test -f /home/$USER/.config/MangoHud/MangoHud.conf; then
        echo "MangoHud.conf exists. Not copying profiles over."
    elif ! test -f /home/$USER/.config/MangoHud/MangoHud.conf; then
        cd $SCRIPTS_HOME/temp/
        git clone https://github.com/Dskobra/setup-scripts -b game-profiles

        mv setup-scripts game-profiles
        cd game-profiles
        dos2unix *.conf
        sudo chown $USER:$USER *.conf
        cp *.conf $HOME/.config/MangoHud/
    fi
}

upgrade_check(){
    # This script checks if rpmfusion, steam and ffmpeg are present.
    # Will print back PRESENT if installed or ABSENT not. Default is
    # to assume they are PRESENT.




    IS_RPMFUSION_FREE_PRESENT="ABSENT"
    IS_RPMFUSION_NONFREE_PRESENT="ABSENT"
    IS_FFMPEG_NONFREE_PRESENT="ABSENT"
    IS_STEAM_PRESENT="ABSENT"

    test -f /etc/yum.repos.d/rpmfusion-free.repo && IS_RPMFUSION_FREE_PRESENT="PRESENT"
    test -f /etc/yum.repos.d/rpmfusion-nonfree.repo && IS_RPMFUSION_NONFREE_PRESENT="PRESENT"
    test -f /usr/bin/ffmpeg && IS_FFMPEG_NONFREE_PRESENT="PRESENT"
    test -f /usr/bin/steam && IS_STEAM_PRESENT="PRESENT"

    echo "RPMFusion Free:       $IS_RPMFUSION_FREE_PRESENT"
    echo "RPMFusion NonFree:    $IS_RPMFUSION_NONFREE_PRESENT"
    echo "FFMPEG:               $IS_FFMPEG_NONFREE_PRESENT"
    echo "Steam:                $IS_STEAM_PRESENT"

    if [ "$IS_RPMFUSION_FREE_PRESENT" = "ABSENT" ] && [ "$IS_RPMFUSION_NONFREE_PRESENT" = "ABSENT" ] && [ "$IS_FFMPEG_NONFREE_PRESENT" = "ABSENT" ] && [ "$IS_STEAM_PRESENT" = "ABSENT" ];
        then
            IS_UPGRADE_SAFE="YES"
            echo "Check passed. Will now run the upgrade."
    elif [ "$IS_RPMFUSION_FREE_PRESENT" = "PRESENT" ] && [ "$IS_RPMFUSION_NONFREE_PRESENT" = "PRESENT" ] && [ "$IS_FFMPEG_NONFREE_PRESENT" = "PRESENT" ] && [ "$IS_STEAM_PRESENT" = "PRESENT" ];
        then
            IS_UPGRADE_SAFE="NO"
    fi
}