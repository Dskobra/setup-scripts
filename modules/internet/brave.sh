#!/usr/bin/bash

install_brave_browser(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        flatpak uninstall --user -y flathub com.brave.Browser
        package_brave_browser
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        remove_brave_browser
        flatpak install --user -y flathub com.brave.Browser
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

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

remove_brave_browser(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y brave-browser
        sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
        sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        sudo dnf update -y
        
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall brave-browser
        sudo rm /etc/yum.repos.d/brave-browser.repo
        sudo rm /etc/pki/rpm-gpg/brave-core.asc
        sudo rpm-ostree refresh-md
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y brave-browser
        sudo rm /etc/apt/sources.list.d/brave-browser-release.list
        sudo apt-get update
        
    else
        echo "Unkown error has occurred."
    fi
}

install_brave_browser