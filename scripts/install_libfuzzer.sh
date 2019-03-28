#!/usr/bin/env sh
set -e

TEMPDIR=$(mktemp -d)
(
    cd $TEMPDIR
    svn clone https://llvm.org/svn/llvm-project/compiler-rt/trunk/lib/fuzzer libfuzzer
    mkdir -p build-libfuzzer
    cd build-libfuzzer
    clang++ -std=c++11 -O2 -fPIC $SANITIZER_FLAGS -fno-sanitize=vptr \
	    -c ../libfuzzer/*.cpp -I../libfuzzer
    ar r /usr/local/lib/libFuzzingEngine.a *.o
)
rm -rf $TEMPDIR
