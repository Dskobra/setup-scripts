#!/usr/bin/bash

wine_repo(){
	source /etc/os-release
	getRelease=$(echo $VERSION_ID)
	echo "Fedora Version:" $getRelease

	if [ "$getRelease" = "35" ]
	then
		sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/35/winehq.repo
	elif [ "$getRelease" = "36" ]
	then
		sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/36/winehq.repo
	elif [ "$getRelease" = "37" ]
	then
		# temporarily use fedora 36 winehq repo on fedora 36. change when one for 36 is released.
		sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/36/winehq.repo
	elif [ $input -eq 0 ]
	then
		exit
	else
		echo "error."
	fi
}
winedeps(){
	echo "Installing various wine deps."
    sudo dnf install -y alsa-plugins-pulseaudio.i686 glibc-devel.i686 glibc-devel libgcc.i686 libX11-devel.i686 freetype-devel.i686
    sudo dnf install -y libXcursor-devel.i686 libXi-devel.i686 libXext-devel.i686 libXxf86vm-devel.i686 libXrandr-devel.i686
    sudo dnf install -y libXinerama-devel.i686 mesa-libGLU-devel.i686 mesa-libOSMesa-devel.i686 libXrender-devel.i686 libpcap-devel.i686
    sudo dnf install -y ncurses-devel.i686 libzip-devel.i686 lcms2-devel.i686 zlib-devel.i686 libv4l-devel.i686 libgphoto2-devel.i686
    sudo dnf install -y cups-devel.i686 libxml2-devel.i686 openldap-devel.i686 libxslt-devel.i686 gnutls-devel.i686 libpng-devel.i686
    sudo dnf install -y flac-libs.i686 json-c.i686 libICE.i686 libSM.i686 libXtst.i686 libasyncns.i686 libedit.i686
    sudo dnf install -y liberation-narrow-fonts.noarch libieee1284.i686 libogg.i686 libsndfile.i686 libuuid.i686 libva.i686 libvorbis.i686
    sudo dnf install -y libwayland-client.i686 libwayland-server.i686 llvm-libs.i686 mesa-dri-drivers.i686 mesa-filesystem.i686 mesa-libEGL.i686
    sudo dnf install -y mesa-libgbm.i686 nss-mdns.i686 ocl-icd.i686 pulseaudio-libs.i686  sane-backends-libs.i686 tcp_wrappers-libs.i686 unixODBC.i686
    sudo dnf install -y samba-common-tools.x86_64 samba-libs.x86_64 samba-winbind.x86_64
    sudo dnf install -y samba-winbind-clients.x86_64 samba-winbind-modules.x86_64 mesa-libGL-devel.i686 fontconfig-devel.i686 libXcomposite-devel.i686
    sudo dnf install -y libtiff-devel.i686 openal-soft-devel.i686 mesa-libOpenCL-devel.i686 opencl-utils-devel.i686 alsa-lib-devel.i686 gsm-devel.i686
    sudo dnf install -y libjpeg-turbo-devel.i686 pulseaudio-libs-devel.i686 pulseaudio-libs-devel gtk3-devel.i686 libattr-devel.i686 libva-devel.i686
    sudo dnf install -y libexif-devel.i686 libexif.i686 glib2-devel.i686 mpg123-devel.i686 mpg123-devel.x86_64 libcom_err-devel.i686
    sudo dnf install -y libcom_err-devel.x86_64 libFAudio-devel.i686 libFAudio-devel.x86_64
    sudo dnf install -y gnutls.i686 gnutls-devel openldap openldap.i686
	sudo dnf install -y openldap-devel libgpg-error libgpg-error.i686 sqlite2.i686 sqlite2.x86_64
	sudo dnf install -y pipewire-devel.i686 pipewire-devel.x86_64 gstreamer1*.i686 gstreamer1*.x86_64
	sudo dnf install -y freetype.i686 gnutls.i686 openldap.i686 libgpg-error.i686 sqlite2.i686 pulseaudio-libs.i686
	sudo dnf install -y dxvk-native-devel.x86_64 dxvk-native-devel.i686 vulkan-tools
    sudo dnf install -y winehq-staging
}


wine_repo
winedeps
