#!/bin/bash
# (c) Andrey Streltsov <andrey@anse.me>
# (c) ANSE 19 May 2015

# prerequisites

SKIP_MXE=0

echo "Installing system-wide dependencies.."
sudo apt-get install libgsf-1-dev uuid-dev autoconf automake autopoint bash bison bzip2 cmake flex gettext git g++ gperf intltool libffi-dev libtool libltdl-dev libssl-dev libxml-parser-perl make openssl patch perl pkg-config python ruby scons sed unzip wget xz-utils g++-multilib libc6-dev-i386 valac gtk-doc-tools gobject-introspection 

CURRENT_DIR=`pwd`

if [ ! -d "dev" ]; then
        mkdir dev
fi

echo "Installing MXE.."
cd ~

cd dev

if [ -d "./mxe" ]; then
	rm -r mxe
fi

git clone http://github.com/mxe/mxe.git

echo "Will install MXE to /opt/mxe. Previous installation(if exists) will be moved to /opt/mxe.old 
Anykey to continue, CTRL+D/C for stop script execution"

read

if [ -d "/opt/mxe" ]; then
	echo ""
	sudo mv /opt/mxe /opt/mxe.old
fi

#sudo mv ./mxe /opt

cd /opt/mxe

# MXE compiler settings
cp $CURRENT_DIR/patches/settings.mk /opt/mxe

make download-qt5 download-glib download-jansson download-pthreads download-glib download-libevent download-curl download-jansson download-openssl download-sqlite download-libevent -j 4

if [ ! -e "/opt/mxe/src/qtwebkit-1.patch" ]; then
	echo "Adding qtwebkit patch to fix compilation error for shared target(bug exists on 19 May 2015)"
	cp $CURRENT_DIR/patches/qtwebkit-1.patch /opt/mxe/src/
fi

#make qt5 qtwebkit glib jansson pthreads glib libevent curl jansson openssl sqlite libevent


#exit 0
echo "Prepearing MSITOOLS packages.."

cd ~/dev

if [ -d "./msitools-0.93" ]; then
	rm -rf "./msitools-0.93"
fi

wget http://ftp.gnome.org/pub/GNOME/sources/msitools/0.93/msitools-0.93.tar.xz
tar xf msitools-0.93.tar.xz
rm msitools-0.93.tar.xz


if [ -d "./gcab" ]; then
        rm -rf "./gcab"
fi

git clone git://git.gnome.org/gcab


cd gcab
./autogen.sh
make && sudo make install

cd ../
cd msitools-0.93

./autogen.sh

./configure --prefix=$CURRENT_DIR/msitools
# Patching msitools failety makefiles...
rm Makefile.am
cp $CURRENT_DIR/patches/msitools/Makefile.am . 

rm tests/Makefile.in
cp $CURRENT_DIR/patches/msitools/tests/Makefile.am ./tests/


if [ -d "$CURRENT_DIR/msitools" ]; then
	rm -r "$CURRENT_DIR/msitools"
fi

mkdir -p $CURRENT_DIR/msitools

make && make install

# All is Done
echo "Should be Ready for Seafile-Client Building"


