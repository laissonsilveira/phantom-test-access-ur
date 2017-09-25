#!/bin/bash

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

if [ ! -d "./phantomjs" ]; then
  git clone -b 2.1.1 git://github.com/ariya/phantomjs.git
  cd phantomjs
  git submodule init
  git submodule update
  cd..
fi

cd phantomjs

if [ ! -f "./build.py.bkp" ]; then

  cp build.py build.py.bkp

  LNEDIT=$(awk '/-no-audio-backend/{print NR+1}' build.py)
  sed -i ''$((LNEDIT+1))'i \ \ \ \ \ \ \ \ \ \ \ \ "-I", "/usr/local/include",' build.py
  sed -i ''$((LNEDIT+2))'i \ \ \ \ \ \ \ \ \ \ \ \ "-I", "/usr/local/ssl/include",' build.py
  sed -i ''$((LNEDIT+3))'i \ \ \ \ \ \ \ \ \ \ \ \ "-L", "/usr/local/lib",' build.py
  sed -i ''$((LNEDIT+4))'i \ \ \ \ \ \ \ \ \ \ \ \ "-L", "/usr/local/ssl/lib",' build.py
  sed -i ''$((LNEDIT+5))'i \ \ \ \ \ \ \ \ \ \ \ \ "-D", "FC_WEIGHT_EXTRABLACK=215",' build.py
  sed -i ''$((LNEDIT+6))'i \ \ \ \ \ \ \ \ \ \ \ \ "-D", "FC_WEIGHT_ULTRABLACK=215",' build.py
  sed -i ''$((LNEDIT+7))'i \ \ \ \ \ \ \ \ \ \ \ \ "-D", "U_STATIC_IMPLEMENTATION",' build.py

  LNEDIT=$(awk '/build_webkit2/{print NR-1}' build.py)
  sed -i ''$((LNEDIT))'i \ \ \ \ \ \ \ \ \ \ \ \ "QMAKE_LFLAGS+=-static",' build.py
  sed -i ''$((LNEDIT))'i \ \ \ \ \ \ \ \ \ \ \ \ "DEFINES+=U_STATIC_IMPLEMENTATION",' build.py

  sed -i 's/#define QTESTLIB_USE_PERF_EVENTS/#undef QTESTLIB_USE_PERF_EVENTS/g' src/qt/qtbase/src/testlib/qbenchmark_p.h
fi

python build.py -c
