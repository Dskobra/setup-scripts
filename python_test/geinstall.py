import proton71ge1
import subprocess
import os.path
import getpass

PROTONGELINK=""
PROTONGETARBALL=""
STEAM_INSTALL_TYPE=""
STEAM_PATH=""


def PROCESS_LINK():
    global PROTONGELINK
    global PROTONGETARBALL
    print(PROTONGELINK)
    link = PROTONGELINK
    start_pos = link.index("Proton")
    end_pos = len(link)
    PROTONGETARBALL = link[start_pos:end_pos]

def MENU():
    print("1. Steam 2. Lutris")
    userInput = input("Select an option: ")
    if userInput == '1':
        STEAM_MENU()
    elif userInput == '2':
        print("Placeholder")
    else:
        print("error")

def STEAM_MENU():
    print("1.Package Manager 2. Flatpak")
    userInput = input("Select your type of steam install: ")
    if userInput == '1':
        global STEAM_PATH
        temp1 = "//home//" # set the home part of location for concat later
        temp2 = getpass.getuser() # set to the login name of current user
        home_dir = temp1 + temp2 + "//" + ".steam"
        print(home_dir)
        STEAM_PATH = home_dir + "//compatibilitytools.d//"
        print(STEAM_PATH)
    elif userInput == '2':
        print("")
    else:
        print("error")

def WINGE_MENU():
    print("Placeholder")

def PROTON_MENU():
    print("Select Proton Version")
    print("1. Proton-7.1-GE-1 2. Proton-7.1-GE-1")
    print("0. Exit")

    userInput = input("Enter an option: ")
    if userInput == '1':
        global PROTONGELINK
        global PROTONGETARBALL
        from protonge import proton71ge2
        PROTONGELINK = proton71ge2()
        PROCESS_LINK()
        PROCESS_LINK
        subprocess.call(["tar", "-xvf", ""])
    elif userInput == '2':
        print("Placeholder")
    elif userInput == '0':
        quit()
    else:
        print(error)
        quit()
MENU()
