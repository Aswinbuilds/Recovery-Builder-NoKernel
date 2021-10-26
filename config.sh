 #!/bin/bash

 TOKEN=$TELEGRAM_TOKEN

 # Push ZIP to Telegram. 1 is YES | 0 is NO(default)
PTTG=1
       if [ $PTTG = 1 ]
       then 
               # Set Telegram Chat ID
		CHATID=$TELEGRAM_CHATID
	fi

 ##--------------------------------------------------------------##

 exports() {
         BOT_MSG_URL="https://api.telegram.org/bot$TOKEN/sendMessage"
	 BOT_BUILD_URL="https://api.telegram.org/bot$TOKEN/sendDocument"
	 PROCS=$(nproc)
         export BOT_MSG_URL \
	        BOT_BUILD_URL PROCS TOKEN
}

 ##---------------------------------------------------------##

 tg_post_msg() {
        curl -s -X POST "$BOT_MSG_URL" -d chat_id="$CHATID" \
	-d "disable_web_page_preview=true" \
	-d "parse_mode=html" \
	-d text="$1"

}

 ##---------------------------------------------------------##

 tg_post_build() {
         #Post MD5Checksum alongwith for easeness
	 MD5CHECK=$(md5sum "$1" | cut -d' ' -f1)

         #Show the Checksum alongwith caption
	 curl --progress-bar -F document=@"$1" "$BOT_BUILD_URL" \
 	 -F chat_id="$CHATID"  \
	 -F "disable_web_page_preview=true" \
	 -F "parse_mode=html" \
	 -F caption="$2 | <b>MD5 Checksum : </b><code>$MD5CHECK</code>"
}
 
 ##----------------------------------------------------------##

 tg_send_sticker() {
    curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendSticker" \
        -d sticker="$1" \
        -d chat_id="$CHATID"
}  

 ##----------------------------------------------------------##

 tg_send_files(){
    KernelFiles="$(pwd)/$KERNELNAME.zip"
	MD5CHECK=$(md5sum "$KernelFiles" | cut -d' ' -f1)
	SID="CAACAgUAAxkBAAIlv2DEzB-BSFWNyXkkz1NNNOp_pm2nAAIaAgACXGo4VcNVF3RY1YS8HwQ"
	STICK="CAACAgUAAxkBAAIlwGDEzB_igWdjj3WLj1IPro2ONbYUAAIrAgACHcUZVo23oC09VtdaHwQ"
    MSG="✅ <b>Build Done</b>
- <code>$((DIFF / 60)) minute(s) $((DIFF % 60)) second(s) </code>
<b>Build Type</b>
-<code>$BUILD_TYPE</code>
<b>MD5 Checksum</b>
- <code>$MD5CHECK</code>
<b>Zip Name</b>
- <code>$KERNELNAME.zip</code>"

        curl --progress-bar -F document=@"$KernelFiles" "https://api.telegram.org/bot$TOKEN/sendDocument" \
        -F chat_id="$CHATID"  \
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html" \
        -F caption="$MSG"

}

       
