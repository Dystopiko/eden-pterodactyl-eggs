#!/bin/bash
set -euo pipefail

# Switch to the container's working directory
cd /home/container || exit 1

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Validate that STARTUP is set and non-empty
if [[ -z "${STARTUP:-}" ]]; then
    echo "[ERROR] STARTUP variable is not set. Configure it in your Pterodactyl egg."
    exit 1
fi

# Replace Pterodactyl's {{STARTUP}} syntax with shell $VARIABLE syntax
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the bot, using exec so signals (stop/restart) are passed directly to the process
exec ${MODIFIED_STARTUP}
