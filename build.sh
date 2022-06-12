KERN_IMG=$HOME/kdirect/out/arch/arm/boot/Image.gz-dtb
ZIP_DIR=$HOME/sdirect/AnyKernel
CONFIG_DIR=$HOME/kdirect/arch/arm/configs
CONFIG=viper_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
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
CROSS_COMPILE+="$HOME/kdirect/gcc64/bin/aarch64-linux-android-"
CROSS_COMPILE_ARM32+="$HOME/kdirect/gcc32/bin/arm-linux-androideabi-"
CROSSC=aarch64-linux-android-
CROSSC32=arm-linux-androideabi-
$HOME/sdirect/telegram -M "Build (load...)
Up: B4gol
Product: Samsung Kernel
Device: SM-J320G
Codename: j3xlte
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
make O=out $CONFIG $THREAD