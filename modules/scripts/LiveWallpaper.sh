#!/usr/bin/env bash

DIR="/home/orta/Vídeos/wallpapers"
MONITOR="eDP-1"

# Verificar que el directorio existe
if [ ! -d "$DIR" ]; then
    echo "Error: El directorio $DIR no existe"
    exit 1
fi

# Crear playlist temporal mezclada
PLAYLIST=$(mktemp)
find "$DIR" -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.webm" \) | shuf > "$PLAYLIST"

# Verificar que la playlist no está vacía
if [ ! -s "$PLAYLIST" ]; then
    echo "Error: No se encontraron videos en $DIR"
    rm -f "$PLAYLIST"
    exit 1
fi

echo "Reproduciendo $(wc -l < "$PLAYLIST") videos en $MONITOR"

# Reproducir playlist infinita
mpvpaper -o "--no-osd-bar --really-quiet --auto-pause --loop-playlist=inf --playlist=$PLAYLIST" "$MONITOR" "$PLAYLIST"

# Limpiar archivo temporal cuando mpvpaper termine
rm -f "$PLAYLIST"
