#!/usr/bin/bash

launch_menu(){
    echo "          ---------------------"   
    echo "          |DSK's Setup Scripts|"
    echo "          ---------------------" 
    echo ""
    echo "            Version: $VERSION"
    echo "     Copyright (c) 2021-2023 Jordan Bottoms"
    echo "         Released under the MIT license"
    echo ""
   $SCRIPTS_HOME/modules/dnf.sh
}

VERSION="11.7.2023.1"
export SCRIPTS_HOME=$(pwd)
mkdir $SCRIPTS_HOME/temp        # make a temp folder for all files to be downloaded to
launch_menu