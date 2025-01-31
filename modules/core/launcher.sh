#!/usr/bin/bash
########################################
# This determines type of distro
# and if it's supported.
########################################
distro_check(){
# Read $DISTRO then execute the appropriate
# distro function.
    if [ "$DISTRO" == "fedora" ]
    then
        fedora_release_check
    elif [ $DISTRO == "opensuse-tumbleweed" ]
    then
        opensuse_tumbleweed_release_check
    elif [ $DISTRO == "opensuse-slowroll" ]
    then
        opensuse_slowroll_release_check
    else
        echo "Unfortunately, '$DISTRO $VERSION_ID' is not a supported distro."
    fi

}

fedora_release_check(){
    # Check fedora version then ensure it's not atomic.
    VARIANT="" 
    test -f /run/ostree-booted && VARIANT=ostree
    if [ "$VERSION_ID" == "40" ] && [ -z "$VARIANT" ] || [ "$VERSION_ID" == "41" ] && [ -z "$VARIANT" ]
    then
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/menu.sh
    else
        echo "These scripts only support Fedora 40/41 non atomic editions."
    fi

}

opensuse_tumbleweed_release_check(){
    if [ "$VERSION_ID" -gt "20251001" ]
    then
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/menu.sh
    else
        echo "These scripts only support Tumbleweed released on or after 10/01/2024"
    fi

}

opensuse_slowroll_release_check(){
    if [ "$VERSION_ID" -gt "20251001" ]
    then
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/menu.sh
    else
        echo "These scripts only support Slowroll released on or after 10/01/2024"
    fi

}

########################################
# End of grouped functions
########################################

DISTRO=$(source /etc/os-release ; echo $ID)                      # store basic distro name
VERSION_ID=$(source /etc/os-release ; echo "$VERSION_ID")        # store distro version number
distro_check                                                     # determine distro