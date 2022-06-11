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

$FACTOR/kernelscript/telegram -M "Build
Up: B4gol
Product: Samsung Kernel
Device: SM-J320G
Branch: SG
Compiler: ""$(gcc --version | head -n 1)""
Tanggal: ""$(env TZ=Asia/Jakarta date)"""

# Export
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE
export CROSS_COMPILE_ARM32
export KBUILD_BUILD_USER=B4gol
export KBUILD_BUILD_HOST=CircleCI
make O=out $CONFIG $THREAD
export KERN_IMG=kernel/out/arch/arm/boot/Image.gz-dtb