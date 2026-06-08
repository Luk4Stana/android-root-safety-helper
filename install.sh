#!/system/bin/sh
# install.sh - Android Root Safety Helper
# WARNING: Run with root privileges only, else it won't work.
echo "========================================"
echo "  Android Root Safety Helper Installer"
echo "========================================"
echo ""
# Check for root
if [ "$(id -u)" != "0" ]; then
    echo "ERROR: Root access is required to run this script."
    echo "Usage: su -c 'sh install.sh'"
    exit 1
fi
echo "[*] Root access confirmed."
echo ""
# Define paths to hide
HIDE_PATHS=(
    "/system/bin/su"
    "/system/xbin/su"
    "/data/data/com.topjohnwu.magisk"
    "/data/adb/magisk"
    "/data/adb/magisk_busybox"
    "/data/local/tmp/test-key"
)
# Define fake content (empty or harmless)
create_fake_file() {
    local path=$1
    local dir=$(dirname "$path")
    if [ -e "$path" ]; then
        echo "[*] Attempting to hide: $path"
        # Create a temporary file to mount over (empty file)
        local temp_file="/data/local/tmp/safety_hide_$(echo $path | sed 's/[^a-zA-Z0-9]/_/g')"
        touch "$temp_file"
        
        # Mount the empty file over the target (overmount)
        # This makes the original file inaccessible while the device is on
        mount --bind "$temp_file" "$path"
        echo "    -> Mounted dummy file over $path"
        
        # Save cleanup command for uninstall
        echo "umount '$path'" >> /data/local/tmp/safety_cleanup.sh
        echo "rm '$temp_file'" >> /data/local/tmp/safety_cleanup.sh
    else
        echo "[*] Path not found (skipping): $path"
    fi
}
echo "[*] Starting protection mechanisms..."
echo ""
for path in "${HIDE_PATHS[@}"; do
    create_fake_file "$path"
done
# Fnsh
echo ""
echo "========================================"
echo "  Installation Complete!"
echo "========================================"
echo ""
echo "IMPORTANT:"
echo "1. This bypass is TEMPORARY and will reset on reboot."
echo "2. Many modern apps detect root via other methods (Zygote, kernel checks)."
echo "3. For permanent solutions, consider using Magisk Hide or KernelSU."
echo ""
echo "To uninstall and restore original files, run:"
echo "  su -c 'sh /data/local/tmp/safety_cleanup.sh' (if created) or simply reboot."
echo "  Or use the provided uninstall.sh script if you saved it."
echo ""
echo "To test if you passed SafetyNet/Play Integrity:"
echo "  Run the test-safetynet.sh script (requires internet)."