#!/usr/bin/bash

# This script checks if rpmfusion, steam and ffmpeg are present.
# Will print back PRESENT or ABSENT depending on if it is or isn't.




IS_RPMFUSION_FREE_PRESENT="ABSENT"
IS_RPMFUSION_NONFREE_PRESENT="ABSENT"
IS_FFMPEG_NONFREE_PRESENT="ABSENT"
IS_STEAM_PRESENT="ABSENT"

test -f /etc/yum.repos.d/rpmfusion-free.repo && IS_RPMFUSION_FREE_PRESENT="PRESENT"
test -f /etc/yum.repos.d/rpmfusion-nonfree.repo && IS_RPMFUSION_NONFREE_PRESENT="PRESENT"
test -f /usr/bin/ffmpeg && IS_FFMPEG_NONFREE_PRESENT="PRESENT"
test -f /usr/bin/steam && IS_STEAM_PRESENT="PRESENT"

echo "RPMFusion Free:       $IS_RPMFUSION_FREE_PRESENT"
echo "RPMFusion NonFree:    $IS_RPMFUSION_NONFREE_PRESENT"
echo "FFMPEG:               $IS_FFMPEG_NONFREE_PRESENT"
echo "Steam:                $IS_STEAM_PRESENT"

if [ "$IS_RPMFUSION_FREE_PRESENT" = "ABSENT" ] ||  [ "$IS_RPMFUSION_NONFREE_PRESENT" = "ABSENT" ] || [ "$IS_FFMPEG_NONFREE_PRESENT" = "ABSENT" ]  || [ "$IS_STEAM_PRESENT" = "ABSENT" ];
    then
        IS_UPGRADE_SAFE="YES"
        echo "Check passed. Will now run the upgrade."
elif [ "$IS_RPMFUSION_FREE_PRESENT" = "PRESENT" ] || [ "$IS_RPMFUSION_NONFREE_PRESENT" = "PRESENT" ] || [ "$IS_FFMPEG_NONFREE_PRESENT" = "PRESENT" ] || [ "$IS_STEAM_PRESENT" = "PRESENT" ];
    then
        IS_UPGRADE_SAFE="NO"
        echo "Check failed. Please make sure to run the "Remove RPMFusion" or "Wipe layers/overrides" option from the Upgrade steps."
fi