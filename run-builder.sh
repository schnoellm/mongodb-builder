#!/bin/bash
set -e

MONGODB_VERSION='6.0.18'
SRC="mongo-r$MONGODB_VERSION"
TARGET="mongodb-linux-x86_64-${MONGODB_VERSION}"
BIN="$TARGET/bin"

[ ! -d $SRC ] && curl -L "https://github.com/mongodb/mongo/archive/refs/tags/r$MONGODB_VERSION.tar.gz" | tar -xz
docker run --memory=16g --rm -it -v $(pwd)/$SRC:/mongodb -e "MONGO_VERSION=$MONGODB_VERSION" mongodb-builder
mkdir -p $BIN
sudo mv "$SRC/build/install/bin/mongos" "$SRC/build/install/bin/mongod" $BIN
sudo tar -czf "$TARGET.tgz" $TARGET
