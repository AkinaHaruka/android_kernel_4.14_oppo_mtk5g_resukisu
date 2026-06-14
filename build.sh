#!/bin/bash

CLANG_DIR="$PWD/toolchains/clang"
GCC64_DIR="$PWD/toolchains/gcc64"
export PATH="$CLANG_DIR/bin:$GCC64_DIR/bin:$PATH"

export ARCH=arm64
export CLANG_PREBUILT_BIN=$CLANG_DIR/bin
export LINUX_GCC_CROSS_COMPILE_PREBUILTS_BIN=$GCC64_DIR/bin
export KCFLAGS="-fno-builtin-stpcpy -Wno-error=pointer-to-int-cast -Wno-pointer-to-int-cast -Wno-strict-prototypes -Wno-error=strict-prototypes"

make -j$(nproc) O=out \
    CC=clang \
    LD=ld.lld \
    LD_LIBRARY_PATH=$CLANG_DIR/lib64:$LD_LIBRARY_PATH \
    AR=llvm-ar \
    NM=llvm-nm \
    OBJCOPY=llvm-objcopy \
    OBJDUMP=llvm-objdump \
    STRIP=llvm-strip \
    CLANG_TRIPLE=aarch64-linux-gnu- \
    CROSS_COMPILE=aarch64-linux-androidkernel-