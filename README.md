# setup-scripts
Set of scripts for installing several popular applications and drivers.

## Supported Distros
* Fedora 41/42 (non atomic)

## Requirements
* curl
* wget
* dnf-plugins-core
* flatpak
* flatseal         (flatpak)

Note: these will be installed automatically.

structure
-------------
* setup.sh            -       Main launch script. Always use this.
* modules/core        -       Core scripts. Everything needed to run is here.
* modules/packages    -       Commands for installing everything.
