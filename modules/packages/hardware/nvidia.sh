#!/usr/bin/bash

install_nvidia(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda nvidia-xconfig nvidia-settings
        sudo akmods --rebuild --force
        sudo dracut --regenerate-all --force
        xdg-open https://rpmfusion.org/Howto/NVIDIA?highlight=%28%5CbCategoryHowto%5Cb%29#Installing_the_drivers
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        echo "#####################nvidia GPU Instructions#####################"
        echo "1. Please open the KDE menu and search for YaST and enter your password when requested."
        echo "2. Click Software Repositories near the top."
        echo "3. Click Add in the bottom left and select Community Repositories near the top of the list."
        echo "4. Select nVidia Graphics Drivers and accept the GnuPG Key."
        echo "5. Once done close Software Repositories and open Software Management in YaST."
        echo "6. Now it should have auto selected the drivers for install on the right. So click Accept."
        echo "7. Lastly reboot once the updates are finished."
        xdg-open "https://en.opensuse.org/SDB:NVIDIA_drivers#Via_YaST_(for_Leap_and_Tumbleweed)"
    else
        echo "Unkown error has occurred."
    fi
}

install_nvidia