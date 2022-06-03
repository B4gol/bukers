# Main Environment
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb
ZIP_DIR=$KERNEL_DIR/AnyKernel
CONFIG_DIR=$KERNEL_DIR/arch/arm64/configs
CONFIG=final_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"

echo -e "\n(i) Cloning toolcahins if folder not exist..."
git clone https://github.com/mvaisakh/gcc-arm64 --depth=1 ~/gcc64
git clone https://github.com/mvaisakh/gcc-arm.git --depth=1 ~/gcc32
#git clone https://github.com/wulan17/prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9.git aarch64-linux-android-4.9
#git clone https://github.com/wulan17/prebuilts_gcc_linux-x86_arm-linux-androideabi-4.9.git arm-linux-androideabi-4.9
chmod a+x ~/gcc64/bin/*
chmod a+x ~/gcc32/lib/gcc/aarch64-elf/13.0.0/*
chmod a+x ~/gcc64/lib/gcc/aarch64-elf/13.0.0/plugin/*
chmod a+x ~/gcc32/bin/*
chmod a+x ~/gcc32/lib/gcc/arm-eabi/13.0.0/*
chmod a+x ~/gcc32/lib/gcc/arm-eabi/13.0.0/plugin/*
#cd $HOME/kernel && wget https://github.com/wulan17/android_kernel_xiaomi_cactus/commit/63623ef9ea9260810d10c2422d4548470a29f304.patch
#cd $HOME/kernel && git am < 63623ef9ea9260810d10c2422d4548470a29f304.patch

CROSS_COMPILE+="ccache"
CROSS_COMPILE+="~/gcc64/bin/aarch64-elf-"
CROSS_COMPILE_ARM32+="~/gcc32/bin/arm-eabi-"
LD+="~/gcc64/bin/aarch64-elf-ld.lld"
export CROSSC="~/gcc64/bin/aarch64-elf-"
export CROSSC32="~/gcc32/bin/arm-eabi-"

$HOME/buildkernel/telegram -M "Build Start
By      : B4gol
Product : Rova Kernel
Device  : #riva
Branch  : R11
Compiler: ""$(gcc --version | head -n 1)""
Jalur   : ""$(CR -v | head -n1 | sed 's/(Cocok [^)]*)//' |
		head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//')""
Date    : ""$(env TZ=Asia/Jakarta date)"""

# Export
export ARCH=arm64
export SUBARCH=arm64
export PATH=/usr/bin:$CROSSC:$CROSSC32:$LD:/usr/lib/ccache:$PATH
export CROSS_COMPILE
export CROSS_COMPILE_ARM32
export KBUILD_BUILD_USER=B4gol
export KBUILD_BUILD_HOST=CircleCi-Agent
make O=out $CONFIG $THREAD