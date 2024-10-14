#!/bin/bash

set -e
cd /mongodb

python3 -m pip install -r etc/pip/compile-requirements.txt
python3 -m pip install requirements_parser jsonschema memory_profiler puremagic networkx cxxfilt

export GIT_PYTHON_REFRESH=quiet

./buildscripts/scons.py \
  MONGO_VERSION=$MONGO_VERSION \
  install-core \
  -j 6  \
  LINKFLAGS='-static-libstdc++' \
  CC="gcc-10" \
  CXX="g++-10" \
  CCFLAGS=-march=nehalem \
  --linker=gold

cd build/install/bin
strip mongos mongod
