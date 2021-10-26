 #!/bin/bash

 ##----------------------------------------------------------##

 if [ "$PTTG" = 1 ]
 	then
            tg_post_msg "<b>🔨 Recovery Build Triggered</b>
<b>Host Core Count : </b><code>$PROCS</code>
<b>Codename: </b><code>$DEVICE</code>
<b>Variant: </b><code>$VARIANT</code>
<b>Build type: </b><code>$BUILD_TYPE</code>
<b>Recovery Name: </b><code>$VARIANT-RECOVERY-$DEVICE-$BUILD_TYPE</code>

        fi

 }
 
