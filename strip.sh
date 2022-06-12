cd /home/circleci/kdirect
DIRECT=$pwd
SDIRECT=/home/circleci/sdirect
KERN_IMG=$DIRECT/out/arch/arm/boot/Image.gz-dtb
ZIP_DIR=$SDIRECT/AnyKernel
CONFIG_DIR=$DIRECT/arch/arm/configs
CONFIG=viper_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
# PATH
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="$DIRECT/gcc64/bin/aarch64-linux-android-"
CROSS_COMPILE_ARM32+="$DIRECT/gcc32/bin/arm-linux-androideabi-"
CROSSC=aarch64-linux-android-
CROSSC32=arm-linux-androideabi-
# Export
export ARCH=arm
export SUBARCH=arm
export PATH=/usr/lib/ccache:$CROSSC:$CROSSC32:$PATH
export CROSS_COMPILE
export CROSS_COMPILE_ARM32
export KBUILD_BUILD_USER=B4gol
export KBUILD_BUILD_HOST=CircleCI
##