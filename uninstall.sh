#!/system/bin/sh
# uninstall.sh - Restore original system state
echo "========================================"
echo "  Android Root Safety Helper Uninstaller"
echo "========================================"
echo ""
if [ "$(id -u)" != "0" ]; then
    echo "ERROR: Root access required."
    exit 1
fi

CLEANUP_SCRIPT="/data/local/tmp/safety_cleanup.sh"


if [ -f "$CLEANUP_SCRIPT" ]; then
    echo "[*] Running cleanup script..."
    sh "$CLEANUP_SCRIPT"
    rm "$CLEANUP_SCRIPT"
    echo "[*] Cleanup complete. System restored."
else
    echo "[*] No active cleanup script found."
    echo "[*] If you rebooted the device, the changes are already gone (as intended)."
    echo "[*] If you manually modified files, this script cannot help."
fi


echo ""
echo "Done."