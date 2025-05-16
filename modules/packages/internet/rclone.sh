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


package_chooser(){
    echo "Select the type of package to install."
    echo "Enter an option or leave blank for default"
    echo "(1) Native                                        (2) Script(default)"
    echo "(h) Help                                          (0) Cancel"
    read -r PACKAGE_TYPE
    if [ "$PACKAGE_TYPE" == "1" ]
    then
        sudo rm /usr/bin/rclone
        sudo dnf install -y rclone rclone-browser
    elif [ "$PACKAGE_TYPE" == "2" ] || [ -z "$PACKAGE_TYPE" ]
    then
        sudo dnf remove -y rclone rclone-browser
        script_rclone
    elif [ "$PACKAGE_TYPE" == "h" ]  || [ "$PACKAGE_TYPE" == "H" ]
    then
        "$SCRIPTS_FOLDER"/modules/core/help.sh
    elif [ "$PACKAGE_TYPE" == "0" ]
    then
        echo "User canceled"
    else
        echo "Unkown error has occurred."
    fi
}

package_chooser
