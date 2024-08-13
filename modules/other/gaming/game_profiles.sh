#!/usr/bin/bash

# copies my personal mangohud profiles into ~/.config/MangoHud

setup_game_profiles(){
    echo "-------Pick an option-------"
    echo "(1) Setup some mangohud profiles"
    echo "(2) Supported games"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        copy_game_profiles
    elif [ "$input" = 2 ]
    then
        xdg-open https://github.com/Dskobra/setup-scripts/wiki/Game-Profiles
    else
        echo "Invalid or no option given."
    fi
}

copy_game_profiles(){
    if test -f /home/$USER/.config/MangoHud/MangoHud.conf; then
        echo "MangoHud.conf exists. Not copying profiles over."
    elif ! test -f /home/$USER/.config/MangoHud/MangoHud.conf; then
        cd $SCRIPTS_FOLDER/data/game-profiles
        chown $USER:$USER *.conf
        cp *.conf $HOME/.config/MangoHud/
    fi
}

setup_game_profiles