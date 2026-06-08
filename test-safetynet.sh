#!/system/bin/sh
# test-safetynet.sh - Basic Root Detection Check
echo "========================================"
echo "  Basic Root Detection Check"
echo "========================================"
echo ""
echo "Checking for common root indicators..."
echo ""
RISK_FILES=(
    "/system/bin/su"
    "/system/xbin/su"
    "/data/data/com.topjohnwu.magisk"
    "/data/adb/magisk"
)

DETECTED=0

for file in "${RISK_FILES[@}"; do
    if [ -e "$file" ]; then
        echo "[FAIL] Detected: $file"
        DETECTED=1
    else
        echo "[PASS] Not found: $file"
    fi
done



echo ""
if [ $DETECTED -eq 0 ]; then
    echo "RESULT: Basic root indicators are HIDDEN."
    echo "NOTE: This does NOT guarantee passing Play Integrity."
    echo "Modern apps use advanced detection (kernel, memory checks)."
else
    echo "RESULT: Root indicators DETECTED."
    echo "Your install.sh script may not have worked or was reverted."
fi
echo ""