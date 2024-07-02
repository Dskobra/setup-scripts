# setup-scripts
Set of scripts for installing several popular applications and drivers.

## Supported Distros
* Fedora 39/40 Workstation/Spins
* Fedora 39/40 Atomic Desktops
* Debian 12

## Requirements
* git
* curl
* wget
* zenity
* flatpak
* dnf   (fedora)
* dnf-plugins-core (fedora)

On first run setup.sh checks for the file ranonce.txt and if it doesn't exist it will install all the required packages
then create the file. Once the file is made future runs won't check for the prerequisite packages.

structure
-------------
setup.sh        -       Main launch script. Always use this.
packages.sh     -       Contains all the install commands.

data folder     -       When main script is run it pulls extra scripts and customization from the data branch.
