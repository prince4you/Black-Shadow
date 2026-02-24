
#!/data/data/com.termux/files/usr/bin/bash
# ─────────── BLACK SHADOW TERMUX AUTO INSTALL ───────────

# Banner
echo "==============================="
echo "    BLACK SHADOW AUTO INSTALL"
echo "==============================="

# Variables
REPO_LIST="$PREFIX/etc/apt/sources.list.d/prince.list"
REPO_URL="https://raw.githubusercontent.com/prince4you/Black-Shadow/main"
PUBLIC_KEY_URL="https://raw.githubusercontent.com/prince4you/Black-Shadow/main/public.key"
SETUP_SCRIPT_URL="https://raw.githubusercontent.com/prince4you/Black-Shadow/main/Setup.sh"
KEYRING="$PREFIX/etc/apt/trusted.gpg.d/blackshadow.gpg"

# 1️⃣ Add repo to sources.list.d
if [ ! -f "$REPO_LIST" ]; then
    echo "[*] Adding Black Shadow repo..."
    echo "deb [trusted=yes arch=all] $REPO_URL termux main" > "$REPO_LIST"
else
    echo "[*] Repo already exists in sources.list.d"
fi

# 2️⃣ Download & import public key (modern keyring)
echo "[*] Importing public key..."
mkdir -p "$PREFIX/etc/apt/trusted.gpg.d"
if curl -sLo /tmp/public.key "$PUBLIC_KEY_URL"; then
    gpg --no-default-keyring --keyring "$KEYRING" --import /tmp/public.key
    rm /tmp/public.key
    echo "[✓] Public key imported successfully"
else
    echo "[!] Failed to download public key. Please check URL."
fi

# 3️⃣ Update packages
echo "[*] Updating package lists..."
pkg update -y

# 4️⃣ Download & run Setup.sh if exists
echo "[*] Running repo Setup.sh..."
if curl -sLo /tmp/Setup.sh "$SETUP_SCRIPT_URL"; then
    chmod +x /tmp/Setup.sh
    bash /tmp/Setup.sh
    rm /tmp/Setup.sh
    echo "[✓] Setup.sh executed successfully"
else
    echo "[!] Failed to download Setup.sh. Please check URL."
fi

# 5️⃣ Finish
echo "==============================="
echo "   BLACK SHADOW SETUP COMPLETE"
echo "==============================="
