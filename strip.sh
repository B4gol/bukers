# Main Environment
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb
ZIP_DIR=$HOME/buildkernel/AnyKernel
CONFIG_DIR=$KERNEL_DIR/arch/arm64/configs
CONFIG=final_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
CROSS_COMPILE+="ccache "
CROSS_COMPILE32+="ccache32 "
CROSS_COMPILE+="$PWD/gcc/bin/aarch64-elf-"
CROSS_COMPILE32+="$PWD/gcc/bin/arm-eabi-"
export CROSSC=$CROSS_COMPILE
export CROSSC32=$CROSS_COMPILE32
LD="ld.lld"
cp $KERN_IMG $ZIP_DIR
cd $ZIP_DIR
mv Image.gz-dtb Image.gz-dtb
BUILD_END=$(date +"%s")
BUILD_DIFF=$((BUILD_END - BUILD_START))
zip -r $zip_name.zip ./*
