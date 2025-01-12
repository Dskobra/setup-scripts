#!/usr/bin/bash

install_rclone(){
    sudo -v ; curl https://rclone.org/install.sh | sudo bash

    RCLONE_BROWSER_LINK="https://github.com/kapitainsky/RcloneBrowser/releases/download/1.8.0/rclone-browser-1.8.0-a0b66c6-linux-x86_64.AppImage"
    RCLONE_BROWSER_BINARY="rclone-browser-1.8.0-a0b66c6-linux-x86_64.AppImage"
    
    if test -f /opt/apps/appimages/"$RCLONE_BROWSER_BINARY"; then
        echo "Rclone Browser already downloaded."
    elif ! test -f /opt/apps/appimages/"$RCLONE_BROWSER_BINARY"; then
        cd /opt/apps/appimages/ || exit
        curl -L -o "$RCLONE_BROWSER_BINARY" "$RCLONE_BROWSER_LINK"
        chmod +x "$RCLONE_BROWSER_BINARY"

        curl -L -o $SCRIPTS_FOLDER/temp/rclone_browser.png https://github.com/kapitainsky/RcloneBrowser/blob/master/assets/rclone-browser-32x32.png
        mv $SCRIPTS_FOLDER/temp/rclone_browser.png /opt/apps/icons

        cd $SCRIPTS_FOLDER/modules/packages/internet/
        chmod +x rclone_browser.sh
        mv $SCRIPTS_FOLDER/modules/packages/internet/rclone_browser.sh /home/$USER/bin/rclone_browser
        mv $SCRIPTS_FOLDER/modules/packages/internet/rclone_browser.desktop /home/$USER/Desktop/rclone_browser.desktop
    fi
}

install_rclone