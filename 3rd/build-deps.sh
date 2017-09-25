#!/bin/bash

NPROC="-j$(grep -c processor /proc/cpuinfo)"
PREFIX="--prefix=/usr/local"

source /opt/rh/devtoolset-2/enable

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

wget http://xcb.freedesktop.org/dist/xcb-proto-1.12.tar.gz --no-check-certificate
wget http://xcb.freedesktop.org/dist/libpthread-stubs-0.4.tar.gz --no-check-certificate
wget http://xcb.freedesktop.org/dist/libxcb-1.12.tar.gz --no-check-certificate
wget http://download.icu-project.org/files/icu4c/58.2/icu4c-58_2-src.tgz --no-check-certificate
wget https://github.com/openssl/openssl/archive/OpenSSL_1_0_2-stable.zip -O OpenSSL_1_0_2-stable.zip --no-check-certificate

tar xf xcb-proto-1.12.tar.gz
cd xcb-proto-1.12
./configure $PREFIX
make
make install
cd ..

tar xf libpthread-stubs-0.4.tar.gz
cd libpthread-stubs-0.4
./configure $PREFIX
make
make install
cd ..

tar xf libxcb-1.12.tar.gz
./configure $PREFIX
make $NPROC
make install
cd ..

tar xf icu4c-58_2-src.tgz
cd icu/source
./configure $PREFIX --enable-static
make $NPROC
make install
cd ../..

# QtWebkit won't build static if icu is found by pkg-config
mkdir /usr/local/lib/pkgconfig_icu
mv /usr/local/lib/pkgconfig/icu-*.pc /usr/local/lib/pkgconfig_icu

unzip OpenSSL_1_0_2-stable.zip
cd openssl-OpenSSL_1_0_2-stable
./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl
make $NPROC
make install
cd ..

