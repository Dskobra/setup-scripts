#!/usr/bin/bash

game_profiles(){
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

variant_check(){
    VARIANT=$(source /etc/os-release ; echo $VARIANT_ID)
    if [ $VARIANT == "" ] || [ $VARIANT == "kde" ] || [ $VARIANT == "xfce" ]
    then
        PKMGR="dnf"
        sudo $PKGMR install -y dnfdragora
    elif [ $VARIANT == "kinoite" ]
    then
        PKMGR="rpm-ostree"
    fi
    echo $variant
}
export SCRIPTS_HOME=$(pwd)
export VARIANT=""
export PKMGR=""
echo "Personal script with extra stuff user may not want. Such as copying my mangohud profiles or setting some autostart apps."

variant_check
sudo $PKGMR install -y plymouth-theme-spinfinity
sudo plymouth-set-default-theme spinfinity -R

mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.
cp /home/$USER/.local/share/flatpak/exports/share/applications/com.dropbox.Client.desktop /home/$USER/.config/autostart/com.dropbox.Client.desktop
DISCORD="/home/$USER/.local/share/flatpak/exports/share/applications/com.discordapp.Discord.desktop"
DOVERLAY="/home/$USER/.local/share/flatpak/exports/share/applications/io.github.trigg.discover_overlay.desktop"
STEAM="/usr/share/applications/steam.desktop"
CORECTRL="/usr/share/applications/org.corectrl.corectrl.desktop"

[ -f $DISCORD ] && { echo "Discord was found. Adding to startup."; cp "$DISCORD"  /home/$USER/.config/autostart/com.discordapp.Discord.desktop; }
[ -f $DOVERLAY ] && { echo "Discord Overlay was found. Adding to startup."; cp "$DOVERLAY"  /home/$USER/.config/autostart/io.github.trigg.discover_overlay.desktop; }
[ -f $STEAM ] && { echo "Steam was found. Adding to startup."; cp "$STEAM"  /home/$USER/.config/autostart/steam.desktop; }
[ -f $CORECTRL ] && { echo "Corectrl was found. Adding to startup."; cp "$CORECTRL"  /home/$USER/.config/autostart/org.corectrl.corectrl.desktop; }
game_profiles