#!/bin/bash

# Define installation paths
BIN_PATH="/usr/local/bin/sysopctl"
MAN_PATH="/usr/local/share/man/man1/sysopctl.1"

# Copy sysopctl script to /usr/local/bin and make it executable
echo "Installing sysopctl..."
sudo cp sysopctl.sh "$BIN_PATH"
sudo chmod +x "$BIN_PATH"

# Copy man page to the correct directory
echo "Installing man page..."
sudo cp sysopctl.1 "$MAN_PATH"

# Update the man database
echo "Updating man database..."
sudo mandb

echo "Installation complete! You can now use 'sysopctl' from the command line."
