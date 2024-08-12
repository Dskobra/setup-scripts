#!/usr/bin/bash

menu_header(){
    echo "---------------------------"   
    echo "|   DSK's Setup Scripts   |"
    echo "---------------------------" 
    echo ""
    echo "Version: $VERSION"
    echo "Package Type: $PACKAGE_TYPE"
    echo "$COPYRIGHT"
    echo "Released under the MIT license"
    echo ""
    echo ""
    echo "(1) Hardware/Drivers              (2) Desktop Apps"      
    echo "(3) Internet                      (4) Multimedia"
    echo "(5) Gaming                        (6) Office"
    echo "(7) Development                   (8) Utilities"
    echo "(9) Misc                          (10) Update Scripts"
    echo "(0) Exit"
}

menu_header