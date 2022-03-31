#!/usr/bin/bash

raiderio(){
    # due to the cdn they use I can't download the appimage directly.
    mkdir /home/$USER/Apps/raiderio
    firefox https://raider.io/addon 
	#some reason scripts tend to crash the desktop session so I now run from tty which obviously cant open firefox
}
raiderio