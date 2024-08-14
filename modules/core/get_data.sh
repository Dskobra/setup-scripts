#!/usr/bin/bash

get_data(){
    # data branch includes links I can update more frequently and
    # my personal mangohud profiles (positioned for my liking).
    echo "Will need to download extra files from data branch"
    cd "$SCRIPTS_FOLDER" || exit
    rm -r -f data
    git clone https://github.com/Dskobra/setup-scripts -b data
    mv "$SCRIPTS_FOLDER"/setup-scripts "$SCRIPTS_FOLDER"/data
}

get_data
