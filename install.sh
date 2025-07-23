#!/bin/bash

echo "🔧 Installing CyberShell ReconX v3.2 (CYBERX)..."

MAIN_SCRIPT="CyberX_Recon.sh"
TARGET_CMD="/usr/local/bin/cyberx"

# 📦 Required Packages
deps=(git make dkms macchanger arp-scan iw iproute2 usbutils dialog)

echo "📥 Checking dependencies..."
for pkg in "${deps[@]}"; do
    if ! dpkg -s "$pkg" &>/dev/null; then
        echo "📦 Installing missing: $pkg"
        sudo apt install -y "$pkg"
    else
        echo "✅ $pkg already installed"
    fi
done

# 🧩 Validate Main Script
if [ ! -f "$MAIN_SCRIPT" ]; then
    echo "❌ Error: $MAIN_SCRIPT not found in current directory."
    echo "Place your script as $MAIN_SCRIPT and rerun installer."
    exit 1
fi

# 🚀 Deploy Script Globally
sudo cp "$MAIN_SCRIPT" "$TARGET_CMD"
sudo chmod +x "$TARGET_CMD"

# 📂 Create ReconX Directories
mkdir -p "$HOME/CyberReconX/logs"
mkdir -p "$HOME/CyberReconX/export"

# ✅ Success Output
echo ""
echo "✅ Installation Complete!"
echo "🔗 CyberX now available as global command: cyberx"
echo "📁 Logs: $HOME/CyberReconX/logs"
echo "📁 Exports: $HOME/CyberReconX/export"
echo "🚀 Launch anytime via: sudo cyberx"
