#!/usr/bin/bash
#fix encoding issues. I made this on windows and it keps defaulting to non unix line endings.

PARENT=$(pwd)
dos2unix *
cd $PARENT/mangohud
dos2unix *
cd $PARENT/mangohud/conf
dos2unix *