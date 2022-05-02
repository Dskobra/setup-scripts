#!/usr/bin/bash
#fix encoding issues. I made this on windows and it keps defaulting to non unix line endings.

dos2unix *.sh
cd extras
dos2unix *.sh
cd ../install
dos2unix *.sh
cd de
dos2unix *.sh
cd ../../menus
dos2unix *.sh
cd ../custom
dos2unix *.sh
cd install
dos2unix *.sh
cd data
dos2unix *.sh
dos2unix *.conf