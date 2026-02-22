# Wiki Server Setup

This repository contains scripts to set up a Linux host to support multiple TiddlyWiki instances. Each wiki runs as a systemd service and will automatically restart after host reboots. You can easily add and remove wikis using the provided scripts.

## Prerequisites

- Fedora Linux (or compatible)
- Root or sudo access
- Internet connection

## Setup

1. Make the setup script executable:
   ```bash
   chmod +x setup.sh
   ```

2. Run the setup script:
   ```bash
   sudo ./setup.sh
   ```

The script will:
- Update system packages
- Install Node.js and npm
- Install TiddlyWiki globally
- Create /opt/wikis directory for wiki storage

## Adding a Wiki

To add a new wiki:

1. Make the add script executable:
   ```bash
   chmod +x add_wiki.sh
   ```

2. Run the add script with a unique name and port:
   ```bash
   sudo ./add_wiki.sh mywiki 8080
   ```

This will:
- Create a directory for the wiki at /opt/wikis/mywiki
- Initialize a new TiddlyWiki instance
- Create and start a systemd service to run the wiki on the specified port
- Enable the service to start automatically on boot

## Removing a Wiki

To remove a wiki:

1. Make the remove script executable:
   ```bash
   chmod +x remove_wiki.sh
   ```

2. Run the remove script with the wiki name:
   ```bash
   sudo ./remove_wiki.sh mywiki
   ```

This will:
- Stop and disable the systemd service
- Remove the service file
- Delete the wiki directory and all its contents

## Accessing Wikis

Once added, wikis are accessible at `http://donkey.local:<port>` from other hosts on the network, where `<port>` is the port you specified when adding the wiki.

## Managing Services

You can manage individual wiki services using standard systemd commands:

- Check status: `sudo systemctl status wiki-<name>`
- Restart: `sudo systemctl restart wiki-<name>`
- Stop: `sudo systemctl stop wiki-<name>`
- Start: `sudo systemctl start wiki-<name>`

## Notes

- Choose unique ports for each wiki (e.g., 8080, 8081, etc.)
- Wikis are stored in /opt/wikis/
- Services run as the user who added them
- All wikis restart automatically after host reboots