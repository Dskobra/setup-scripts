# setup-scripts
Set of scripts for installing several popular applications and drivers.

## Supported Distros
* Fedora (non atomic) 40/41
* openSUSE Tumbleweed 20251001+
* openSUSE Slowroll   20251001+

## Requirements
* curl
* wget
* flatpak
* flatseal         (flatpak)
* dnf-plugins-core (fedora)

On first run setup.sh checks for the file ranonce.txt and if it doesn't exist it will install all the required packages
then create the file. Once the file is made future runs won't check for the prerequisite packages.

structure
-------------
* setup.sh            -       Main launch script. Always use this.
* modules/core        -       Core scripts. Everything needed to run is here.
* modules/packages    -       Commands for installing everything.
* modules/misc        -       Scripts for setting permissions for libvirt and removing codecs on fedora.
