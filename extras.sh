#!/usr/bin/bash


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
PKMGR=""
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