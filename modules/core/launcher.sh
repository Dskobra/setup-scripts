#!/usr/bin/bash
distro_check(){
    # check if fedora
    if [ "$DISTRO" == "fedora" ]
    then
        fedora_release_check
    else
        echo "Unfortunately, '$DISTRO $VERSION_ID' is not a supported distro."
    fi

}

fedora_release_check(){
    # Check fedora version then ensure it's not atomic.
    VARIANT="" 
    test -f /run/ostree-booted && VARIANT=ostree
    if [ "$VERSION_ID" == "41" ] && [ -z "$VARIANT" ] || [ "$VERSION_ID" == "42" ] && [ -z "$VARIANT" ]
    then
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/packages/fedora/menu.sh
    else
        echo "These scripts only support Fedora 41/42 non atomic editions."
    fi

}

DISTRO=$(source /etc/os-release ; echo $ID)                      # store basic distro name
VERSION_ID=$(source /etc/os-release ; echo "$VERSION_ID")        # store distro version number
distro_check                                                     # determine distro
