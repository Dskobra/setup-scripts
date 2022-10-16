#!/usr/bin/bash
#fix encoding issues. I made this on windows and it keps defaulting to non unix line endings.

PARENT=$(pwd)
dos2unix *
cd $PARENT/custom
dos2unix *
cd $PARENT/custom/data
dos2unix *
cd $PARENT/custom/data/mangohud
dos2unix *
cd $PARENT/custom/data/shortcuts
dos2unix *
