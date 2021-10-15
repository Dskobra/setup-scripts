#!/usr/bin/bash

non_vm(){
	device=$(cat /etc/hostname)
	if [ "$device" = "DESKTOP" ]
	then
		echo "Device is DESKTOP"
		./35/desktop.sh
	elif [ "$device" = "LAPTOP" ]
	then
		echo "Device is LAPTOP"
		./35/laptop.sh
	elif [ "$device" = "SERVER" ]
	then
	echo "Device is SERVER"
	    ./35/server.sh
	elif [ "$device" = "CONSOLE" ]
	then
		echo "Device is CONSOLE"
	    ./35/console.sh
	elif [ "$device" = "DISPLAY" ]
	then
		echo "DEVICE IS DISPLAY"
		./35/display.sh
	elif [ $input -eq 0 ]
	then
		exit
	else
		echo "error."
	fi
}

non_vm
