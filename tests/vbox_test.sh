#!/usr/bin/bash

echo "Dsk Fedora setup script"

check_vm(){
	vmString=$(sudo dmidecode -s system-manufacturer)
	if [ "$vmString" = "QEMU" ]
	then
		echo "VM detected as: " $vmString
	elif [ "$vmString" = "innotek GmbH" ]
	then
		echo "VM detected as: " $vmString
	elif [ "$vmString" != "QEMU" ] || [ "$vmString" != "innotek GmbH" ]
	then
	echo "Not detected as a VM."
	else
		echo "error"
		exit
	fi
}
check_vm