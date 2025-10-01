#!/usr/bin/env bash
set -e

# Variables
QCAD_URL="https://www.qcad.org/archives/qcad/qcad-3.29.4-trial-linux-x86_64.run"
INSTALL_DIR="/opt/qcad"
DESKTOP_FILE="/usr/share/applications/qcad.desktop"

echo "==> Downloading QCAD..."
wget -O /tmp/qcad.run "$QCAD_URL"

echo "==> Making installer executable..."
chmod +x /tmp/qcad.run

echo "==> Running installer..."
sudo mkdir -p "$INSTALL_DIR"
sudo /tmp/qcad.run --noexec --target "$INSTALL_DIR"
sudo ln -sf "$INSTALL_DIR/qcad" /usr/local/bin/qcad

echo "==> Creating desktop entry..."
cat <<EOF | sudo tee "$DESKTOP_FILE"
[Desktop Entry]
Version=1.0
Type=Application
Name=QCAD
Exec=/usr/local/bin/qcad
Icon=$INSTALL_DIR/qcad_icon.png
Categories=Graphics;Engineering;
Terminal=false
EOF

echo "==> Done! Run 'qcad' or use your application menu."
