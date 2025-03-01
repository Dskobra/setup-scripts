#!/usr/bin/bash

### Main launch script which makes the temp/app folders
### and sets some variables

export SCRIPTS_FOLDER                           # stores full path for setup-scripts
export DISTRO=""                                # stores distro name.
export COPYRIGHT="Copyright (c) 2021-2025 Jordan Bottoms"
export VERSION="3.1.2025"
SCRIPTS_FOLDER=$(pwd)
mkdir $SCRIPTS_FOLDER/temp                      
"$SCRIPTS_FOLDER"/modules/core/launcher.sh