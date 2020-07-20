#!/bin/sh

FILE_NAME=$(curl -s https://api.github.com/repos/Radarr/Radarr/releases | jq -r '[[.[] | select(.draft != true) | select(.prerelease == true)][0] | .assets | .[] | select(.name | endswith(".linux.tar.gz")) | .name][0]')
DOWNLOAD=$(curl -s https://api.github.com/repos/Radarr/Radarr/releases | jq -r '[[.[] | select(.draft != true) | select(.prerelease == true)][0] | .assets | .[] | select(.name | endswith(".linux.tar.gz")) | .browser_download_url][0]')

pw user add radarr -c radarr -u 352 -d /nonexistent -s /usr/bin/nologin
fetch -o /usr/local/share "${DOWNLOAD}"
tar -xzvf /usr/local/share/${FILE_NAME} -C /usr/local/share
rm /usr/local/share/"${FILE_NAME}"
chmod 755 /usr/local/radarr
chmod u+x /usr/local/etc/rc.d/radarr
sysrc "radarr_enable=YES"

