#!/usr/bin/bash

package_brave_browser(){
    cd $SCRIPTS_FOLDER/temp
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
        sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        sudo dnf update -y
        sudo dnf install -y brave-browser
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        curl -L -o brave-core.asc https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        curl -L -o brave-browser.repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
        sudo chown root:root brave-core.asc
        echo "gpgcheck=0" >> brave-browser.repo
        sudo chown root:root brave-browser.repo
        sudo mv brave-core.asc /etc/pki/rpm-gpg/
        sudo mv brave-browser.repo /etc/yum.repos.d
        sudo rpm-ostree refresh-md
        sudo rpm-ostree install brave-browser
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
        sudo apt-get update
        sudo apt-get install -y brave-browser
    else
        echo "Unkown error has occurred."
    fi
}

flatpak uninstall --user -y com.brave.Browser
package_brave_browser