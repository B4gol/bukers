# Path Setup
KDIRECT=$pwd/kdirect
KERIPT=$pwd/keript
  export KDIRECT KSCRIPT
KERN_IMG=$KDIRECT/out/arch/arm/boot/Image.gz-dtb
ZIP_DIR=$KERIPT/AnyKernel
CONFIG_DIR=$KDIRECT/arch/arm/configs
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="$KDIRECT/gcc64/bin/aarch64-linux-android-"
CROSS_COMPILE_ARM32+="$KDIRECT/gcc32/bin/arm-linux-androideabi-"
CROSSC=aarch64-linux-android-
CROSSC32=arm-linux-androideabi-
$KERIPT/telegram -M "Build
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