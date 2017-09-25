#!/bin/bash

NPROC="-j$(grep -c processor /proc/cpuinfo)"
PREFIX="--prefix=/usr/local"

# Update CentOS Base Repository to vault
sed "s/\/mirror\.centos\.org\/centos/\/vault\.centos\.org/g;\
s/^#baseurl/baseurl/g;\
s/^mirrorlist/#mirrorlist/g;\
s/\$releasever/5\.11/g" /etc/yum.repos.d/CentOS-Base.repo -i.bak

#Dev Tools Repository
wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo --no-check-certificate

yum -y update
yum -y install epel-release
yum -y install\
  devtoolset-2\
  python26\
  git-core\
  flex\
  bison\
  gperf\
  fontconfig-devel\
  freetype-devel\
  libX11-devel\
  libXau-devel\
  libXext-devel\
  libXrender-devel\
  libpng-devel\
  libjpeg-devel

echo -e "\n#Load Dev Toolset\nsource /opt/rh/devtoolset-2/enable" >> ~/.bashrc
source /opt/rh/devtoolset-2/enable

wget http://www.cpan.org/src/5.0/perl-5.24.1.tar.gz --no-check-certificate
wget https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz --no-check-certificate
wget https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.gz --no-check-certificate
wget https://sqlite.org/2017/sqlite-autoconf-3180000.tar.gz --no-check-certificate

tar xf perl-5.24.1.tar.gz
tar xf Python-2.7.13.tgz
tar xf ruby-2.4.1.tar.gz

cd perl-5.24.1
./configure.gnu $PREFIX
make $NPROC
make install
cd ..

cd Python-2.7.13
./configure $PREFIX
make $NPROC
make install
cd ..

cd ruby-2.4.1
./configure $PREFIX
make $NPROC
make install
cd ..

tar xf sqlite-autoconf-3180000.tar.gz
cd sqlite-autoconf-3180000
./configure $PREFIX --enable-threadsafe
make $NPROC
make install
rm -f /usr/local/lib/libsqlite3.la
rm -f /usr/local/lib/libsqlite3.so*
cd ..

