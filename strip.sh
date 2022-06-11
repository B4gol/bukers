# Main Environment
export FACTOR=$pwd
ZIP_DIR=$FACTOR/kernelscript/AnyKernel
KERN_IMG=$FACTOR/kernel/out/arch/arm/boot/Image.gz-dtb
CONFIG_DIR=$FACTOR/kernel/arch/arm/configs
CONFIG=viper_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="$FACTOR/kernel/gcc64/bin/aarch64-linux-android-"
CROSS_COMPILE_ARM32+="$FACTOR/kernel/gcc32/bin/arm-linux-androideabi-"
CROSSC=aarch64-linux-android-
CROSSC32=arm-linux-androideabi-
PATH=/usr/lib/ccache:$CROSSC:$CROSSC32:$PATH
# Export
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE
export CROSS_COMPILE_ARM32
export KBUILD_BUILD_USER=B4gol
export KBUILD_BUILD_HOST=CircleCI

cp $KERN_IMG $ZIP_DIR
cd $ZIP_DIR
mv Image.gz-dtb Image.gz-dtb
BUILD_END=$(date +"%s")
BUILD_DIFF=$((BUILD_END - BUILD_START))
zip -r $zip_name.zip ./*

#$HOME/buildkernel/telegram -M "Build completed successfully in $((BUILD_DIFF / 60)) minute(s) and $((BUILD_DIFF % 60)) seconds
#Download : ["$zip_name".zip](https://github.com/B4gol/kernelscript/releases/download/"$CIRCLECI_TAG"/"$zip_name".zip)"

curl -v -F "chat_id=$TELEGRAM_CHAT" -F document=@$ZIP_DIR/AnyKernel/$zip_name.zip -F "parse_mode=html" -F caption="Build completed successfully in $((BUILD_DIFF / 60)) minute(s) and $((BUILD_DIFF % 60)) seconds
Date : ""$(env TZ=Asia/Jakarta date)""" https://api.telegram.org/bot$TELEGRAM_TOKEN/sendDocument
