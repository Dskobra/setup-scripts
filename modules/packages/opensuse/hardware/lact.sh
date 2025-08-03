#!/usr/bin/bash

package_chooser(){
    echo "                      |-----Package type-----|"
    echo "(1) OBS                                           (2) Upstream RPM (default)"
    echo "(h) Help                                          (0) Cancel"
    echo "Enter an option or leave blank for default"
    read -r PACKAGE_TYPE
    if [ "$PACKAGE_TYPE" == "1" ]
    then
        obs_lact
    elif [ "$PACKAGE_TYPE" == "2" ] || [ -z "$PACKAGE_TYPE" ]
    then
        upstream_lact
    elif [ "$PACKAGE_TYPE" == "h" ]  || [ "$PACKAGE_TYPE" == "H" ]
    then
        lact_help
    elif [ "$PACKAGE_TYPE" == "0" ]
    then
        echo "User canceled"
    else
        echo "Unkown error has occurred."
    fi
}

obs_lact(){
    if [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper addrepo https://download.opensuse.org/repositories/home:ecsos/openSUSE_Tumbleweed/home:ecsos.repo
        sudo zypper --gpg-auto-import-keys ref
        sudo zypper -n install LACT
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        zypper addrepo https://download.opensuse.org/repositories/home:ecsos/openSUSE_Slowroll/home:ecsos.repo
        sudo zypper ref
        sudo zypper -n install LACT
    else
        echo "Error has occured."
    fi

}

upstream_lact(){
    LACTLINK="https://github.com/ilya-zlobintsev/LACT/releases/download/v0.8.0/lact-0.8.0-0.x86_64.opensuse-tumbleweed.rpm"
    LACTRPM="lact-0.8.0-0.x86_64.opensuse-tumbleweed.rpm"
    cd /opt/apps/temp/ || exit
    curl -L -o $LACTRPM $LACTLINK
    sudo zypper -n --no-gpg-checks install $LACTRPM
}

lact_help(){
    echo "openSUSE Build System (OBS) - is a community repository where anybody can release builds. This includes automatic updates, but is not"
    echo "supported by the lact authors and considered unofficial."
    echo ""
    echo "Upstream RPM - script downloads directly from the lact projects github. Does not include automatic updates, but is officially supported."
}
package_chooser

