# Main Environment
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb
ZIP_DIR=$HOME/buildkernel/AnyKernel
CONFIG_DIR=$KERNEL_DIR/arch/arm64/configs
CONFIG=final_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
CROSS_COMPILE+="CROSSC "
CROSS_COMPILE+="$HOME/gcc64/bin/aarch64-elf-"
#CROSS_COMPILE_ARM32+="$HOME/gcc32/bin/arm-eabi-"
export CROSSC+="$HOME/gcc64/bin/aarch64-elf-"
#export CROSSC32+="$HOME/gcc32/bin/arm-eabi-"
cp $KERN_IMG $ZIP_DIR
cd $ZIP_DIR
mv Image.gz-dtb Image.gz-dtb
BUILD_END=$(date +"%s")
BUILD_DIFF=$((BUILD_END - BUILD_START))
zip -r $zip_name.zip ./*
