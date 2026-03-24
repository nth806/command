#!/usr/bin/env bash
#########################################################################################
# Remote installation script for command utilities
#
# Description:
#   This script is designed to be executed on a remote server to install command utilities.
#   It performs the following steps:
#   1. Downloads the installation script from a specified URL.
#   2. Executes the downloaded script to install the utilities.
# Usage:
#   1. Ensure you have the necessary permissions to execute the script on the remote server.
#   2. Run the script using a command like:
#      curl -sSL https://github.com/nth806/command/blob/main/install.sh | bash
#########################################################################################

REPO_URL="https://github.com/nth806/command"
DEST_DIR="command"

# Clone or update the repository
if [ -d "$DEST_DIR/.git" ]; then
  echo "Repository already exists at '$DEST_DIR'. Pulling latest changes..."
  git -C "$DEST_DIR" pull
else
  echo "Cloning $REPO_URL into '$DEST_DIR'..."
  git clone "$REPO_URL" "$DEST_DIR"
fi

# Run the installer
cd "$DEST_DIR" && ./install && cd ..
