#!/usr/bin/bash
#fix encoding issues. I made this on windows and it keps defaulting to non unix line endings.

SCRIPTS_HOME=$(pwd)
dos2unix *
cd $SCRIPTS_HOME/modules
dos2unix *
cd $SCRIPTS_HOME/modules/mango_conf
dos2unix *