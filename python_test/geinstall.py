import subprocess
import os.path
import getpass

GELINK=""
GETARBALL=""
STEAM_INSTALL_TYPE=""
GE_PATH=""
GE_TYPE=""


def PROCESS_LINK():
    global GELINK
    global GETARBALL
    global GE_TYPE
    print(GELINK)
    link = GELINK
    #start_pos = link.index("Proton")
    start_pos = link.index(GE_TYPE)
    end_pos = len(link)
    GETARBALL = link[start_pos:end_pos]

def SETUP_GE():
    global GELINK
    global GETARBALL
    global GE_PATH
    subprocess.call(["wget", GELINK])
    subprocess.call(["tar", "-xvf", GETARBALL, "-C", GE_PATH])
    subprocess.call(["rm", GETARBALL])

def MENU():
    print("1. Steam 2. Lutris")
    userInput = input("Select an option: ")
    if userInput == '1':
        STEAM_MENU()
    elif userInput == '2':
        WINGE_MENU()
    else:
        print("error")

def STEAM_MENU():
    global GE_PATH
    print("1.Package Manager 2. Flatpak")
    userInput = input("Select your type of steam install: ")
    if userInput == '1':
        temp1 = "/home/" # set the home part of location for concat later
        temp2 = getpass.getuser() # set to the login name of current user
        home_dir = temp1 + temp2 + "/.steam/steam"
        GE_PATH = home_dir + "/compatibilitytools.d/"
        subprocess.call(["mkdir", GE_PATH])
        PROTONGE_MENU()
    elif userInput == '2':
        temp1 = "/home/" # set the home part of location for concat later
        temp2 = getpass.getuser() # set to the login name of current user
        home_dir = temp1 + temp2 + "/.var/app/com.valvesoftware.Steam/data/Steam"
        GE_PATH = home_dir + "/compatibilitytools.d/"
        subprocess.call(["mkdir", GE_PATH])
        PROTONGE_MENU()
    else:
        print("error")

def WINGE_MENU():
    global GELINK
    global GETARBALL
    global GE_TYPE
    global GE_PATH
    GE_TYPE="wine-lutris"
    print("Select WineGE Version")
    print("722 Wine-7.2-GE-2")
    print("721. Wine-7.2-GE-1  711. Wine-7.1-GE-1")
    print("0. Exit")

    temp1 = "/home/" # set the home part of location for concat later
    temp2 = getpass.getuser() # set to the login name of current user
    home_dir = temp1 + temp2 + "/.local/share/lutris/runners/wine/"
    GE_PATH = home_dir
    subprocess.call(["mkdir", GE_PATH])
    
    userInput = input("Enter an option: ")
    if userInput == '722':
        from winege import winege722
        GELINK = winege722()
        print(GELINK)
        PROCESS_LINK()
        SETUP_GE()
    elif userInput == '721':
        from winege import winege721
        GELINK = winege721()
        print(GELINK)
        PROCESS_LINK()
        SETUP_GE()
    elif userInput == '711':
        from winege import winege711
        GELINK = winege711()
        PROCESS_LINK()
        SETUP_GE()
    elif userInput == '2':
        print(userInput)
        print("Placeholder")
    else:
        print("error")

def PROTONGE_MENU():
    global GELINK
    global GETARBALL
    global GE_TYPE
    GE_TYPE="Proton"
    print("Select Proton Version")
    print("722 Proton-7.2-GE-2 721. Proton-7.2-GE-1")
    print("712. Proton-7.1-GE-2 711. Proton-7.1-GE-1")
    print ("7061. Proton-7.0rc6-GE-1")
    print("0. Exit")

    userInput = input("Enter an option: ")
    if userInput == '722':
        from protonge import protonge722
        GELINK = protonge722()
        PROCESS_LINK()
        SETUP_GE()
    elif userInput == '721':
        from protonge import protonge721
        GELINK = protonge721()
        PROCESS_LINK()
        SETUP_GE()
    elif userInput == '712':
        from protonge import protonge712
        GELINK = protonge712()
        PROCESS_LINK()
        SETUP_GE()
    elif userInput == '711':
        from protonge import protonge711
        GELINK = protonge711()
        PROCESS_LINK()
        SETUP_GE()
    elif userInput == '7061':
        from protonge import protonge70rc61
        GELINK = protonge70rc61()
        PROCESS_LINK()
        SETUP_GE()
    elif userInput == '0':
        quit()
    else:
        print(error)
        quit()
MENU()
