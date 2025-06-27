#!/usr/bin/bash

xiv_launcher(){
    echo "First 2 options are to use XIV Launcher with Steam. Use XIV Flatpak "
    echo "if you do not wish to run it through steam."
    echo "(1) Steam as Native                               (2) Steam as Flatpak"
    echo "(3) XIV Flatpak (non steam)"
    echo "(h) Help                                          (0) Cancel"
    read -r PACKAGE_TYPE
    if [ "$PACKAGE_TYPE" == "1" ]
    then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Blooym/xlm/main/setup/install-native.sh)"
    elif [ "$PACKAGE_TYPE" == "2" ]
    then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Blooym/xlm/main/setup/install-flatpak.sh)"
        sudo dnf remove -y gtkhash
    elif [ "$PACKAGE_TYPE" == "3" ]
    then
        flatpak install --user -y flathub dev.goats.xivlauncher
    elif [ "$PACKAGE_TYPE" == "h" ]  || [ "$PACKAGE_TYPE" == "H" ]
    then
        help
    elif [ "$PACKAGE_TYPE" == "0" ]
    then
        echo "User canceled"
    else
        echo "Unkown option selected."
    fi
}

help(){
    echo "//Steam as Native//"
    echo "This requires steam from rpmfusion and either FFXIV purchased on Steam or at minimum the trial installed. XIV Launcher installs"
    echo "XLCore [XLM] a compatability tool to allow running with Steam and lets you use custom steam launch options including mangohud etc."
    echo ""
    echo ""
    echo "//Steam as Flatpak//"
    echo "Same as above except requries Steam flatpak."
    echo ""
    echo ""
    echo "//XIV Flatpak//"
    echo "This requires the Windows client/license of FFXIV and does not run through steam. Also does not support mangohud, but has the"
    echo "bare min fps meter all installs have."
}
xiv_launcher
