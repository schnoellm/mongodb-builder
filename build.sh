#!/bin/bash

cd /mongodb
pip3 install -r etc/pip/compile-requirements.txt
./buildscripts/scons.py mongod mongo --ssl=off --enable-free-mon=off
strip mongo mongod
