# ⚡ CYBERSHELL RECONX v4.3

**CyberX Tactical Recovery Suite**
Resurrect Realtek RTL8812AU Adapters • Diagnose Interfaces • Secure Your Stack
Crafted by **John Poli Modica** of **CybernetiX S3C**

<p align="center">
  <img src="https://github.com/CybernetiX-S3C/CyberX-ReconX/blob/main/logo.png?raw=true" width="400" alt="CyberX ReconX Logo">
</p>

[![Release: v4.3-Darkstorm](https://img.shields.io/badge/release-v4.3--Darkstorm-brightgreen?style=flat-square)](https://github.com/CybernetiX-S3C/CyberX-ReconX/releases/tag/v4.3-Darkstorm)
[![License: MIT](https://img.shields.io/badge/license-MIT-brightgreen)](LICENSE)
[![Shell](https://img.shields.io/badge/language-Bash-blue)](https://www.gnu.org/software/bash/)
[![Version](https://img.shields.io/badge/version-4.3--Darkstorm-critical)](#)
[![Built By](https://img.shields.io/badge/built--by-CybernetiX--S3C-purple)](https://github.com/CybernetiX-S3C)

```

╔════════════════════════════════════════════════════════╗
║  ▄█▀ ▀█▀ ▄█▄ ▄▀▀ ▄▀█ ▀█▀   ▄▀▀ ▄▀▀ ▄▀▀ ▄▀▄ ▄▀▄ ▄█▀ ▀█▀ ║
║  █▄▄ ░█░ █░█ ▀▄▄ █▀█ ░█░   ▀▄▄ ░▀▄ ▀▄▄ █░█ █░█ █▄▄ ░█░ ║
║                       ⚡ CYBERX ⚡                       ║
║          Version 4.3 — Codename: Darkstorm             ║
╚════════════════════════════════════════════════════════╝

````

---

## 📌 Overview

**CyberShell ReconX v4.3 (Darkstorm)** is a formidable command-line recovery and diagnostics suite meticulously engineered for Kali Linux systems. Its primary mission is to empower users with robust tools for managing and troubleshooting **RTL8812AU-based Alfa wireless adapters** and related network issues. ReconX automates critical processes such as:

* **Driver Installation:** Seamlessly builds and installs necessary drivers.
* **Kernel Header Validation:** Ensures system compatibility for wireless operations.
* **Interface Scanning & Diagnostics:** Provides deep insights into network interfaces and wireless environments.

It stands as an **essential solution for post-upgrade resurrection** when wireless connectivity goes dark, providing a beacon of light in times of network uncertainty.

While `CyberX ReconX` is a **standalone repository** designed for direct deployment and immediate use, it also functions as a **powerful, integrated module** within the [S3C Tactical Panel](https://github.com/CybernetiX-S3C/s3c-tactical-panel). This synergy allows users of the S3C Tactical Panel to launch `CyberX ReconX` directly from its interface, extending its already comprehensive wireless repeater management capabilities with `CyberX ReconX`'s unparalleled diagnostic and recovery features.

---

## 🔧 Features

| Module                     | Description                                                                                             |
| :------------------------- | :------------------------------------------------------------------------------------------------------ |
| ⚙️ **DriverForge** | Builds and installs 88XXau drivers from the Aircrack-ng source, ensuring adapter functionality.         |
| 📦 **HeaderFix** | Automatically installs matching kernel headers based on `uname -r`, critical for driver compilation.    |
| 🔌 **USBCheck** | Detects connected Alfa/Realtek USB wireless adapters via `lsusb`, confirming hardware presence.         |
| 🌐 **InterfaceScan** | Displays detailed network interfaces and performs wireless diagnostics, including signal strength scans.  |
| 📜 **LogVault** | Creates time-stamped logs for audit and troubleshooting, storing them in a dedicated directory.         |
| 💡 **RecoveryHint** | Provides manual `modprobe` and interface restart command tips for advanced recovery.                   |
| 👻 **Ghost MAC Recon** | Scans for and identifies 'ghost' (randomized) MAC addresses on the local network.                       |
| 🕵️ **Stealth Sweep Preset** | Executes a sequence of operations (monitor mode, channel hop, ARP scan, MAC recon) for discreet network reconnaissance. |
| 💥 **Offensive Toolkit** | Includes functionalities like port scanning ARP targets, MAC cloning, and vulnerable host detection.      |
| 😈 **Advanced Modules** | Offers options for self-update, daemon installation, rogue AP attacks (deauth), handshake capture, and victim profiling. |
| 🧹 **Stealth Cleanup** | Performs aggressive cleanup of temporary files and logs, and restores the permanent MAC address of the interface. |

---

## 🚀 Quick Start

Clone the repository and run the `install.sh` script to deploy `CyberX ReconX` and register the `cyberx` command alias:

```bash
git clone [https://github.com/CybernetiX-S3C/CyberX-ReconX.git](https://github.com/CybernetiX-S3C/CyberX-ReconX.git)
cd CyberX-ReconX
chmod +x install.sh CyberX_Recon.sh
sudo ./install.sh
````

Once installed, launch `CyberX ReconX` from any terminal via:

```bash
sudo cyberx
```

-----

### 📁 Directory Structure

```
CyberX-ReconX/
├── CyberX_Recon.sh     # Main interactive panel interface and core functions
├── install.sh          # Installer and setup utility
├── .gitignore          # File exclusions
├── LICENSE             # MIT license
├── README.md           # Project documentation
└── logo.png            # CybernetiX S3C brand logo for the README
```

-----

### 🛠 Dependencies

Ensure these system packages are installed before deploying. The `install.sh` script will check for and optionally install missing dependencies:

  * `git` — version control system (for driver cloning and self-update)
  * `make` — build automation tool (for driver compilation)
  * `dkms` — Dynamic Kernel Module Support (for persistent driver installation)
  * `macchanger` — for MAC address spoofing and restoration
  * `arp-scan` — for ARP-based network scanning
  * `iw` — wireless configuration utility
  * `iproute2` — modern networking utilities (`ip` command)
  * `usbutils` — for listing USB devices (`lsusb`)
  * `dialog` — for basic interactive menus (if used by future iterations)
  * `nmap` — network scanner (for port scanning and vulnerability fingerprinting)
  * `tcpdump` — packet analyzer (for passive packet counting)
  * `flite` — voice engine (for audible confirmations in `install.sh`)

-----

### ⚠️ Disclaimer

CyberShell ReconX manipulates network interfaces and system services. Use in live environments with extreme caution. Administrator (root) privileges are required for most operations. Always test in isolated or virtualized conditions before rolling out to production networks. CybernetiX S3C is not responsible for any misuse or damage caused by this software.

-----

### ✒️ License

Licensed under the **MIT License**. Open to modification, reuse, and redistribution with attribution. No warranty expressed or implied.

-----

## 👥 Contributors

  * **John Poli Modica** – Creator, Architect, and Lead Developer
  * Powered by CybernetiX S3C

