#!/usr/bin/env sh
set -e

TEMPDIR=$(mktemp -d)
(
    cd $TEMPDIR
    svn co https://llvm.org/svn/llvm-project/compiler-rt/trunk/lib/fuzzer libfuzzer
    mkdir -p build-libfuzzer
    cd build-libfuzzer
    $CXX -O1 -fno-omit-frame-pointer -gline-tables-only -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -stdlib=libc++ -std=c++11 -fPIC -fsanitize=address -fsanitize-address-use-after-scope -fno-sanitize=vptr -c ../libfuzzer/*.cpp -I../libfuzzer
    ar r /usr/local/lib/libFuzzingEngine.a *.o
)
rm -rf $TEMPDIR
