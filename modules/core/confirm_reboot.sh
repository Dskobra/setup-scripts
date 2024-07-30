#!/usr/bin/bash

confirm_reboot(){
    # Some packages cannot be applied live without restarting.
    # Things like adding system groups, installing boot themes,
    # steam udev rules (aka steam-devices)
    # require rebooting first in order for them to be usable.
    echo "================================================"
    echo "Some packages won't be availble until a "
    echo "restart is performed."
    echo "Do you wish to restart now?"
    echo "Type y/n"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input == "y" ] || [ $input == "Y" ]
    then
        sudo systemctl reboot
    elif [ $input == "n" ] || [ $input == "N" ]
    then
        echo "Chose not to reboot."
    else
	    main_menu
    fi
}

confirm_reboot