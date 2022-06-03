# Main Environment
cd $HOME/kernel
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb
ZIP_DIR=$KERNEL_DIR/AnyKernel
CONFIG_DIR=$KERNEL_DIR/arch/arm64/configs
CONFIG=riva_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"

echo -e "\n(i) Cloning toolcahins if folder not exist..."
#git clone https://github.com/mvaisakh/gcc-arm64 --depth=1 ~/gcc64
#git clone https://github.com/mvaisakh/gcc-arm.git --depth=1 ~/gcc32
git clone https://github.com/wulan17/prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9.git gcc64
git clone https://github.com/wulan17/prebuilts_gcc_linux-x86_arm-linux-androideabi-4.9.git gcc32
sudo chmod a+x $KERNEL_DIR/gcc64/bin/*
sudo chmod a+x $KERNEL_DIR/gcc64/libexec/gcc/aarch64-linux-android/4.9.x/*
sudo chmod a+x $KERNEL_DIR/gcc64/libexec/gcc/aarch64-linux-android/4.9.x/plugin/*

#cd $HOME/kernel && wget https://github.com/wulan17/android_kernel_xiaomi_cactus/commit/63623ef9ea9260810d10c2422d4548470a29f304.patch
#cd $HOME/kernel && git am < 63623ef9ea9260810d10c2422d4548470a29f304.patch

CROSS_COMPILE+="ccache "
CROSS_COMPILE+="$KERNEL_DIR/gcc64/bin/aarch64-linux-android-"
CROSS_COMPILE_ARM32+="$KERNEL_DIR/gcc32/bin/arm-linux-androideabi-"
CROSSC=aarch64-linux-android-
CROSSC32=arm-linux-androideabi-

$HOME/buildkernel/telegram -M "Build Start
By: B4gol
Product: Rova Kernel
Device: #riva
Branch: R11
Compiler: ""$(gcc --version | head -n 1)""
Tanggal: ""$(env TZ=Asia/Jakarta date)"""

# Export
export ARCH=arm64
export SUBARCH=arm64
export PATH=/usr/bin:usr/lib/ccache:$CROSSC:$CROSSC32:$PATH
export CROSS_COMPILE
export CROSS_COMPILE_ARM32
export KBUILD_BUILD_USER=B4gol
export KBUILD_BUILD_HOST=CircleCi-Agent
make O=out $CONFIG $THREAD