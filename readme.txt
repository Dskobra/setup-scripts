These are my scripts to automate setting up Fedora.

#folder layout
root
    33
    shared
    extras


*repos/commands that are independent of distro version are placed in shared. Example installing winehq you run the command for your release where as rpmfusion there's a simple command to check your release and install the appropriate version for you. Flatpak is also placed here as it just adds their storefront which is independent of the distro.

*Important scripts in root directory
    setup.sh - launch script
    34.sh - launches fedora 34 versions of scripts.
    33.sh - launches fedora 33 versions of scripts.

#extra scripts

# these are scripts not automated by the setup scripts.
extras
    eggroll.sh - downloads and adds gloriouseggroll version of proton to steam. Have to run steam first to create the profile. Script checks if steam profile exists then exits if it doesn't.
