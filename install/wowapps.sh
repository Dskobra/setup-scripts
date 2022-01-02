#!/usr/bin/bash
WOWUPLINK=https://github.com/WowUp/WowUp/releases/download/v2.5.2/WowUp-2.5.2.AppImage
WOWUPBINARY=WowUp-2.5.2.AppImage

WAAPLINK=https://github.com/WeakAuras/WeakAuras-Companion/releases/download/v3.3.4/weakauras-companion-3.3.4.x86_64.rpm
WAAPBINARY=weakauras-companion-3.3.4.x86_64.rpm

wowup(){
    mkdir /home/$USER/Games/wowup 
    cd /home/$USER/Games/wowup 
    wget $WOWUPLINK
    chmod +x $WOWUPBINARY
}
weakauras(){
    cd /home/$USER/Downloads
    wget $WAAPLINK
    sudo rpm -i $WAAPBINARY
    rm $WAAPBINARY
}


getlutris()
{
	# changed to upstream lutris due to some weird crashing on 1 computer (other computer oddly is fine), but upstream works fine.
	sudo dnf install -y git
	cd /home/$USER/Apps 
	git clone https://github.com/lutris/lutris.git
	sudo dnf install -y gnome-desktop3 xrandr xorg-x11-server-Xephyr python3-evdev gvfs cabextract \
	python3-magic
	sudo ln -s "/home/$USER/Apps/lutris/bin/lutris" "/usr/bin/lutris"
}
getlutris
wowup
weakauras
