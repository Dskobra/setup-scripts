#!/usr/bin/bash
native_rclone(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y rclone rclone-browser
    else
        echo "Unkown error has occurred."
    fi
}

script_rclone(){
    sudo -v ; curl https://rclone.org/install.sh | sudo bash

    RCLONE_BROWSER_LINK="https://github.com/kapitainsky/RcloneBrowser/releases/download/1.8.0/rclone-browser-1.8.0-a0b66c6-linux-x86_64.AppImage"
    RCLONE_BROWSER_BINARY="rclone-browser-1.8.0-a0b66c6-linux-x86_64.AppImage"
    
    if test -f $HOME/Desktop/$RCLONE_BROWSER_BINARY; then
        echo "Rclone Browser already downloaded."
    elif ! test -f $HOME/Desktop/$RCLONE_BROWSER_BINARY; then
        cd /opt/apps/temp || exit
        curl -L -o "$RCLONE_BROWSER_BINARY" "$RCLONE_BROWSER_LINK"
        chmod +x "$RCLONE_BROWSER_BINARY"
        mv /opt/apps/temp/$RCLONE_BROWSER_BINARY $HOME/Desktop
    fi

    

}


if [ "$1" == "script" ]
then
    sudo dnf remove -y rclone
    script_rclone
elif [ "$1" == "native" ]
then
    sudo rm /usr/bin/rclone
    native_rclone
else
    echo "error"
fi
