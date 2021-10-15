#/usr/bin/bash

echo "Dsks Fedora Setup Scripts"

echo "Now self automated :P"

source /etc/os-release
getRelease=$(echo $VERSION_ID)
#getRelease=34		--debugging ???? remove this later idr what it was for.
echo "Fedora Version:" $getRelease

if [ "$getRelease" = "34" ]
then
	echo $getRelease
	./34.sh
elif [ "$getRelease" = "35" ]
then
	echo $getRelease
	./35.sh
elif [ $input -eq 0 ]
then
	exit
else
	echo "error."
fi
