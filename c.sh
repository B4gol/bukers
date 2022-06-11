#$HOME/buildkernel/telegram -M "Build completed successfully in $((BUILD_DIFF / 60)) minute(s) and $((BUILD_DIFF % 60)) seconds
#Download : ["$zip_name".zip](https://github.com/B4gol/kernelscript/releases/download/"$CIRCLECI_TAG"/"$zip_name".zip)"

curl -v -F "chat_id=$TELEGRAM_CHAT" -F document=@/home/circleci/factor/AnyKernel/$zip_name.zip -F "parse_mode=html" -F caption="Build completed successfully in $((BUILD_DIFF / 60)) minute(s) and $((BUILD_DIFF % 60)) seconds
Date : ""$(env TZ=Asia/Jakarta date)""" https://api.telegram.org/bot$TELEGRAM_TOKEN/sendDocument
