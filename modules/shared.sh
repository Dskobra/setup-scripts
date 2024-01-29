#!/usr/bin/bash

### packages that are manually installed such as appimages, tarballs etc.
wowup(){
    WOWUPLINK=https://github.com/WowUp/WowUp.CF/releases/download/v2.10.0/WowUp-CF-2.10.0.AppImage
    WOWUPBINARY=WowUp-CF-2.10.0.AppImage

    if test -f /home/$USER/Desktop/$WOWUPBINARY; then
        echo "WoWUp already downloaded."
    elif ! test -f /home/$USER/Desktop/$WOWUPBINARY; then
        cd "$HOME"/Desktop
        curl -L -o $WOWUPBINARY $WOWUPLINK 
        chmod +x $WOWUPBINARY
    fi
}

minecraft(){
    MINECRAFT_LINK=https://launcher.mojang.com/download/Minecraft.tar.gz
    MINECRAFT_ARCHIVE=Minecraft.tar.gz
    
    if test -f /home/$USER/Desktop/minecraft-launcher; then
        echo "Minecraft already downloaded."
    elif ! test -f /home/$USER/Desktop/minecraft-launcher; then
        cd $SCRIPTS_HOME/temp
        curl -L -o $MINECRAFT_ARCHIVE $MINECRAFT_LINK
        tar -xvf Minecraft.tar.gz
        cd minecraft-launcher
        chmod +x minecraft-launcher
        mv minecraft-launcher "$HOME"/Desktop
    fi
}

install_nodejs(){
    echo "This downloads the nvm or Node Version Manager script to install"
    echo "the latest nodejs long term support release."
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
}

install_eclipse(){
    cd $SCRIPTS_HOME/temp
    ECLIPSE="eclipse-inst-jre-linux64.tar.gz"
    curl -o $ECLIPSE https://eclipse.mirror.rafal.ca/oomph/epp/2023-09/R/eclipse-inst-jre-linux64.tar.gz

    tar -xvf $ECLIPSE
    ./eclipse-installer/eclipse-inst
}

install_idea(){
    IDEA_LINK=https://download.jetbrains.com/idea/ideaIC-2023.3.2.tar.gz
    IDEA_ARCHIVE=ideaIC-2023.3.2.tar.gz
    IDEA_OLD_FOLDER=idea-IC-233.13135.103
    IDEA_FOLDER=idea
    
    if test -d /opt/$IDEA_FOLDER; then
        echo "Intellij already downloaded."
    elif ! test -d /opt/$IDEA_FOLDER; then
        rm "$HOME/Desktop/idea"       # symlink gets put in idea folder if its present on desktop
        cd $SCRIPTS_HOME/temp
        curl -L -o $IDEA_ARCHIVE $IDEA_LINK
        tar -xvf $IDEA_ARCHIVE
        chmod +x $IDEA_OLD_FOLDER
        sudo mv $IDEA_OLD_FOLDER /opt/$IDEA_FOLDER
        ln -s "/opt/idea/bin/idea.sh" "$HOME/Desktop/idea"

    fi
}

install_netbeans(){
    NETBEANS_LINK=https://dlcdn.apache.org/netbeans/netbeans/20/netbeans-20-bin.zip
    NETBEANS_ARCHIVE=netbeans-20-bin.zip
    NETBEANS_FOLDER=netbeans
    
    if test -d /opt/$NETBEANS_FOLDER; then
        echo "Netbeans already downloaded."
    elif ! test -d /opt/$$NETBEANS_FOLDER; then
        rm "$HOME/Desktop/netbeans"       # symlink gets put in folder if its present on desktop
        cd $SCRIPTS_HOME/temp
        curl -L -o $NETBEANS_ARCHIVE $NETBEANS_LINK
        unzip $NETBEANS_ARCHIVE
        chmod +x $NETBEANS_FOLDER
        sudo mv $NETBEANS_FOLDER /opt/$NETBEANS_FOLDER
        ln -s "/opt/netbeans/bin/netbeans" "$HOME/Desktop/netbeans"

    fi
}

install_pycharm(){
    PYCHARM_LINK=https://download.jetbrains.com/python/pycharm-community-2023.3.2.tar.gz
    PYCHARM_ARCHIVE=pycharm-community-2023.3.2.tar.gz
    PYCHARM_OLD_FOLDER=pycharm-community-2023.3.2
    PYCHARM_FOLDER=pycharm
    
    if test -d /opt/$PYCHARM_FOLDER; then
        echo "Pycharm already downloaded."
    elif ! test -d /opt/$PYCHARM_FOLDER; then
        rm "$HOME/Desktop/pycharm"       # symlink gets put in pycharm folder if its present on desktop
        cd $SCRIPTS_HOME/temp
        curl -L -o $PYCHARM_ARCHIVE $PYCHARM_LINK
        tar -xvf $PYCHARM_ARCHIVE
        chmod +x $PYCHARM_OLD_FOLDER
        sudo mv $PYCHARM_OLD_FOLDER /opt/$PYCHARM_FOLDER
        ln -s "/opt/pycharm/bin/pycharm.sh" "$HOME/Desktop/pycharm"

    fi
}

### flatpak
fpk_repo(){
    echo "Setting up flathub for user"
    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

fpk_ktorrent(){
    flatpak install --user -y flathub org.kde.ktorrent
}

fpk_kdeokular(){
    flatpak install --user -y flathub org.kde.okular
}
        
fpk_konversation(){
    flatpak install --user -y flathub org.kde.konversation
}

fpk_kcalc(){
    flatpak install --user -y flathub org.kde.kcalc
}

fpk_kdedigikam(){
    flatpak install --user -y flathub org.kde.digikam
}

fpk_kdeelisa(){
    flatpak install --user -y flathub org.kde.elisa
}

fpk_kdegwenview(){
    flatpak install --user -y flathub org.kde.gwenview
}     

fpk_kdekamoso(){
    flatpak install --user -y flathub org.kde.kamoso
}    

fpk_kpaint(){
    flatpak install --user -y flathub org.kde.kolourpaint
}     
        
fpk_kontact(){
    flatpak install --user -y flathub org.kde.kontact
}

fpk_kpat(){
    flatpak install --user -y flathub org.kde.kpat
}

fpk_geany(){
    flatpak install --user -y flathub org.geany.Geany
}

fpk_transmission(){
    flatpak install --user -y flathub com.transmissionbt.Transmission
}

fpk_missioncenter(){
    flatpak install --user -y flathub io.missioncenter.MissionCenter
}

fpk_openshot(){
    flatpak install --user -y flathub org.openshot.OpenShot
}

fpk_bluefish(){
    flatpak install --user -y flathub nl.openoffice.bluefish
}

fpk_codeblocks(){
    flatpak install --user -y flathub org.codeblocks.codeblocks
}

fpk_steam(){
    flatpak install --user -y flathub com.valvesoftware.Steam
}

fpk_gamescope(){
    flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
}

fpk_fedora_mediawriter(){
    flatpak install --user -y flathub org.fedoraproject.MediaWriter
}

fpk_kdeisowriter(){
    flatpak install --user -y flathub org.kde.isoimagewriter
}

fpk_kleopatra(){
    flatpak install --user -y flathub org.kde.kleopatra
}