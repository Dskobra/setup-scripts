#!/usr/bin/bash

minecraft(){
	cd /home/$USER/Games
	wget https://launcher.mojang.com/download/Minecraft.tar.gz
	tar -xvf Minecraft.tar.gz
	rm Minecraft.tar.gz
}

minecraft
