FACTORY=$pwd
KERN_IMG=$FACTORY/kdirect/out/arch/arm/boot/Image.gz-dtb
ZIP_DIR=$FACTORY/keript/AnyKernel
CONFIG_DIR=$FACTORY/arch/arm/configs
echo "Chmod Path"
# gcc64
sudo chmod a+x $HOME/kdirect/gcc64/bin/*
sudo chmod a+x $HOME/kdirect/gcc64/libexec/gcc/aarch64-linux-android/4.9.x/*
sudo chmod a+x $HOME/kdirect/gcc64/libexec/gcc/aarch64-linux-android/4.9.x/plugin/*
# gcc32
sudo chmod a+x $HOME/kdirect/gcc32/bin/*
sudo chmod a+x $HOME/kdirect/gcc32/libexec/gcc/arm-linux-androideabi/4.9.x/*
sudo chmod a+x $HOME/kdirect/gcc32/libexec/gcc/arm-linux-androideabi/4.9.x/plugin/*
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="kdirect/gcc64/bin/aarch64-linux-android-"
CROSS_COMPILE_ARM32+="kdirect/gcc32/bin/arm-linux-androideabi-"
CROSSC=aarch64-linux-android-
CROSSC32=arm-linux-androideabi-
$FACTORY/keript/telegram -M "Build
Up: B4gol
Product: Samsung Kernel
Device: SM-J320G
Branch: SG
Compiler: ""$(gcc --version | head -n 1)""
Date: ""$(env TZ=Asia/Jakarta date)"""
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
make O=out $CONFIG $THREAD