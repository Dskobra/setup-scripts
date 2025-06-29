#!/usr/bin/bash

native_codecs(){
    opi -n codecs
    echo "1" > "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/codecs.txt
}

CODECS_INSTALLED="$(cat < "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/codecs.txt)"


if [ "$CODECS_INSTALLED" == "0" ]
then
    native_codecs
else
    echo "Codecs already installed."
fi
