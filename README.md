# android-root-safety-helper
Simple shell scripts to temporarily hide root indicators on Android (Educational use only).

**WARNING:** Educational tool only. Does NOT bypass modern Banking Apps, Google Wallet, or Play Integrity. Use at your own risk.

## What it does
Temporarily hides root indicators (`su`, Magisk paths) using memory mounts. **All changes are lost on reboot.**

## Usage
1. Download scripts to Android device.
2. Open Terminal (For example Termux/ADB/Kali Nethunter Shell) and gain root:
   ```bash
   su
--------------
Run installer:
   sh install.sh  
--------------
Test (optional):
sh test-safetynet.sh  
--------------
Uninstall:
Reboot your device. All modifications are memory-only and vanish instantly.
--------------
How it works:
Uses mount --bind to overlay empty files over root paths. No permanent system changes.
--------------
