#!/usr/bin/bash
#fix encoding issues. I made this on windows and it keps defaulting to non unix line endings.
old(){
    dos2unix *.sh
    cd 34
    dos2unix *.sh
    cd ../35
    dos2unix *.sh
    cd ../extras
    dos2unix *.sh
    cd ../old
    dos2unix *.sh
    cd ../sources
    dos2unix *.sh
    cd de
    dos2unix *.sh
    cd ../../tests
    dos2unix *.sh
}

dos2unix *.sh
cd extras
dos2unix *.sh
cd ../old
dos2unix *.sh
cd 34
dos2unix *.sh
cd ../35
dos2unix *.sh
cd ../../sources
dos2unix *.sh
cd de
dos2unix *.sh
cd ../../tests
dos2unix *.sh
