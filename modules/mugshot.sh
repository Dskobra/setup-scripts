#!/usr/bin/bash
MUGSHOT_FOLDER="mugshot-0.4.3"
curl -L -o $MUGSHOT_FOLDER.tar.gz https://github.com/bluesabre/mugshot/releases/download/mugshot-0.4.3/mugshot-0.4.3.tar.gz
tar -xvf $MUGSHOT_FOLDER.tar.gz
cd $MUGSHOT_FOLDER
sudo dnf install typelib-1_0-Retro-1-0 clutter-gtk gst-devtools python3-gobject gdkpixbuf2
sudo python3 setup.py install
sudo mkdir /usr/local/share/glib-2.0/schemas
cd data/glib-2.0/schemas/
sudo cp org.bluesabre.mugshot.gschema.xml  /usr/local/share/glib-2.0/schemas
sudo glib-compile-schemas /usr/local/share/glib-2.0/schemas
