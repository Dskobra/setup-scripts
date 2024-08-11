#!/usr/bin/bash

download_idea(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf
    
    if test -d $APP_FOLDER/idea; then
        echo "Intellij Idea already downloaded."
    elif ! test -d $APP_FOLDER/idea; then
        cd $SCRIPTS_FOLDER/temp
        curl -L -o idea.tar.gz $IDEA_LINK
        tar -xvf idea.tar.gz
        rm idea.tar.gz
        mv idea* $APP_FOLDER/idea
    fi
}

flatpak install --user -y flathub com.jetbrains.IntelliJ-IDEA-Community