import subprocess
import os.path
import getpass

PROTONGELINK=""
PROTONGETARBALL=""
STEAM_INSTALL_TYPE=""
PROTON_PATH=""
PROTON_TYPE=""


def PROCESS_LINK():
    global PROTONGELINK
    global PROTONGETARBALL
    global PROTON_TYPE
    print(PROTONGELINK)
    link = PROTONGELINK
    #start_pos = link.index("Proton")
    start_pos = link.index(PROTON_TYPE)
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
    global PROTON_PATH
    global PROTON_TYPE
    PROTON_TYPE="wine"
    print("This is not done yet.")
    print("Select WineGE Version")
    print("722 Wine-7.2-GE-2")
    print("721. Wine-7.2-GE-1  711. Wine-7.1-GE-1")
    print("0. Exit")

    temp1 = "/home/" # set the home part of location for concat later
    temp2 = getpass.getuser() # set to the login name of current user
    home_dir = temp1 + temp2 + "/.local/share/lutris/runners/wine/"
    PROTON_PATH = home_dir
    #subprocess.call(["mkdir -p", PROTON_PATH])
    
    userInput = input("Enter an option: ")
    if userInput == '722':
        from winege import winge722
        #winge722()
        print(userInput)
        print("Placeholder")
    elif userInput == '721':
        from winege import winge721
        #winge721()
        print(userInput)
        print("Placeholder")
    elif userInput == '2':
        print(userInput)
        print("Placeholder")
    else:
        print("error")

def PROTONGE_MENU():
    global PROTONGELINK
    global PROTONGETARBALL
    global PROTON_TYPE
    PROTON_TYPE="Proton"
    print("Select Proton Version")
    print("722 Proton-7.2-GE-2 721. Proton-7.2-GE-1")
    print("712. Proton-7.1-GE-2 711. Proton-7.1-GE-1")
    print ("7061. Proton-7.0rc6-GE-1")
    print("0. Exit")

    userInput = input("Enter an option: ")
    if userInput == '722':
        from protonge import protonge722
        PROTONGELINK = protonge722()
        PROCESS_LINK()
        SETUP_PROTON()
    elif userInput == '721':
        from protonge import protonge721
        PROTONGELINK = protonge721()
        PROCESS_LINK()
        SETUP_PROTON()
    elif userInput == '712':
        from protonge import protonge712
        PROTONGELINK = protonge712()
        PROCESS_LINK()
        SETUP_PROTON()
    elif userInput == '711':
        from protonge import protonge711
        PROTONGELINK = protonge711()
        PROCESS_LINK()
        SETUP_PROTON()
    elif userInput == '7061':
        from protonge import protonge70rc61
        PROTONGELINK = protonge70rc61()
        PROCESS_LINK()
        SETUP_PROTON()
    elif userInput == '0':
        quit()
    else:
        print(error)
        quit()
MENU()
