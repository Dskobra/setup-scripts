# setup-scripts
Set of scripts for installing several popular applications and drivers.

## Supported Distros
* Fedora (non atomic) 41/42

## Requirements
* curl
* wget
* dnf-plugins-core
* flatpak
* flatseal         (flatpak)

structure
-------------
* setup.sh            -       Main launch script. Always use this.
* modules/core        -       Core scripts. Everything needed to run is here.
* modules/packages    -       Commands for installing everything.
* modules/data        -       Launch scripts for some apps like wowup.
