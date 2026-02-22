#!/bin/bash

# Setup script for Wiki Server
# This script installs Node.js and TiddlyWiki globally

# Update system
sudo dnf update -y

# Install Node.js
sudo dnf install -y nodejs npm

# Install TiddlyWiki globally
sudo npm install -g tiddlywiki

# Create directory for wikis
sudo mkdir -p /opt/wikis
sudo chown $USER:$USER /opt/wikis

echo "Setup complete. Node.js and TiddlyWiki installed."