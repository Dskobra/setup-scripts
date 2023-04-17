#!/usr/bin/bash

main_menu(){
    echo "================================================"
    echo "Main Menu"
    echo "1. Normal 2. ostree"
    echo "3. Containers" 
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        ./dnf_setup.sh
    elif [ "$input" -eq 2 ]
    then
         ./ostree_setup.sh
    elif [ "$input" -eq 3 ]
    then
        ./containers.sh
    elif [ "$input" -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    echo $input
    unset input
    main_menu
}

about(){
    VERSION="4.16.2023"
    echo "================================================"
    echo "Copyright (c) 2021-2023 Jordan Bottoms"
    echo "Released under the MIT license"
    echo "Version: $VERSION"
    echo "================================================"
    main_menu
}
main_menu
