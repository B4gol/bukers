echo "Set Environment"
  export TELEGRAM_TOKEN=$TELE_TOKEN
  export TELEGRAM_CHAT=$TELE_CHAT
  export GITHUB_TOKEN=$OTH_TOKEN
  export tag=$CIRCLECI_TAG
echo "Setup Install"
  export release_repo="B4gol/kernelscript"
  export zip_name="Ukernel-Riva-"$(env TZ='Asia/Jakarta' date +%Y%m%d)""
  sudo apt-get update
  sudo apt install -y liblz4-dev openjdk-8-jdk android-tools-adb bc bison build-essential curl flex g++-multilib gcc-multilib gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc yasm zip zlib1g-dev
 
echo "Clone Source"
  cd $HOME && PATH=~/bin:$PATH
  curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
  chmod a+x ~/bin/repo
echo "Get Script"
  cd $HOME && git clone https://github.com/B4gol/kernelscript.git buildkernel
  chmod a+x $HOME/buildkernel/telegram
  SYNC_START=$(date +"%s")
  $HOME/buildkernel/telegram -M "Sync Started"
  cd $HOME && git clone -b 11-master https://github.com/B4gol/platform-kernelist-xiaomi-rova.git --depth 1 kernel
  cp $HOME/buildkernel/build.sh $HOME/kernel/build.sh
  cd $HOME/kernel && chmod +x build.sh
  SYNC_END=$(date +"%s")
  SYNC_DIFF=$((SYNC_END - SYNC_START))
  $HOME/buildkernel/telegram -M "Sync completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
  BUILD_START=$(date +"%s")
  cd $HOME/kernel
  bash build.sh
  make -j4 ARCH=arm64 CROSS_COMPILE=gcc O=out
  cp $HOME/buildkernel/strip.sh $HOME/kernel/strip.sh
  cp $HOME/buildkernel/c.sh $HOME/kernel/c.sh
  git config --local user.name "B4gol"
  git config --local user.email "ivansuselo@gmail.com"
  git tag $CIRCLECI_TAG
  cd $HOME/kernel && chmod +x strip.sh && bash strip.sh
  cd $HOME/kernel && chmod +x c.sh && bash c.sh
echo "Try Deploy"
  # Set up git user name and tag this commit
