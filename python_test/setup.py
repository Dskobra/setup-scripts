import os
import subprocess
import getpass
def SETUP_STEAM():
    print("1. Package Manager 2. Flatpak (flathub)")
    userInput = input("Choose how you installed steam: ")
    if userInput == '1':
        #global STEAM_INSTALL_TYPE
        #global STEAM_PATH
        #STEAM_INSTALL_TYPE="distro"
        #STEAM_PATH=""
        temp1 = "//home//" # set the home part of location for concat later
        temp2 = getpass.getuser() # set to the login name of current user
        home_dir = temp1 + temp2 + "//" + ".steam//"
        print(home_dir)
        protonFolder = home_dir + "//compatibilitytools.d//"
        subprocess.call(["mkdir", protonFolder])
        subprocess.call(["tar", "-xvf", protonFolder])

    elif userInput == '2':
        #global STEAM_INSTALL_TYPE
        #global STEAM_PATH
        #STEAM_INSTALL_TYPE="flatpak"
        #STEAM_PATH=""
        temp1 = "//home//" # set the home part of location for concat later
        temp2 = getpass.getuser() # set to the login name of current user
        home_dir = temp1 + temp2 + "//" + "//.var//app//com.valvesoftware.Steam//data//Steam//"
        print(home_dir)
        protonFolder = home_dir + "//compatibilitytools.d//"
        subprocess.call(["mkdir", protonFolder])
        subprocess.call(["tar", "-xvf", protonFolder])
    else:
        print("error")
        quit()
SET_STEAM_PATH()