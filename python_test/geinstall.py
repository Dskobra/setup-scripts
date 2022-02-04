import subprocess
import os.path
import getpass

PROTONGELINK=""
PROTONGETARBALL=""
STEAM_INSTALL_TYPE=""
PROTON_PATH=""


def PROCESS_LINK():
    global PROTONGELINK
    global PROTONGETARBALL
    print(PROTONGELINK)
    link = PROTONGELINK
    start_pos = link.index("Proton")
    end_pos = len(link)
    PROTONGETARBALL = link[start_pos:end_pos]
    print(PROTONGETARBALL)

def SETUP_PROTON():
    global PROTONGELINK
    global PROTONGETARBALL
    subprocess.call(["wget", PROTONGELINK])
    subprocess.call(["tar", "-xvf", PROTONGETARBALL, "-C", PROTON_PATH])
    subprocess.call(["rm", PROTONGETARBALL])

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
    global PROTON_PATH
    print("1.Package Manager 2. Flatpak")
    userInput = input("Select your type of steam install: ")
    if userInput == '1':
        temp1 = "/home/" # set the home part of location for concat later
        temp2 = getpass.getuser() # set to the login name of current user
        home_dir = temp1 + temp2 + "/.steam"
        PROTON_PATH = home_dir + "/compatibilitytools.d/"
        subprocess.call(["mkdir", PROTON_PATH])
        PROTONGE_MENU()
    elif userInput == '2':
        temp1 = "/home/" # set the home part of location for concat later
        temp2 = getpass.getuser() # set to the login name of current user
        home_dir = temp1 + temp2 + "/.var/app/com.valvesoftware.Steam/data/Steam"
        PROTON_PATH = home_dir + "/compatibilitytools.d/"
        subprocess.call(["mkdir", PROTON_PATH])
        PROTONGE_MENU()
    else:
        print("error")

def WINGE_MENU():
    print("This is not done yet.")
    print("Select WineGE Version")
    print("1. Wine-7.1-GE-1 2. Wine-7.0rc3-GE-1")
    print("3. Wine-7.0rc2-GE-1")
    print("0. Exit")

def PROTONGE_MENU():
    global PROTONGELINK
    global PROTONGETARBALL
    print("Select Proton Version")
    print("1. Proton-7.1-GE-1 2. Proton-7.1-GE-1")
    print ("3. Proton-7.0rc6-GE-1")
    print("0. Exit")

    userInput = input("Enter an option: ")
    if userInput == '1':
        from protonge import proton71ge2
        PROTONGELINK = proton71ge2()
        PROCESS_LINK()
        SETUP_PROTON()
    elif userInput == '2':
        from protonge import proton71ge1
        PROTONGELINK = proton71ge1()
        PROCESS_LINK()
        SETUP_PROTON()
    elif userInput == '3':
        from protonge import proton70rc6ge1
        PROTONGELINK = proton70rc6ge1()
        PROCESS_LINK()
        SETUP_PROTON()
    elif userInput == '0':
        quit()
    else:
        print(error)
        quit()
MENU()
