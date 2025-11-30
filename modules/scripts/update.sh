#!/usr/bin/env bash
# Script para actualizar NixOS desde flake

set -e

FLAKE_DIR="${FLAKE_DIR:-/etc/nixos}"  # ← Cambia aquí
HOSTNAME="${HOSTNAME:-nixos}"

echo "🚀 Actualizando NixOS desde flake..."
echo "📁 Directorio: $FLAKE_DIR"
echo "💻 Hostname: $HOSTNAME"

cd "$FLAKE_DIR"

# Actualizar flake.lock (necesita sudo porque /etc/nixos requiere permisos)
echo "📦 Actualizando inputs del flake..."
sudo nix flake update

# Rebuild del sistema
echo "🔨 Reconstruyendo el sistema..."
sudo nixos-rebuild switch --flake ".#$HOSTNAME"

echo "✅ Sistema actualizado exitosamente!"
