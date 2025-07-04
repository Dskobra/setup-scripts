# setup-scripts
Set of scripts for installing several popular applications and drivers.

## Supported Distros
* Fedora 41/42 (non atomic)
* openSUSE Slowroll snapshot from 05/01/2025 or later

## Requirements
* curl
* wget
* flatpak
* dnf-plugins-core (fedora)
* opi              (opensuse)
* flatseal         (flatpak)

Note: these will be installed automatically.

structure
-------------
* setup.sh            -       Main launch script. Always use this.
* modules/core        -       Core scripts. Everything needed to run is here.
* modules/packages    -       Commands for installing everything.
