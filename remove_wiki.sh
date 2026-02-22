#!/bin/bash

# Remove Wiki Script
# Usage: ./remove_wiki.sh <wiki_name>

if [ $# -ne 1 ]; then
    echo "Usage: $0 <wiki_name>"
    exit 1
fi

WIKI_NAME=$1
WIKI_DIR="/opt/wikis/$WIKI_NAME"
SERVICE_FILE="/etc/systemd/system/wiki-$WIKI_NAME.service"

# Stop and disable the service
sudo systemctl stop "wiki-$WIKI_NAME.service"
sudo systemctl disable "wiki-$WIKI_NAME.service"

# Remove service file
sudo rm -f "$SERVICE_FILE"

# Reload systemd
sudo systemctl daemon-reload

# Remove wiki directory
sudo rm -rf "$WIKI_DIR"

echo "Wiki '$WIKI_NAME' removed."