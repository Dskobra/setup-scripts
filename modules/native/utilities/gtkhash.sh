
#!/usr/bin/bash

package_gtkhash(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y gtkhash
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install gtkhash
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y gtkhash
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y org.gtkhash.gtkhash
package_gtkhash