#!/usr/bin/env sh
set -e

TEMPDIR=$(mktemp -d)
(
    cd $TEMPDIR
    git clone --depth 1 https://github.com/google/libprotobuf-mutator.git LPM-SRC
    mkdir -p LPM-BUILD
    cd LPM-BUILD
    cmake ../LPM-SRC -GNinja -DLIB_PROTO_MUTATOR_DOWNLOAD_PROTOBUF=ON -DLIB_PROTO_MUTATOR_TESTING=OFF -DCMAKE_BUILD_TYPE=Release && DESTDIR=/usr/local/lib/ ninja install
)
rm -rf $TEMPDIR
