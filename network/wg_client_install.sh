#!/usr/bin/env bash
#
# Installs AmneziaWG client using the userspace (Go) implementation.
# Works inside LXC containers where kernel module DKMS builds fail.
#
# Usage:
#   sudo ./wg_client_install.sh /path/to/client.conf [interface_name]
#
# Example:
#   sudo ./wg_client_install.sh wg_client.conf awg0
#

set -euo pipefail

if [[ "$EUID" -ne 0 ]]; then
    echo "Run as root."
    exit 1
fi

CONF_SRC="${1:-}"
IFACE="${2:-awg0}"

if [[ -z "$CONF_SRC" || ! -f "$CONF_SRC" ]]; then
    echo "Usage: sudo ./wg_client_install.sh /path/to/client.conf [iface]"
    exit 1
fi

echo "==> Checking /dev/net/tun access"
if [[ ! -c /dev/net/tun ]]; then
    echo "ERROR: /dev/net/tun missing. Fix on the Proxmox HOST first (tun passthrough)."
    exit 1
fi

echo "==> Removing any broken Amnezia PPA entries (unsupported on new Ubuntu releases)"
rm -f /etc/apt/sources.list.d/amnezia-ubuntu-ppa-*.list

echo "==> Installing build dependencies"
apt update -y
apt install -y golang-go git make build-essential pkg-config libelf-dev curl

echo "==> Building amneziawg-go (userspace backend)"
WORKDIR=$(mktemp -d)
git clone https://github.com/amnezia-vpn/amneziawg-go.git "$WORKDIR/amneziawg-go"
(cd "$WORKDIR/amneziawg-go" && make)
install -m 755 "$WORKDIR/amneziawg-go/amneziawg-go" /usr/local/bin/amneziawg-go

echo "==> Building amneziawg-tools (awg, awg-quick) from source"
git clone https://github.com/amnezia-vpn/amneziawg-tools.git "$WORKDIR/amneziawg-tools"
(cd "$WORKDIR/amneziawg-tools/src" && make)
install -m 755 "$WORKDIR/amneziawg-tools/src/wg" /usr/local/bin/awg
install -m 755 "$WORKDIR/amneziawg-tools/src/wg-quick/linux.bash" /usr/local/bin/awg-quick

echo "==> Placing client config"
mkdir -p /etc/amnezia/amneziawg
cp "$CONF_SRC" "/etc/amnezia/amneziawg/${IFACE}.conf"
chmod 600 "/etc/amnezia/amneziawg/${IFACE}.conf"

echo "==> Bringing up interface via userspace backend"
export WG_QUICK_USERSPACE_IMPLEMENTATION=amneziawg-go
awg-quick up "${IFACE}"

echo "==> Status:"
awg show

rm -rf "$WORKDIR"
echo "Client interface '${IFACE}' is up (userspace, no kernel module, no PPA needed)."
