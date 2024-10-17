#!/usr/bin/bash

# downloads the official jetbrains idea community edition

install_idea(){
    IDEA_LINK="https://download.jetbrains.com/idea/ideaIC-2024.2.1.tar.gz"
    
    if test -d $APP_FOLDER/idea; then
        echo "Intellij Idea already downloaded."
    elif ! test -d $APP_FOLDER/idea; then
        cd "$SCRIPTS_FOLDER"/temp || exit
        curl -L -o idea.tar.gz "$IDEA_LINK"
        tar -xvf idea.tar.gz
        rm idea.tar.gz
        mv idea* "$APP_FOLDER"/idea
    fi
}

install_idea
