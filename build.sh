#!/usr/bin/env bash
# Copyright (C) 2021-2022  (@B4gol)
# CircleCI Kernel Build Script
###----------------------------------------###
# Main Environment
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/out/arch/arm/boot/zImage-dtb
ZIP_DIR=$KERNEL_DIR/AnyKernel
CONFIG_DIR=$KERNEL_DIR/arch/arm/configs
CONFIG=viper_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="$PWD/arm-gcc/bin/arm-linux-androideabi-"
CROSS_COMPILE_ARM32+="$PWD/arm-gcc/bin/arm-linux-androideabi-"
###----------------------------------------###
echo -e "\n(i) Cloning toolcahins if folder not exist..."
#git clone https://github.com/mvaisakh/gcc-arm64 --depth=1 ~/gcc64
#git clone https://github.com/mvaisakh/gcc-arm.git --depth=1 ~/gcc32
###----------------------------------------###
#git clone https://github.com/wulan17/prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9.git aarch64-gcc
git clone https://github.com/wulan17/prebuilts_gcc_linux-x86_arm-linux-androideabi-4.9.git arm-gcc
###----------------------------------------###
chmod a+x /home/travis/kernel/arm-linux-androideabi-4.9/bin/*
chmod a+x /home/travis/kernel/arm-gcc/libexec/gcc/arm-linux-androideabi/4.9.x/*
chmod a+x /home/travis/kernel/arm-gcc/libexec/gcc/arm-linux-androideabi/4.9.x/plugin/*
###----------------------------------------###
#cd $HOME/kernel && wget https://github.com/wulan17/android_kernel_xiaomi_cactus/commit/63623ef9ea9260810d10c2422d4548470a29f304.patch
#cd $HOME/kernel && git am < 63623ef9ea9260810d10c2422d4548470a29f304.patch
###----------------------------------------###
$HOME/build_kernel/telegram -M "Build Load...
Up : B4gol
Platform: sc8830
Model: SM-J320G
Product: j3xltedx
Tchains : ""$(gcc --version)""
Use : ""$(${CROSS_COMPILE}gcc --version | head -n 1)""
Date : ""$(env TZ=Asia/Jakarta date)"""
###----------------------------------------###
# Export
export ARCH=arm
export SUBARCH=arm
export PATH=usr/lib/ccache:$PATH
export CROSS_COMPILE
export CROSS_COMPILE_ARM32
export KBUILD_BUILD_USER=B4gol
export KBUILD_BUILD_HOST=Travis_CI
make O=out $CONFIG $THREAD