
#!/usr/bin/bash

dnf_menu(){
    echo "              ---------------"
    echo "              |Upgrade Steps|"
    echo "              ---------------"
    echo ""
    echo "                   Menu"
    echo ""
    echo "1. Upgrade                2. Reinstall RPMFusion"
    echo "3. Reinstall Codecs       4. Reinstall Steam"
    echo "5. Reinstall mugshot      6. Update Rescue Kernel"
    echo "9. Main Menu              0. Exit"
    printf "Option: "
    read -r input
    IS_UPGRADE_SAFE="NO"

    case $input in

        1)
            source $SCRIPTS_HOME/modules/shared.sh; "upgrade_check" 
            if [ "$IS_UPGRADE_SAFE" = "YES" ];
                then
                    upgrade_steps
            elif [ "$IS_UPGRADE_SAFE" = "NO" ];
                then
                    remove_rpmfusion
                    upgrade_distro
            fi
            ;;

        2)
            sudo dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
            upgrade_menu
            ;;

        3)
            source $SCRIPTS_HOME/modules/fedora/shared.sh; "install_codecs"
            upgrade_menu
            ;;

        4)
            sudo dnf install -y steam steam-devices
            upgrade_menu
            ;;

        5)
            install_mugshot
            
            ;;

        6)
            update_rescue_kernel
            ;;
            
        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            upgrade_menu
            ;;
            
        esac
        unset input
        upgrade_menu
}

remove_rpmfusion(){
    echo "================================================"
    echo "In order for a successful upgrade to occur" 
    echo "RPMFusion and packages from there need to be "
    echo "removed. Settings will be left intact."
    echo "Would you like to do this now?"
    echo "Type y/n or exit"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input == "y" ] || [ $input == "Y" ]
    then
        sudo dnf remove -y steam steam-devices
        sudo dnf swap -y ffmpeg libavcodec-free --allowerasing
        sudo dnf remove -y rpmfusion-free-release rpmfusion-nonfree-release
        sudo dnf clean all
        sudo dnf update -y
    elif [ $input == "n" ] || [ $input == "N" ]
    then
        echo "Chose not to remove."
    elif [ $input == "exit" ]
    then
	    exit
    else
	    upgrade_menu
    fi
}

dnf_upgrade_(){
    sudo dnf upgrade --refresh
    sudo dnf install dnf-plugin-system-upgrade
    sudo dnf system-upgrade download --releasever=39
    sudo dnf system-upgrade reboot
}

update_rescue_kernel(){
    # For some reason the rescue kernel when updating to a newer Fedora release
    # still lists as the last release in the boot menu. For example f38 after upgrading
    # to f39. This will delete it then reinstall the kernel which will force a rebuild
    # of the rescue image.
    sudo rm /boot/initramfs-0-rescue*.img
    sudo rm /boot/vmlinuz-0-rescue*
    sudo dnf reinstall -y kernel*
}

kinoite_menu(){
    echo "               ---------------"
    echo "               |Upgrade Steps|"
    echo "               ---------------"
    echo ""
    echo "                   Menu"
    echo ""
    echo "1. Full Reset                 2. Upgrade"
    echo "9. Main Menu                  0. Exit"
    printf "Option: "
    read -r input
    IS_UPGRADE_SAFE="NO"

    case $input in

        1)
            perform_reset
            ;;

        2)
            source $SCRIPTS_HOME/modules/shared.sh; "upgrade_check" 
            if [ "$IS_UPGRADE_SAFE" = "YES" ];
                then
                    perform_upgrade
            elif [ "$IS_UPGRADE_SAFE" = "NO" ];
                then
                    perform_reset
            fi
            ;;
        
        9)
            ostree_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            upgrade_menu
            ;;

    esac
    unset input
}

perform_reset(){
    echo "================================================"
    echo "In order to upgrade and prevent issues a reset"
    echo "is recommended. This will remove EVERYTHING that"
    echo "isn't in the kinoite image, but still perserve"
    echo "flatpak apps, appimages, settings and steam"
    echo "library."
    echo "Do you wish to do a reset now?"
    echo "Type y/n or exit"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input == "y" ] || [ $input == "Y" ]
    then
        sudo rpm-ostree reset
        sudo systemctl reboot
    elif [ $input == "n" ] || [ $input == "N" ]
    then
        echo "Chose not to reset."
    elif [ $input == "exit" ]
    then
	    exit
    else
	    upgrade_menu
    fi
}

perform_upgrade(){
    echo "================================================"
    echo "ENSURE YOU DO A RESET BEFORE THIS OR IT WILL FAIL."
    echo "RPMFusion etc will not get redirected to the next"
    echo "fedora version. They will need to be removed"
    echo "beforehand and reinstalled after the upgrade."
    echo "Do you wish to upgrade now?"
    echo "Type y/n or exit"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input == "y" ] || [ $input == "Y" ]
    then
        sudo ostree admin pin 0
        sudo  rpm-ostree rebase fedora:fedora/39/x86_64/kinoite
        sudo systemctl reboot
    elif [ $input == "n" ] || [ $input == "N" ]
    then
        echo "Chose not to upgrade."
    elif [ $input == "exit" ]
    then
	    exit
    else
	    menu
    fi
}

confirm_reboot(){
    echo "================================================"
    echo "Reboots are required to enable the new layers."
    echo "Do you wish to reboot now?"
    echo "Type y/n or exit"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input == "y" ] || [ $input == "Y" ]
    then
        sudo systemctl reboot
    elif [ $input == "n" ] || [ $input == "N" ]
    then
        echo "Chose not to reboot."
    elif [ $input == "exit" ]
    then
	    exit
    else
	    menu
    fi
}

variant_check(){
    VARIANT=$(source /etc/os-release ; echo $VARIANT_ID)
    if [ $VARIANT == "" ] || [ $VARIANT == "kde" ] || [ $VARIANT == "xfce" ]
    then
        dnf_menu
    elif [ $VARIANT == "kinoite" ]
    then
        kinoite_menu
    fi
    echo $variant
}

export VARIANT=""
variant_check
