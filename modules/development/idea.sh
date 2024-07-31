#!/usr/bin/bash

install_idea(){
    echo "-------Pick an option-------"
    echo "(1) download a compressed bundle"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is a bundle extracted from an archive. Stored in ~/Apps/idea"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        download_idea
    elif [ "$input" = 2 ] 
    then
        flatpak install --user -y flathub com.jetbrains.IntelliJ-IDEA-Community
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Unkown error has occurred."
    fi
}

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

install_idea