# Path Setup
KDIRECT=$pwd
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="$KDIRECT/gcc64/bin/aarch64-linux-android-"
CROSS_COMPILE_ARM32+="$KDIRECT/gcc32/bin/arm-linux-androideabi-"
CROSSC=aarch64-linux-android-
CROSSC32=arm-linux-androideabi-
# Export Path
export PATH=/usr/lib/ccache:$CROSSC:$CROSSC32:$PATH
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE
export CROSS_COMPILE_ARM32
export KBUILD_BUILD_USER=B4gol
export KBUILD_BUILD_HOST=CircleCI
# Main Environment
CONFIG=viper_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
make O=out $CONFIG $THREAD
##