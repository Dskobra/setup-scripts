#/usr/bin/bash

echo "1. Web Coding 2. Web Server"
echo "0. Exit"
read input



if [ $input -eq 1 ]
then
    ./shared/editors.sh
elif [ $input -eq 2 ]
then
    ./web_server.sh
elif [ $input -eq 0 ]
then
	exit
else
	echo "error."
fi
