#!/usr/bin/bash

install_codeblocks(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is distro built"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        flatpak remove --user -y org.codeblocks.codeblocks
        package_codeblocks
    elif [ "$input" = 2 ]
    then
        flatpak install --user -y flathub org.codeblocks.codeblocks
        remove_codeblocks
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Unkown error has occurred."
    fi
}

package_codeblocks(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y codeblocks codeblocks-contrib-devel
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install codeblocks codeblocks-contrib-devel
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y codeblocks-dev
    else
        echo "Unkown error has occurred."
    fi
}

remove_codeblocks(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y codeblocks codeblocks-contrib-devel
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall codeblocks codeblocks-contrib-devel
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y codeblocks-dev
    else
        echo "Unkown error has occurred."
    fi
}

install_codeblocks