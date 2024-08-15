#!/usr/bin/bash

get_updates(){
    test -d "$SCRIPTS_FOLDER"/.git && REPO_FOLDER="exists"
    if [ "$REPO_FOLDER" = "exists" ];
        then
            cd "$SCRIPTS_FOLDER" || exit
            rm -r -f data
            git pull
            zenity --info --text="Please rerun setup.sh now."
    elif [ "$REPO_FOLDER" = "missing" ];
        then
            zenity --info --text="No valid .git folder found. Please redownload them."
    fi
}

REPO_FOLDER="missing"               # .git folder with repository metadata
get_updates
