#!/usr/bin/bash

echo "Dsk Fedora setup script"

echo "Enter Driver Type"
echo "1. Desktop(AMD) 2. Laptop(AMD)"
echo "3. Server 4. Console"
echo "5. VM"
echo "0. Exit"
read input



if [ $input -eq 1 ]
then
	./33/desktop.sh
elif [ $input -eq 2 ]
then
	./33/laptop.sh
elif [ $input -eq 3 ]
then
    ./33/server.sh
elif [ $input -eq 4 ]
then
    ./33/console.sh
elif [ $input -eq 4 ]
then
	./33/vm.sh
elif [ $input -eq 0 ]
then
	exit
else
	echo "error."
fi
