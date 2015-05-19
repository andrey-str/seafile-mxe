
## Set of scripts for building seafile client for Windows (seafile.com)


### Dependencies

*Tested on Ubuntu Server 14.04LTS*

1. System-wide dependencies

To start you'll need to prepeare your system first.
Here is the list of system-wide requirements: 

* libgsf-1-dev 
* uuid-dev 
* autoconf 
* automake 
* autopoint 
* bash 
* bison 
* bzip2 
* cmake 
* flex 
* gettext 
* git 
* g++ 
* gperf 
* intltool 
* libffi-dev 
* libtool 
* libltdl-dev 
* libssl-dev 
* libxml-parser-perl 
* make 
* openssl 
* patch 
* perl 
* pkg-config 
* python 
* ruby 
* scons 
* sed 
* unzip 
* wget 
* xz-utils 
* g++-multilib 
* libc6-dev-i386 valac 
* gtk-doc-tools 
* gobject-introspection


2. [MXE toolchain](http://github.com/mxe/mxe.git)
3. [msitools](https://wiki.gnome.org/msitools)

Use msitools-0.93 from distribution

#### This repo contains script called prep.sh which do all described above

### Building and installation

Simply run build.sh and you should get deployment.msi on the script exit.


build.sh can take arguments:

* build.sh clean will clean targets and uninstall packages installed with pkg-config
* build.sh clean --force also will delete sources directories(ccnet, libsearpc, seafile and seafile-client)



