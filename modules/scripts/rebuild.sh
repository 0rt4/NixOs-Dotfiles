#!/usr/bin/env bash
# Script para rebuild rápido sin actualizar flake.lock

set -e

FLAKE_DIR="${FLAKE_DIR:-/etc/nixos}"
HOSTNAME="${HOSTNAME:-nixos}"

echo "🔄 Reconstruyendo NixOS..."
echo "📁 Directorio: $FLAKE_DIR"
echo "💻 Hostname: $HOSTNAME"

cd "$FLAKE_DIR"

# Rebuild del sistema sin actualizar
echo "🔨 Aplicando cambios..."
sudo nixos-rebuild switch --flake ".#$Omen-Laptop"

echo "✅ Rebuild completado!"
