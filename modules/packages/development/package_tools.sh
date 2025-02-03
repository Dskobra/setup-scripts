#!/usr/bin/bash

native_package_tools(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y gcc-g++ autoconf automake bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace perf strace koji\
        mock redhat-rpm-config rpm-build rpmdevtools
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install gcc-c++ autoconf automake bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace perf strace rpm-build\
        build inst-source-utils
    else
        echo "Unkown error has occurred."
    fi
}

native_package_tools
