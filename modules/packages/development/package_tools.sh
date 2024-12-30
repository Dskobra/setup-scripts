#!/usr/bin/bash

native_package_tools(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y gcc-g++ autoconf automake bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace perf strace koji\
        mock redhat-rpm-config rpm-build rpmdevtools
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        sudo zypper -n install gcc-c++ autoconf automake bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace perf strace rpm-build\
        build inst-source-utils
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y automake gcc g++ bison flex libtool\
        m4 valgrind byacc ccache cscope indent ltrace linux-perf strace\
        build-essential
    else
        echo "Unkown error has occurred."
    fi
}

native_package_tools
