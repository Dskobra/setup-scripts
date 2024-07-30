#!/usr/bin/bash

install_firefox(){
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
        package_firefox
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        remove_firefox
        flatpak install --user -y flathub org.mozilla.firefox
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

package_firefox(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y firefox
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        echo "Immutable variants are unsupported"
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y firefox-esr
        sudo install -d -m 0755 /etc/apt/keyrings
        wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

        gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); print "\n"$0"\n"}'

        echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
        echo '
        Package: *
        Pin: origin packages.mozilla.org
        Pin-Priority: 1000
        ' | sudo tee /etc/apt/preferences.d/mozilla
        sudo apt-get update && sudo apt-get install -y firefox
    else
        echo "Unkown error has occurred."
    fi
}

remove_firefox(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y firefox firefox-langpacks
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree override remove firefox firefox-langpacks
        sudo rpm-ostree apply-live --allow-replacement
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y firefox firerfox-esr
    else
        echo "Unkown error has occurred."
    fi
}

install_firefox