#!/bin/bash
set -euo pipefail

#
# UFW Installation and Configuration
#

# Configuration
SSH_PORT=${SSH_PORT:-22}

STEP=0
total_steps=5

next_step() { STEP=$((STEP + 1)); echo "[${STEP}/${total_steps}] $*"; }

echo "--- Starting UFW Installation and Configuration ---"

# 0. Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or using sudo."
  exit 1
fi

# 1. Install UFW
next_step "Installing UFW..."
apt update
apt install ufw -y

# 2. Enable IPv6 support in UFW config
next_step "Enabling IPv6 support..."
sed -i 's/^IPV6=.*/IPV6=yes/' /etc/default/ufw

# 3. Reset existing rules (idempotent re-runs)
next_step "Resetting existing UFW rules..."
echo "WARNING: Existing UFW rules will be reset."
ufw --force reset

# 4. Set Default Policies
# Deny all incoming, allow all outgoing
next_step "Setting default policies..."
ufw default deny incoming
ufw default allow outgoing

# 5. Allow Common Services
# NOTE: Rules must be defined BEFORE enabling UFW to avoid locking out SSH.
next_step "Opening standard ports (SSH on port ${SSH_PORT}, HTTP, HTTPS)..."

# SSH: rate-limit to mitigate brute-force attacks (max 6 connections per 30s)
ufw limit "${SSH_PORT}/tcp" comment 'SSH'

# Web server: allow HTTP and HTTPS from any source
ufw allow 80/tcp comment 'HTTP'
ufw allow 443/tcp comment 'HTTPS'

# 6. Enable UFW
# '--force' skips the confirmation prompt to make it script-friendly
echo "[UFW] Enabling Firewall..."
ufw --force enable

echo "--- Configuration Complete ---"
ufw status verbose
