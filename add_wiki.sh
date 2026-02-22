#!/bin/bash

# Add Wiki Script
# Usage: ./add_wiki.sh <wiki_name> <port>

if [ $# -ne 2 ]; then
    echo "Usage: $0 <wiki_name> <port>"
    exit 1
fi

WIKI_NAME=$1
PORT=$2
WIKI_DIR="/opt/wikis/$WIKI_NAME"

# Create wiki directory
mkdir -p "$WIKI_DIR"

# Initialize TiddlyWiki
cd "$WIKI_DIR"
tiddlywiki . --init server

# Create systemd service file
SERVICE_FILE="/etc/systemd/system/wiki-$WIKI_NAME.service"

sudo tee "$SERVICE_FILE" > /dev/null <<EOF
[Unit]
Description=TiddlyWiki Server for $WIKI_NAME
After=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=$WIKI_DIR
ExecStart=/usr/local/bin/tiddlywiki . --server $PORT "" "" "" "" "" 0.0.0.0 ""
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, enable and start the service
sudo systemctl daemon-reload
sudo systemctl enable "wiki-$WIKI_NAME.service"
sudo systemctl start "wiki-$WIKI_NAME.service"

echo "Wiki '$WIKI_NAME' added and started on port $PORT."