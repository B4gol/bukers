# Main Environment
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/out/arch/arm/boot/zImage-dtb
ZIP_DIR=$HOME/build_kernel/AnyKernel
CONFIG_DIR=$KERNEL_DIR/arch/arm/configs
CONFIG=viper_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="$PWD/arm-gcc/bin/arm-linux-androideabi-"
CROSS_COMPILE_ARM32+="$PWD/arm-gcc/bin/arm-linux-androideabi-"
cp $KERN_IMG $ZIP_DIR
cd $ZIP_DIR
mv zImage-dtb zImage
BUILD_END=$(date +"%s")
BUILD_DIFF=$((BUILD_END - BUILD_START))
zip -r $zip_name.zip ./*