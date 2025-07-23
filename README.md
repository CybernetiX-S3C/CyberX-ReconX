# ⚡ CYBERSHELL RECONX v2.5
**CyberX Tactical Recovery Suite**  
Resurrect Realtek RTL8812AU Adapters • Diagnose Interfaces • Secure Your Stack  
Crafted by **John Poli Modica** of **CybernetiX S3C**

---

## 🧠 Overview

CyberShell ReconX is a command-line recovery and diagnostics suite built for Kali Linux systems using **RTL8812AU-based Alfa adapters**. It automates driver installation, kernel header validation, and interface scanning — ideal for post-upgrade resurrection when wireless goes dark.

---

## 🔧 Features

| Module         | Description                                                    |
|----------------|----------------------------------------------------------------|
| ⚙️ DriverForge   | Build and install 88XXau drivers from Aircrack-ng source      |
| 📦 HeaderFix    | Auto-install matching kernel headers based on `uname -r`       |
| 🔌 USBCheck     | Detect connected Alfa/Realtek adapters via `lsusb`             |
| 🌐 InterfaceScan| Show network interfaces & wireless diagnostics                 |
| 📄 LogVault     | Time-stamped logs for audit and troubleshooting                |
| 💡 RecoveryHint | Manual modprobe and interface restart command tips             |

---

## 🚀 Quick Start

```bash
chmod +x CyberX_Recon.sh
sudo ./CyberX_Recon.sh
