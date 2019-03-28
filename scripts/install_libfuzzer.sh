#!/usr/bin/env sh
set -e
TEMPDIR=$(mktemp -d)
(
    cd $TEMPDIR
    svn co https://llvm.org/svn/llvm-project/compiler-rt/trunk/lib/fuzzer libfuzzer
    mkdir -p build-libfuzzer
    cd build-libfuzzer
    CXXFLAGS="-O1 -fno-omit-frame-pointer -gline-tables-only -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -fsanitize=address -fsanitize-address-use-after-scope -fsanitize=fuzzer-no-link -stdlib=libc++ -L/usr/lib/x86_64-linux-gnu"
    $CXX $CXXFLAGS -std=c++11 -fPIC -fno-sanitize=vptr -c ../libfuzzer/*.cpp -I../libfuzzer
    ar r /usr/lib/libFuzzingEngine.a *.o
)
rm -rf $TEMPDIR
