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
        echo "2. Open Software Management and there should be a list of packages to install on the right"
        echo "if it is a fresh install of openSUSE."
        echo "3. Verify either openSUSE-repos-Slowroll-NVIDIA or openSUSE-repos-Tumbleweed-NVIDIA "
        echo "is selected for install."
        echo "4. Click Accept to install and Finish to close out."
        echo "5. With YaST still open click Software Repositories near the top."
        echo "6. Click refresh near the bottom right and select Refresh Enabled and accept the GnuPG Key."
        echo "7. Reopen Software Management and it should have auto selected the drivers for install on the right."
        echo "8. Click Accept and accept the licenses. Once done click Finish and reboot!"
        xdg-open "https://en.opensuse.org/SDB:NVIDIA_drivers#Via_YaST_(for_Leap_and_Tumbleweed)"
    else
        echo "Unkown error has occurred."
    fi
}

install_nvidia