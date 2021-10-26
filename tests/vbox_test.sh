#!/usr/bin/bash

echo "Dsk Fedora setup script"

check_vm(){
	vmString=$(sudo dmidecode -s system-manufacturer)
	if [ "$vmString" = "QEMU" ]
	then
		echo "Running in a VM" $vmString
	elif [ "$vmString" = "innotek GmbH" ]
	then
		echo "vbox test"
	elif [ "$vmString" != "QEMU" || "innotek GmbH" ]
	then
	echo "success!"
	else
		echo "error"
		exit
	fi
}
check_vm