FACTORY=$pwd
KERN_IMG=$FACTORY/kdirect/out/arch/arm/boot/Image.gz-dtb
ZIP_DIR=$FACTORY/keript/AnyKernel
CONFIG_DIR=$FACTORY/arch/arm/configs
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="$FACTORY/kdirect/gcc64/bin/aarch64-linux-android-"
CROSS_COMPILE_ARM32+="$FACTORY/kdirect/gcc32/bin/arm-linux-androideabi-"
CROSSC=aarch64-linux-android-
CROSSC32=arm-linux-androideabi-
$FACTORY/keript/telegram -M "Build
Up: B4gol
Product: Samsung Kernel
Device: SM-J320G
Branch: SG
Compiler: ""$(gcc --version | head -n 1)""
Tanggal: ""$(env TZ=Asia/Jakarta date)"""
# Export
export ARCH=arm
export SUBARCH=arm
export PATH=/usr/lib/ccache:$CROSSC:$CROSSC32:$PATH
export CROSS_COMPILE
export CROSS_COMPILE_ARM32
export KBUILD_BUILD_USER=B4gol
export KBUILD_BUILD_HOST=CircleCI
# Main Environment
CONFIG=viper_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"