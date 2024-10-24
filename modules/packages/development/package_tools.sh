#!/usr/bin/bash

install_package_tools(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y gcc-g++ autoconf automake bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace perf strace koji\
        mock redhat-rpm-config rpm-build rpmdevtools
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y automake gcc g++ bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace linux-perf strace\
        build-essential
    else
        echo "Unkown error has occurred."
    fi
}

install_package_tools
