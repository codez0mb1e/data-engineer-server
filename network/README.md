# AmneziaWG Client Setup — LXC Container

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
  - [One-time host-side step (Proxmox host, not inside the container)](#one-time-host-side-step-proxmox-host-not-inside-the-container)
- [How to Run the Install Script](#how-to-run-the-install-script)
  - [Known config quirk: I2–I5 parameters](#known-config-quirk-i2i5-parameters)
- [Post-Installation Validation](#post-installation-validation)
  - [1. Interface and handshake status](#1-interface-and-handshake-status)
  - [2. Interface state and IP](#2-interface-state-and-ip)
  - [3. Routing through the tunnel](#3-routing-through-the-tunnel)
  - [4. Confirm traffic actually flows through the VPN](#4-confirm-traffic-actually-flows-through-the-vpn)
  - [5. Direct peer connectivity test](#5-direct-peer-connectivity-test)
  - [6. Confirm handshake stays alive over time](#6-confirm-handshake-stays-alive-over-time)
  - [Troubleshooting a stuck/empty handshake](#troubleshooting-a-stuckempty-handshake)


## Introduction

Installing an AmneziaWG (AWG) 2.0 client inside a **Proxmox LXC container**, connecting it to an existing AmneziaWG server, and validating the tunnel. Because LXC containers share the Proxmox host's kernel, the kernel-module (DKMS) installation path does not work here — this uses the **userspace `amneziawg-go` implementation** instead, which runs entirely inside the container without requiring host kernel changes beyond a one-time `/dev/net/tun` passthrough.

## Prerequisites

- Proxmox host access to configure `/dev/net/tun` passthrough for the container.
- A client `.conf` file (exported from the AmneziaVPN app, or manually composed).
- Root access inside the LXC container.

### One-time host-side step (Proxmox host, not inside the container)

```bash
CTID=<your_container_id>
cat >> /etc/pve/lxc/${CTID}.conf <<'EOF'
lxc.cgroup2.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file
EOF
pct restart ${CTID}
```

Verify inside the container afterward:

```bash
ls -la /dev/net/tun
```

## How to Run the Install Script

1. Save the installer script as `wg_client_install.sh` inside the container.
2. Make it executable:

   ```bash
   chmod +x wg_client_install.sh
   ```

3. Run it as root, passing your client config file and desired interface name:

   ```bash
   sudo ./wg_client_install.sh /path/to/client.conf awg0
   ```

The script will:
- Remove any broken Amnezia PPA entries (PPAs often lag behind new Ubuntu releases).
- Build `amneziawg-go` and `amneziawg-tools` from source (no kernel module, no DKMS).
- Place the client config at `/etc/amnezia/amneziawg/awg0.conf`.
- Configure the systemd service template `awg-quick@.service` with `WG_QUICK_USERSPACE_IMPLEMENTATION=amneziawg-go`.
- Enable and start the tunnel via `systemctl enable --now awg-quick@awg0` to persist across reboots.

### Known config quirk: I2–I5 parameters

If you see `Line unrecognized` or `Configuration parsing error` referencing `I2`/`I3`/etc., comment those lines out in your client `.conf` — this is a known upstream parser limitation in `amneziawg-tools`, unrelated to your setup. The rest of the obfuscation parameters (`Jc`, `Jmin`, `Jmax`, `H1–H4`, `S1/S2`) still apply normally.

## Post-Installation Validation

Run these checks after `awg-quick up awg0` completes successfully.

### 1. Interface and handshake status

```bash
sudo awg show awg0
```

Look for a non-zero **latest handshake** value — this confirms the client and server successfully exchanged keys.

### 2. Interface state and IP

```bash
ip addr show awg0
```

Confirms the interface is `UP` with the expected address (e.g., `10.x.x.x/24`).

### 3. Routing through the tunnel

```bash
ip route get 8.8.8.8
```

Should show `dev awg0` as the outgoing interface if the tunnel is set as the default route.

### 4. Confirm traffic actually flows through the VPN

```bash
curl -s https://ifconfig.me
```

This should return the **VPN server's public IP**, not the container's own IP.

### 5. Direct peer connectivity test

```bash
ping -c 4 <server_vpn_internal_ip>
```

Successful replies confirm the encrypted tunnel works end-to-end.

### 6. Confirm handshake stays alive over time

```bash
watch -n 5 sudo awg show awg0
```

With `PersistentKeepalive = 25` set, the handshake timestamp should keep refreshing rather than growing stale.

### Troubleshooting a stuck/empty handshake

- Check the server's UDP port is reachable: `nc -zvu <server_ip> <port>`.
- Verify `PublicKey`/`PresharedKey` match exactly between client and server (no trailing whitespace).
- Confirm `H1–H4` and `S1/S2` values are **identical** on both sides — mismatches silently break the handshake with no clear error.
- If routing works but traffic doesn't pass through in an unprivileged LXC container, check whether `iptables`/NAT rules are being blocked; converting the container to privileged mode (`pct set <CTID> --unprivileged 0`) is a common fix.
