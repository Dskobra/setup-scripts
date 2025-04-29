#!/usr/bin/bash

### Main launch script which sets some variables

export SCRIPTS_FOLDER                           # stores full path for setup-scripts
export DISTRO=""                                # stores distro name.
export COPYRIGHT="Copyright (c) 2021-2025 Jordan Bottoms"
export VERSION="4.28.2025.1"
SCRIPTS_FOLDER=$(pwd)                     
"$SCRIPTS_FOLDER"/modules/core/launcher.sh
