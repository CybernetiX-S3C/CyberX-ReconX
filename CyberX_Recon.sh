#!/bin/bash

# ░█▀█░█▀█░█▀▀░█▄█░█▀▀░█░█░█▀▀░█▄░█
# ░█▀▀░█░█░▀▀█░█░█░█▀▀░█░█░█▀▀░█░▀█
# ░▀░░░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░░▀
# 🔧 CyberShell ReconX v4.3 — Codename: Darkstorm
# 👤 Author: John Poli Modica • CybernetiX S3C
# Keep that Darkness Lit. Security, Done Right.

REPO="https://github.com/aircrack-ng/rtl8812au.git"
DRIVER_DIR="rtl8812au"
KERNEL_VERSION="$(uname -r)"
HEADER_PKG="linux-headers-$KERNEL_VERSION"
LOG_DIR="$HOME/CyberReconX/logs"
EXPORT_DIR="$HOME/CyberReconX/export"
INSTALL_PATH="/usr/local/bin/cyberx"

mkdir -p "$LOG_DIR" "$EXPORT_DIR"
LOG_FILE="$LOG_DIR/reconx-$(date '+%Y%m%d-%H%M%S').log"

# ─────────────────────────────────────────────────────────────
# Logging Utility
log() {
  echo "[CyberX] $1" | tee -a "$LOG_FILE"
}

# Banner
banner() {
  clear
  echo -e "\033[1;36m"
  echo "╔════════════════════════════════════════════════════════╗"
  echo "║ ▄█▀ ▀█▀ ▄█▄ ▄▀▀ ▄▀█ ▀█▀   ▄▀▀ ▄▀▀ ▄▀▀ ▄▀▄ ▄▀▄ ▄█▀ ▀█▀ ║"
  echo "║ █▄▄ ░█░ █░█ ▀▄▄ █▀█ ░█░   ▀▄▄ ░▀▄ ▀▄▄ █░█ █░█ █▄▄ ░█░ ║"
  echo "║                ⚡ CYBERX ⚡                             ║"
  echo "║           Version 4.3 — Codename: Darkstorm           ║"
  echo "╚════════════════════════════════════════════════════════╝"
  echo -e "\033[0m"
}

# ─────────────────────────────────────────────────────────────
# Interface selector
iface_selector() {
  echo ""
  echo "🎯 Available wireless interfaces:"
  iwconfig 2>/dev/null | grep 'IEEE' | awk '{print "  - " $1}'
  read -rp "Select interface to use: " iface
  echo ""
}

# ─────────────────────────────────────────────────────────────
# Core Recon & Utility Functions
enable_monitor_mode() {
  log "Enabling monitor mode on $iface..."
  sudo ip link set "$iface" down
  sudo iw "$iface" set monitor control
  sudo ip link set "$iface" up
}

disable_monitor_mode() {
  log "Disabling monitor mode on $iface..."
  sudo ip link set "$iface" down
  sudo iw "$iface" set type managed
  sudo ip link set "$iface" up
}

iface_reset() {
  log "Resetting interface $iface..."
  sudo ip link set "$iface" down
  sudo ip link set "$iface" up
}

mac_spoof() {
  log "Spoofing MAC on $iface..."
  sudo ifconfig "$iface" down
  sudo macchanger -r "$iface"
  sudo ifconfig "$iface" up
}

arp_scan() {
  log "Running ARP scan on $iface..."
  sudo arp-scan --interface="$iface" --localnet
}

channel_hop() {
  log "Channel hopping on $iface..."
  for ch in {1..13}; do
    sudo iwconfig "$iface" channel "$ch"
    sleep 1
  done
}

mac_recon() {
  log "Scanning for ghost MACs..."
  sudo arp-scan --interface="$iface" --localnet | grep -i random
}

signal_strength() {
  log "Scanning SSIDs & signal levels..."
  sudo iwlist "$iface" scan | grep -E "ESSID|Signal level"
}

dkms_check() {
  log "Checking DKMS modules..."
  sudo dkms status | grep -i 88XXau
}

usb_check() {
  log "Checking USB adapters..."
  lsusb | grep -Ei 'Realtek|Alfa'
}

header_fix() {
  log "Validating kernel headers ($KERNEL_VERSION)..."
  if ! dpkg -s "$HEADER_PKG" &>/dev/null; then
    sudo apt update && sudo apt install -y "$HEADER_PKG"
  fi
}

driver_build() {
  log "Building RTL8812AU driver..."
  [ -d "$DRIVER_DIR" ] || git clone "$REPO"
  cd "$DRIVER_DIR" || return
  make clean && make && sudo make install
}

port_scan() {
  log "Port scanning ARP targets..."
  targets=$(sudo arp-scan --interface="$iface" --localnet | awk '/^[0-9]/{print $1}')
  for ip in $targets; do
    sudo nmap -Pn -sT "$ip"
  done
}

clone_mac() {
  log "Cloning MAC from nearby host..."
  target_mac=$(sudo arp-scan --interface="$iface" --localnet | awk '/^[0-9]/{print $2; exit}')
  sudo ifconfig "$iface" down
  sudo macchanger -m "$target_mac" "$iface"
  sudo ifconfig "$iface" up
}

vuln_signature() {
  log "Fingerprinting for vulnerabilities..."
  targets=$(sudo arp-scan --interface="$iface" --localnet | awk '/^[0-9]/{print $1}')
  for ip in $targets; do
    sudo nmap -O "$ip"
  done
}

packet_counter() {
  log "Counting packets on $iface for 10s..."
  sudo timeout 10 tcpdump -i "$iface" -nn -c 100 2>/dev/null | wc -l
}

preset_stealth() {
  log "Running Stealth Sweep preset..."
  enable_monitor_mode
  channel_hop
  arp_scan
  mac_recon
  disable_monitor_mode
}

# ─────────────────────────────────────────────────────────────
# Advanced Modules
self_update() {
  log "Checking for updates..."
  [ -d .git ] && git fetch && git status -uno | grep -q behind && git pull
}

install_daemon() {
  log "Installing daemon service..."
  sudo tee /etc/systemd/system/cyberx.service > /dev/null <<EOF
[Unit]
Description=CyberShell ReconX Daemon
After=network.target

[Service]
ExecStart=$INSTALL_PATH --daemon
Restart=always

[Install]
WantedBy=multi-user.target
EOF
  sudo systemctl daemon-reload
  sudo systemctl enable --now cyberx.service
}

rogue_ap() {
  log "Launching deauth flood on $iface..."
  sudo aireplay-ng --deauth 0 -a FF:FF:FF:FF:FF:FF "$iface" &
}

handshake_capture() {
  log "Capturing WPA handshakes on $iface..."
  sudo airodump-ng --write "$HOME/CyberReconX/handshake" "$iface"
}

victim_profiling() {
  log "Profiling clients & APs..."
  sudo airodump-ng --output-format csv --write /tmp/ghostmap "$iface"
}

stealth_cleanup() {
  log "Performing stealth cleanup..."
  rm -rf /tmp/* "$LOG_DIR"/*.log
  perm_mac=$(macchanger -s "$iface" | awk '/Permanent/{print $3}')
  sudo ip link set "$iface" down
  sudo macchanger -m "$perm_mac" "$iface"
  sudo ip link set "$iface" up
}

# ─────────────────────────────────────────────────────────────
# CLI Menus

main_menu() {
  while true; do
    echo ""
    echo "⚡ CYBERX v4.3 — Darkstorm Main Menu"
    echo "[1] Black Box Operations"
    echo "[2] Alfa Adapter Operations"
    echo "[3] Offensive Toolkit"
    echo "[4] Advanced Modules"
    echo "[0] Exit"
    read -rp "Select option: " main_choice
    case "$main_choice" in
      1) menu_blackbox ;;
      2) menu_alfa ;;
      3) menu_offensive ;;
      4) menu_advanced ;;
      0) break ;;
      *) echo "❌ Invalid selection." ;;
    esac
  done
}

menu_blackbox() {
  echo ""
  echo "🧪 Black Box Operations — Interface: $iface"
  echo "[1] Enable Monitor Mode"
  echo "[2] Disable Monitor Mode"
  echo "[3] MAC Spoof"
  echo "[4] ARP Scan"
  echo "[5] DKMS Check"
  echo "[6] Interface Reset"
  echo "[7] Channel Hopper"
  echo "[8] Ghost MAC Recon"
  echo "[9] Signal Strength Scan"
  echo "[10] View Log Tail"
  echo "[11] Export Log Snapshot"
  echo "[0] Back"
  read -rp "Select action: " choice
  case "$choice" in
    1) enable_monitor_mode ;;
    2) disable_monitor_mode ;;
    3) mac_spoof ;;
    4) arp_scan ;;
    5) dkms_check ;;
    6) iface_reset ;;
    7) channel_hop ;;
    8) mac_recon ;;
    9) signal_strength ;;
    10) tail -n 20 "$LOG_FILE" ;;
    11) cp "$LOG_FILE" "$EXPORT_DIR/log_$(date '+%Y%m%d-%H%M%S').log" ;;
    0) return ;;
    *) echo "❌ Invalid action." ;;
  esac
}

menu_alfa() {
  echo ""
  echo "🔧 Alfa Adapter Operations — Interface: $iface"
  echo "[1] Check USB & Kernel Headers"
  echo "[2] Build & Install RTL8812AU Driver"
  echo "[0] Back"
  read -rp "Select action: " choice
  case "$choice" in
    1) usb_check; header_fix ;;
    2) driver_build ;;
    0) return ;;
    *) echo "❌ Invalid action." ;;
  esac
}

menu_offensive() {
  echo ""
  echo "💣 Offensive Toolkit — Interface: $iface"
  echo "[1] Port Scan ARP Targets"
  echo "[2] Clone MAC from Nearby Host"
  echo "[3] Vulnerable Host Detection"
  echo "[4] Passive Packet Counter"
  echo "[5] Stealth Sweep Preset"
  echo "[0] Back"
  read -rp "Select action: " choice
  case "$choice" in
    1) port_scan ;;
    2) clone_mac ;;
    3) vuln_signature ;;
    4) packet_counter ;;
    5) preset_stealth ;;
    0) return ;;
    *) echo "❌ Invalid action." ;;
  esac
}

menu_advanced() {
  echo ""
  echo "🚀 Advanced Modules — Interface: $iface"
  echo "[1] Self-Update"
  echo "[2] Install Daemon Service"
  echo "[3] Rogue AP & Deauth"
  echo "[4] Handshake Capture"
  echo "[5] Victim Profiling"
  echo "[6] Stealth Cleanup"
  echo "[0] Back"
  read -rp "Select action: " choice
  case "$choice" in
    1) self_update ;;
    2) install_daemon ;;
    3) rogue_ap ;;
    4) handshake_capture ;;
    5) victim_profiling ;;
    6) stealth_cleanup ;;
    0) return ;;
    *) echo "❌ Invalid action." ;;
  esac
}

# ─────────────────────────────────────────────────────────────
# Launch Sequence
banner
log "CYBERX Recon v4.3 initialized — Kernel: $KERNEL_VERSION"
iface_selector
main_menu
clear
