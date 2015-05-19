#!/bin/bash
# (c) Andrey Streltsov <andrey@anse.me>
# (c) ANSE 18 May 2015


#export MXE_PATH=/opt/mxe


#export PREFIX=$MXE_PATH/usr/i686-w64-mingw32.shared
#export PKG_CONFIG_PATH=/usr/lib/pkgconfig/
#export PKG_CONFIG_PATH_686_w64_mingw32_shared=$PREFIX/lib/pkgconfig/
#export PATH=$MXE_PATH/usr/bin:$PREFIX/bin:$PATH


targetName=seafile-client
target_project_dir=win32

if [ ! -z $1 ] && [ $1 == "clean" ]; then
        echo "Cleaning" $targetName

        if [ -d "./$targetName/$target_project_dir" ]; then
                cd "./$targetName"
#		make uninstall
		rm -rf $target_project_dir
		cd ..
	fi
		
	if [ -d "./$targetName"  ]  && [ $2 == "--force" ]; then
                rm -rf  $targetName
        fi

        exit 0
fi


echo "Prepearing for building seafile-client..."

if [ ! -d "./$targetName" ]; then
        git clone https://github.com/andrey-str/${targetName}.git
fi

cd "./$targetName"

cd i18n

for old in *.ts; do mv $old `basename $old .ts`.qm; done

cd ..

if [ ! -d "./$target_project_dir" ]; then
	mkdir win32
fi

cd $target_project_dir

cmake .. -DCMAKE_TOOLCHAIN_FILE=$PREFIX/share/cmake/mxe-conf.cmake -DUSE_QT5=on -DQt5_DIR=$PREFIX/qt5/lib/cmake/Qt5 -DPKG_CONFIG_EXECUTABLE=$MXE_PATH/usr/bin/i686-w64-mingw32.shared-pkg-config

echo "Compiling " $targetName

make

make install
