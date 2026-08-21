#!/bin/bash

#
# UFW + Fail2ban + SSH hardening for Ubuntu Server
#

set -euo pipefail

# Check for root privileges
if [ "${EUID}" -ne 0 ]; then
  echo "Error: Please run as root or with sudo." >&2
  exit 1
fi

#
# Tunables (override via environment variables)
#
SSH_PORT=${SSH_PORT:-22}                       # current SSH port; used by UFW
NEW_SSH_PORT=${NEW_SSH_PORT:-}                 # set to e.g. 54321 to move SSH
DISABLE_ROOT_LOGIN=${DISABLE_ROOT_LOGIN:-yes}  # yes|no
DISABLE_PASSWORD_AUTH=${DISABLE_PASSWORD_AUTH:-yes}  # yes|no
FAIL2BAN_SSH_MAXRETRY=${FAIL2BAN_SSH_MAXRETRY:-5}
FAIL2BAN_SSH_BANTIME=${FAIL2BAN_SSH_BANTIME:-10m}
FAIL2BAN_SSH_FINDTIME=${FAIL2BAN_SSH_FINDTIME:-10m}

# Derive the port fail2ban should watch
F2B_PORT="${NEW_SSH_PORT:-$SSH_PORT}"

STEP=0
TOTAL_STEPS=10
next_step() { STEP=$((STEP + 1)); echo "[${STEP}/${TOTAL_STEPS}] $*"; }

echo "--- Starting UFW + Fail2ban + SSH hardening ---"
echo "Current SSH port : ${SSH_PORT}"
echo "New SSH port     : ${NEW_SSH_PORT:-"(unchanged)"}"
echo "Fail2ban SSH port: ${F2B_PORT}"

# 1. Install required packages
next_step "Installing required packages (ufw, fail2ban, openssh-server)..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y -qq ufw fail2ban openssh-server

# 2. Backup SSH configuration
next_step "Backing up SSH configuration..."
if [ ! -f /etc/ssh/sshd_config.orig ]; then
  cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig
  echo "Backup created: /etc/ssh/sshd_config.orig"
else
  echo "Backup already exists: /etc/ssh/sshd_config.orig"
fi

# 3. Harden SSH configuration
next_step "Hardening SSH configuration..."
ensure_sshd_setting() {
  local key="$1"
  local value="$2"
  local file="${3:-/etc/ssh/sshd_config}"

  if grep -Eq "^#?\s*${key}\s+" "$file"; then
    sed -i "s/^#\?\s*${key}\s\+.*/${key} ${value}/" "$file"
  else
    echo "${key} ${value}" >> "$file"
  fi
}

if [ -n "$NEW_SSH_PORT" ] && [ "$NEW_SSH_PORT" != "$SSH_PORT" ]; then
  ensure_sshd_setting Port "$NEW_SSH_PORT"
  echo "SSH port changed from ${SSH_PORT} to ${NEW_SSH_PORT}"
fi

if [ "$DISABLE_ROOT_LOGIN" = "yes" ]; then
  ensure_sshd_setting PermitRootLogin no
  echo "Root login disabled"
fi

if [ "$DISABLE_PASSWORD_AUTH" = "yes" ]; then
  ensure_sshd_setting PasswordAuthentication no
  ensure_sshd_setting PubkeyAuthentication yes
  echo "Password authentication disabled, key authentication enforced"
fi

# Remove duplicate Port directives (keep the last one)
if grep -Eq "^Port\s+" /etc/ssh/sshd_config; then
  awk '/^Port / {last=NR; line=$0; next} {a[NR]=$0} END {for(i=1;i<=NR;i++) {if(i==last){print line}else{print a[i]}}}' \
    /etc/ssh/sshd_config > /etc/ssh/sshd_config.tmp && mv /etc/ssh/sshd_config.tmp /etc/ssh/sshd_config
fi

# Validate SSH configuration before restarting
if ! sshd -t; then
  echo "Error: sshd configuration test failed. Restoring original config." >&2
  cp /etc/ssh/sshd_config.orig /etc/ssh/sshd_config
  exit 1
fi

systemctl restart sshd

# 4. Configure IPv6 support for UFW
next_step "Configuring IPv6 support for UFW..."
if grep -q "^#\?IPV6=" /etc/default/ufw; then
  sed -i 's/^#\?IPV6=.*/IPV6=yes/' /etc/default/ufw
else
  echo "IPV6=yes" >> /etc/default/ufw
fi

# 5. Reset existing UFW rules
next_step "Resetting existing UFW rules..."
ufw --force reset

# 6. Set UFW default policies
next_step "Setting UFW default policies..."
ufw default deny incoming
ufw default allow outgoing
ufw default deny routed
ufw logging low

# 7. Configure UFW allowed services
next_step "Opening standard ports (SSH on port ${F2B_PORT}, HTTP, HTTPS)..."
ufw limit "${F2B_PORT}/tcp" comment 'SSH rate-limited'
ufw allow 80/tcp comment 'HTTP'
ufw allow 443/tcp comment 'HTTPS'

# 8. Enable UFW
next_step "Enabling Firewall..."
ufw --force enable

# 9. Configure Fail2ban
next_step "Configuring Fail2ban for SSH..."
mkdir -p /etc/fail2ban/jail.d

cat > /etc/fail2ban/jail.d/ssh.local <<EOF
[sshd]
enabled  = true
port     = ${F2B_PORT}
filter   = sshd
logpath  = /var/log/auth.log
maxretry = ${FAIL2BAN_SSH_MAXRETRY}
bantime  = ${FAIL2BAN_SSH_BANTIME}
findtime = ${FAIL2BAN_SSH_FINDTIME}
backend  = systemd
EOF

systemctl enable fail2ban
systemctl restart fail2ban

# 10. Verify and summarize
next_step "Verifying configuration..."
echo ""
echo "--- UFW status ---"
ufw status verbose
echo ""
echo "--- Fail2ban status ---"
fail2ban-client status || true
echo ""
echo "--- Fail2ban sshd jail ---"
fail2ban-client status sshd || true
echo ""
echo "--- SSH listening ports ---"
ss -tlnp | grep -E "(State|sshd)" || true
echo ""
echo "--- Configuration Complete ---"
echo ""
if [ -n "$NEW_SSH_PORT" ] && [ "$NEW_SSH_PORT" != "$SSH_PORT" ]; then
  echo "WARNING: SSH is now listening on port ${NEW_SSH_PORT}."
  echo "         Update your client connection before closing this session:"
  echo "           ssh -p ${NEW_SSH_PORT} user@<host>"
fi
if [ "$DISABLE_PASSWORD_AUTH" = "yes" ]; then
  echo "WARNING: Password authentication is disabled. Ensure an SSH key is configured."
fi
if [ "$DISABLE_ROOT_LOGIN" = "yes" ]; then
  echo "WARNING: Root login via SSH is disabled."
fi
echo "Original SSH config backed up at: /etc/ssh/sshd_config.orig"
