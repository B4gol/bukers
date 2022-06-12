KDIRECT=$pwd
SDIRECT=$HOME
KERN_IMG=/home/circleci/out/arch/arm/boot/Image.gz-dtb
ZIP_DIR=$KDIRECT/AnyKernel
CONFIG_DIR=$KDIRECT/arch/arm/configs
CONFIG=viper_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
echo "Chmod Path"
# gcc64
sudo chmod a+x /home/circleci/gcc64/bin/*
sudo chmod a+x /home/circleci/gcc64/libexec/gcc/aarch64-linux-android/4.9.x/*
sudo chmod a+x /home/circleci/gcc64/libexec/gcc/aarch64-linux-android/4.9.x/plugin/*
# gcc32
sudo chmod a+x /home/circleci/gcc32/bin/*
sudo chmod a+x /home/circleci/gcc32/libexec/gcc/arm-linux-androideabi/4.9.x/*
sudo chmod a+x /home/circleci/gcc32/libexec/gcc/arm-linux-androideabi/4.9.x/plugin/*
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="/home/circleci/gcc64/bin/aarch64-linux-android-"
CROSS_COMPILE_ARM32+="/home/circleci/gcc32/bin/arm-linux-androideabi-"
CROSSC=aarch64-linux-android-
CROSSC32=arm-linux-androideabi-
$SDIRECT/sdirect/telegram -M "Build
Up: B4gol
Product: Samsung Kernel
Device: SM-J320G
Codename: j3xlte
Compiler: ""$(gcc --version | head -n 1)""
Tanggal: ""$(env TZ=Asia/Jakarta date)"""
# Export
export ARCH=arm
export SUBARCH=arm
export PATH=/usr/lib/ccache:$CROSSC:$CROSSC32:$PATH
export CROSS_COMPILE
export CROSS_COMPILE_ARM32
export KBUILD_BUILD_USER=B4gol
export KBUILD_BUILD_HOST=CircleCI
##
	if [ -f /home/circleci/out/arch/arm64/boot/Image.gz-dtb ]
	then
echo "Kernel successfully compiled"
echo "Zip Kernel"
ZIP_DIR=$KDIRECT/AnyKernel
cp /home/circleci/out/arch/arm/boot/Image.gz-dtb $ZIP_DIR/Image.gz-dtb
cd $ZIP_DIR
BUILD_END=$(date +"%s")
BUILD_DIFF=$((BUILD_END - BUILD_START))
zip -r $zip_name.zip ./*

curl -v -F "chat_id=$TELEGRAM_CHAT" -F document=@$ZIP_DIR/$zip_name.zip -F "parse_mode=html" -F caption="Build completed in: $((BUILD_DIFF / 60)) min(s) and $((BUILD_DIFF % 60)) sec(s)
Date : ""$(env TZ=Asia/Jakarta date)""" https://api.telegram.org/bot$TELEGRAM_TOKEN/sendDocument
  
	elif ! [ -f /home/circleci/out/arch/arm64/boot/Image.gz-dtb ]
	then
		echo -e 2>&1 | tee log.txt "Build failed, See log to fix errors"
	curl -v -F "chat_id=$TELEGRAM_CHAT" -F document=@$KDIRECT/log.txt -F "parse_mode=html" -F caption="Build failed in: $((BUILD_DIFF / 60)) min(s) and $((BUILD_DIFF % 60)) sec(s)
Date : ""$(env TZ=Asia/Jakarta date)""" https://api.telegram.org/bot$TELEGRAM_TOKEN/sendDocument
	fi