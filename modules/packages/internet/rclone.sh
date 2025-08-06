#!/usr/bin/bash

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

script_rclone
