#!/usr/bin/bash
# Some packages cannot be applied live without restarting.
# Things like adding system groups, installing boot themes,
# steam udev rules (aka steam-devices)
# require rebooting first in order for them to be usable.

confirm_reboot(){
    echo "================================================"
    echo "Some packages won't be availble until a "
    echo "restart is performed."
    echo "Do you wish to restart now?"
    echo "Type y/n or simply enter for no"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" = "y" ] || [ "$input" = "Y" ]
    then
        sudo systemctl reboot
    elif [ "$input" = "n" ] || [ "$input" = "N" ] || [ -z "$input" ]
    then
        echo "Chose not to reboot."
    else
        echo "Invalid option or eror has occured."
    fi
}

confirm_reboot
