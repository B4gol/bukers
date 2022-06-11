# Main Environment
export FACTOR=$PWD
ZIP_DIR=$FACTOR/AnyKernel
CONFIG_DIR=$FACTOR/kernel/arch/arm/configs
CONFIG=viper_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="gcc64/bin/aarch64-linux-android-"
CROSS_COMPILE_ARM32+="gcc32/bin/arm-linux-androideabi-"
CROSSC=aarch64-linux-android-
CROSSC32=arm-linux-androideabi-
export PATH=/usr/lib/ccache:$CROSSC:$CROSSC32:$PATH
# Export
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE
export CROSS_COMPILE_ARM32
export KBUILD_BUILD_USER=B4gol
export KBUILD_BUILD_HOST=CircleCI
export KERN_IMG=$FACTOR/kernel/out/arch/arm/boot/Image.gz-dtb

cp $KERN_IMG $ZIP_DIR
cd $ZIP_DIR
mv Image.gz-dtb Image.gz-dtb
BUILD_END=$(date +"%s")
BUILD_DIFF=$((BUILD_END - BUILD_START))
zip -r $zip_name.zip ./*
