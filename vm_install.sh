#/usr/bin/bash

echo "Dsks Fedora Setup Scripts"

echo "Now self automated :P"

source /etc/os-release
getRelease=$(echo $VERSION_ID)
#getRelease=34		--debugging
echo "Fedora Version:" $getRelease

if [ "$getRelease" = "33" ]
then
	echo $getRelease
	./33.sh
elif [ "$getRelease" = "34" ]
then
	echo $getRelease
	./34.sh
elif [ $input -eq 0 ]
then
	exit
else
	echo "error."
fi
