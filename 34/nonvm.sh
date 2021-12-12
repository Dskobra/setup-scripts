#!/usr/bin/bash

non_vm(){
	device=$(cat /etc/hostname)
	if [ "$device" = "DESKTOP" ]
	then
		echo "Device is DESKTOP"
		./34/desktop.sh
	elif [ "$device" = "LAPTOP" ]
	then
		echo "Device is LAPTOP"
		./34/laptop.sh
	elif [ "$device" = "SERVER" ]
	then
	echo "Device is SERVER"
	    ./34/server.sh
	elif [ "$device" = "CONSOLE" ]
	then
		echo "Device is CONSOLE"
	    ./34/console.sh
	elif [ "$device" = "DISPLAY" ]
	then
		echo "DEVICE IS DISPLAY"
		./34/display.sh
	elif [ $input -eq 0 ]
	then
		exit
	else
		echo "error."
	fi
}

non_vm
