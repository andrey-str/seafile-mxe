#!/bin/bash
# (c) Andrey Streltsov <andrey@anse.me>
# (c) ANSE 18 May 2015

if [ ! -z $1 ] && [ $1 == "clean" ]; then
	echo "Cleaning up existing installation"
	bash build_dependency.sh libsearpc clean $2
	bash build_dependency.sh ccnet clean $2
	bash build_dependency.sh seafile clean $2
	bash build_client.sh clean $2
	bash deploy.sh clean $2	
	
	exit 0
fi


echo "Prepearing for building dependency libraries"
echo "Setting up environement.."

unset `env | \
    grep -vi '^EDITOR=\|^HOME=\|^LANG=\|MXE\|^PATH=' | \
    grep -vi 'PKG_CONFIG\|PROXY\|^PS1=\|^TERM=' | \
    cut -d '=' -f1 | tr '\n' ' '`

export MXE_PATH=/opt/mxe


export PREFIX=$MXE_PATH/usr/i686-w64-mingw32.shared
export PKG_CONFIG_PATH=/usr/lib/pkgconfig/
export PKG_CONFIG_PATH_i686_w64_mingw32_shared=$PREFIX/lib/pkgconfig/
export PATH=$MXE_PATH/usr/bin:$PREFIX/bin:$PATH

export PKG_CONFIG_BIN_i686_w64_mingw32_shared=i686-w64-mingw32.shared-pkg-config

bash build_dependency.sh libsearpc
bash build_dependency.sh ccnet
bash build_dependency.sh seafile

bash build_client.sh
bash deploy.sh
