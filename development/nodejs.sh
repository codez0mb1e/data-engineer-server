#!/bin/bash
set -e

#
# Install Node.js 22 LTS (required for MCP servers via npx)
#


# Install Node.js 22 from NodeSource
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify
node --version
npx --version
