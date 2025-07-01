#!/usr/bin/bash
distro_check(){
    # check if fedora
    if [ "$DISTRO" == "fedora" ]
    then
        fedora_release_check
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        opensuse_slowroll_release_check
    else
        echo "Unfortunately, '$DISTRO $VERSION_ID' is not a supported distro."
    fi

}

fedora_release_check(){
    if [ "$VERSION_ID" == "41" ] || [ "$VERSION_ID" == "42" ]
    then
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/packages/fedora/menu.sh
    else
        echo "These scripts only support Fedora 41/42 non atomic editions."
    fi

}

opensuse_slowroll_release_check(){
    if [ "$VERSION_ID" -ge "20250501" ]
    then
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/menu.sh
    else
        echo "These scripts only support Slowroll released on or after 05/01/2025"
    fi

}
DISTRO=$(source /etc/os-release ; echo $ID)                      # store basic distro name
VERSION_ID=$(source /etc/os-release ; echo "$VERSION_ID")        # store distro version number
distro_check                                                     # determine distro
