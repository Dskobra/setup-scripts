# setup-scripts
Set of scripts for installing several popular applications and drivers.

## Supported Distros
* Fedora 38/39 Workstation/Spins
* Fedora 38/39 Atomic Desktops
* Debian 12
* openSUSE Tumbleweed

## Requirements
* git
* curl
* zenity

setup.sh will check every run and install these if not present.

structure
-------------
setup.sh        -       Main launch script. Always use this.
packages.sh     -       Contains all the install commands.

data folder     -       When main script is run it pulls extra scripts and customizations from the data branch.

### Gnome variants
Some applications and shortcuts are created on the desktop. Gnome removed dekstop icon support sometime ago so you'll need an extension or move wowup and minecraft to another location. Other apps are installed under ~/.AppInstalls