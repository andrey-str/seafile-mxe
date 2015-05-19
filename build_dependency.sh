#!/bin/bash
# (c) Andrey Streltsov <andrey@anse.me>
# (c) ANSE 18 May 2015

#export MXE_PATH=/opt/mxe


#export PREFIX=$MXE_PATH/usr/i686-w64-mingw32.shared
#export PKG_CONFIG_PATH=/usr/lib/pkgconfig/
#export PKG_CONFIG_PATH_i686_w64_mingw32_shared=$PREFIX/lib/pkgconfig/
#export PATH=$MXE_PATH/usr/bin:$PREFIX/bin:$PATH


dependencyName=$1

if [ ! -z $2 ] && [ $2 == "clean" ]; then
	echo "Cleaning dependency:" $dependencyName
	
	if [ -d "./$dependencyName" ]; then
		cd ./$dependencyName
		if [ -e "Makefile" ]; then
			make uninstall
			make clean
			make distclean
		fi

		if [ -e "configure" ]; then
			rm configure
		fi

		cd ../
	fi			

	pkg_config_name=$dependencyName
	
	i686-w64-mingw32.shared-pkg-config --exists $pkg_config_name
	found=`echo $?`

	if [ $found -eq "1" ]; then
        	pkg_config_name=lib$dependencyName
        	i686-w64-mingw32.shared-pkg-config --exists $pkg_config_name
        	found=`echo $?`
	fi

	if [ $found -eq "0" ]; then
		echo "Removing pkg-info file.. " $pkg_config_name.pc
		rm $PKG_CONFIG_PATH_i686_w64_mingw32_shared/$pkg_config_name.pc
	fi
	
	if [ -d $dependencyName  ] && [ $3 == "--force" ]; then
		rm -rf  $dependencyName
	fi
	exit 0
fi	

pkg_config_name=$dependencyName
i686-w64-mingw32.shared-pkg-config --exists $pkg_config_name
found=`echo $?`

if [ $found -eq "1" ]; then
	pkg_config_name=lib$dependencyName
	i686-w64-mingw32.shared-pkg-config --exists $pkg_config_name
	found=`echo $?`
fi

if [ $found -eq "0" ]; then
	echo $dependencyName " found version " `i686-w64-mingw32.shared-pkg-config --modversion $pkg_config_name`
	exit 0
fi



if [ ! -d "./$dependencyName" ]; then
	git clone https://github.com/andrey-str/$dependencyName.git
fi

cd "./$dependencyName"

if [ ! -e "./configure" ]; then
	./autogen.sh
fi

echo "-------Configuring dependency..."

./configure --host=i686-w64-mingw32.shared --prefix=$PREFIX

echo "--------Compiling dependency: " $dependencyName
make && make install


