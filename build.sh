# Main Environment
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/out/arch/arm64/boot/zImage-dtb
ZIP_DIR=$KERNEL_DIR/AnyKernel
CONFIG_DIR=$KERNEL_DIR/arch/arm64/configs
CONFIG=riva_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="$PWD/aarch64-linux-android-4.9/bin/aarch64-linux-android-"

echo -e "\n(i) Cloning toolcahins if folder not exist..."
git clone https://github.com/wulan17/prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9.git aarch64-linux-android-4.9
#git clone https://github.com/wulan17/prebuilts_gcc_linux-x86_arm-linux-androideabi-4.9.git arm-linux-androideabi-4.9
chmod a+x /home/travis/kernel/aarch64-linux-android-4.9/bin/*
chmod a+x /home/travis/kernel/aarch64-linux-android-4.9/libexec/gcc/aarch64-linux-android/4.9.x/*
chmod a+x /home/travis/kernel/aarch64-linux-android-4.9/libexec/gcc/aarch64-linux-android/4.9.x/plugin/*

#cd $HOME/kernel && wget https://github.com/wulan17/android_kernel_xiaomi_cactus/commit/63623ef9ea9260810d10c2422d4548470a29f304.patch
#cd $HOME/kernel && git am < 63623ef9ea9260810d10c2422d4548470a29f304.patch

$HOME/buildkernel/telegram -M "Build Start
Dev : B4gol

Product : Kernel

Device : #riva

Branch : Rel

Compiler : ""$(gcc --version)""

Compiler : ""$(${CROSS_COMPILE}gcc --version | head -n 1)""

Date : ""$(env TZ=Asia/Jakarta date)"""

# Export
export ARCH=arm64
export SUBARCH=arm64
export PATH=/usr/lib/ccache:$PATH
export CROSS_COMPILE
export KBUILD_BUILD_USER=B4gol
export KBUILD_BUILD_HOST=CircleCi-Agent
make  O=out $CONFIG $THREAD
