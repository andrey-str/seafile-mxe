#!/bin/bash
# (c) Andrey Streltsov <andrey@anse.me>
# (c) ANSE 19 May 2015

DEPLOYMENT_PATH=deployment

DEPLOYMENT_TEST_ZIP=seafile-dist.zip

if [ ! -z $1 ] && [ $1 == "clean" ]; then
        echo "Cleaning deployment folder" 

        if [ -d "./$DEPLOYMENT_PATH"  ]
                rm -rf  $targetName
        fi

        if [ -e "./$DEPLOYMENT_TEST_ZIP" ]; then
        	rm -rf  $DEPLOYMENT_TEST_ZIP
        fi

        exit 0
fi

# Files to copy
files="$PREFIX/bin/icudt54.dll
$PREFIX/bin/icuin54.dll
$PREFIX/bin/icuuc54.dll
$PREFIX/bin/libbz2.dll
$PREFIX/bin/libccnet-0.dll
$PREFIX/bin/libcurl-4.dll
$PREFIX/bin/libeay32.dll
$PREFIX/bin/libevent-2-0-5.dll
$PREFIX/bin/libffi-6.dll
$PREFIX/bin/libfreetype-6.dll
$PREFIX/bin/libgcc_s_sjlj-1.dll
$PREFIX/bin/libgcrypt-20.dll
$PREFIX/bin/libglib-2.0-0.dll
$PREFIX/bin/libgmp-10.dll
$PREFIX/bin/libgnutls-28.dll
$PREFIX/bin/libgobject-2.0-0.dll
$PREFIX/bin/libgpg-error-0.dll
$PREFIX/bin/libharfbuzz-0.dll
$PREFIX/bin/libhogweed-2-4.dll
$PREFIX/bin/libiconv-2.dll
$PREFIX/bin/libidn-11.dll
$PREFIX/bin/libintl-8.dll
$PREFIX/bin/libjansson-4.dll
$PREFIX/bin/libnettle-4-6.dll
$PREFIX/bin/libpcre-1.dll
$PREFIX/bin/libpcre16-0.dll
$PREFIX/bin/libpng16-16.dll
$PREFIX/bin/libseafile-0.dll
$PREFIX/bin/libsearpc-1.dll
$PREFIX/bin/libsqlite3-0.dll
$PREFIX/bin/libssh2-1.dll
$PREFIX/bin/libstdc++-6.dll
$PREFIX/bin/libwinpthread-1.dll
$PREFIX/bin/ssleay32.dll
$PREFIX/bin/zlib1.dll
$PREFIX/bin/libjpeg-9.dll
$PREFIX/bin/ccnet.exe
$PREFIX/bin/seaf-daemon.exe
$PREFIX/bin/seafile-applet.exe
$PREFIX/qt5/bin/Qt5Core.dll
$PREFIX/qt5/bin/Qt5Gui.dll
$PREFIX/qt5/bin/Qt5Network.dll
$PREFIX/qt5/bin/Qt5Multimedia.dll
$PREFIX/qt5/bin/Qt5MultimediaWidgets.dll
$PREFIX/qt5/bin/Qt5PrintSupport.dll
$PREFIX/qt5/bin/Qt5OpenGL.dll
$PREFIX/qt5/bin/Qt5Qml.dll
$PREFIX/qt5/bin/Qt5Quick.dll
$PREFIX/qt5/bin/Qt5Sql.dll
$PREFIX/qt5/bin/Qt5WebKitWidgets.dll
$PREFIX/qt5/bin/Qt5WebKit.dll
$PREFIX/qt5/bin/Qt5Widgets.dll"

# directories to copy
dirs="$PREFIX/qt5/plugins/imageformats/
$PREFIX/qt5/plugins/platforms/"

#resource files directory
resources="./seafile-client/i18n/*.qm"



if [ -d "$DEPLOYMENT_PATH" ]; then
	rm -rf "$DEPLOYMENT_PATH"
fi

mkdir "$DEPLOYMENT_PATH"

for file in $files
do
	cp $file "$DEPLOYMENT_PATH/"
done

for dir in $dirs
do
	cp -r $dir "$DEPLOYMENT_PATH/"
done

cp $resources "$DEPLOYMENT_PATH/"

# prepeare installer ...

# test zipping

if [ -e "$DEPLOYMENT_TEST_ZIP" ]; then
	rm "$DEPLOYMENT_TEST_ZIP"
fi

zip -r $DEPLOYMENT_TEST_ZIP "$DEPLOYMENT_PATH"
