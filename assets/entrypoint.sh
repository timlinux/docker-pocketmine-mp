#!/bin/bash

cd /pocketmine/PocketMine-MP

if ! [ -e server.properties ]; then
    echo >&2 "[WARN] server.properties is not found in $(pwd). Copying from the original assets."
    cp -p ../server.properties.original server.properties
    chown pocketmine:pocketmine server.properties
fi

if ! [ -e PocketMine-MP.phar ]; then
    echo >&2 "[WARN] PocketMine-MP.phar is not found in $(pwd). Installing the latest stable release."
    wget -q -O - http://cdn.pocketmine.net/installer.sh | bash
    chown -R pocketmine:pocketmine /pocketmine
fi

if [ "$UPDATE_LATEST" = 'YES' ]; then
    echo "[INFO] Updating to the latest stable release."
    wget -q -O - http://cdn.pocketmine.net/installer.sh | bash -s - -v Alpha_1.3.12
    chown -R pocketmine:pocketmine /pocketmine
fi

if [ "$UPDATE_LATEST_BETA" = 'YES' ]; then
    echo "[INFO] Updating to the latest beta release."
    wget -q -O - http://cdn.pocketmine.net/installer.sh | bash -s - -v beta
    chown -R pocketmine:pocketmine /pocketmine
fi

if [ "$UPDATE_LATEST_DEV" = 'YES' ]; then
    echo "[INFO] Updating to the latest dev release."
    wget -q -O - http://cdn.pocketmine.net/installer.sh | bash -s - -v development
    chown -R pocketmine:pocketmine /pocketmine
fi

# Tim Hack
#wget -O PocketMine-MP.phar http://jenkins.pocketmine.net/job/PocketMine-MP-Bleeding/29/artifact/PocketMine-MP_1.6dev-29_mcpe-0.12_ed559fdf_API-1.13.0.phar
wget -O PocketMine-MP.phar https://github.com/ImagicalCorp/PocketMine-0.13.0/releases/download/PM-1.7dev%23294/PocketMine-MP_0.13.0dev.294.phar
#su - pocketmine "/pocketmine/PocketMine-MP/start.sh"
/pocketmine/PocketMine-MP/start.sh
