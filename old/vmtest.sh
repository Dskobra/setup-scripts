#!/usr/bin/bash

echo "Dsk Fedora setup script"

echo "Enter Driver Type"
echo "1. Desktop(AMD) 2. Laptop(AMD)"
echo "3. Server 4. MEDIA Server"
echo "5. VM"
echo "0. Exit"
cpuString=$(cat /proc/cpuinfo | grep 'model name' | uniq)
cpu=$(echo "${cpuString:13}")
vmString=0

check_vm(){
	vmString=$(sudo dmidecode -s system-manufacturer)
}


check_vm
echo $vmString
