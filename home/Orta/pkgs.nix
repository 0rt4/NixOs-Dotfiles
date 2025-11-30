{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Navegadores
    google-chrome
    unstable.zen-browser
    bitwarden-desktop
    
    # Terminal
    #alacritty
    #kitty
    ghostty
    
    # Multimedia
    #vlc
    #spotify
    steam
    
    # Archivos
    # file-roller
    nautilus
    
    # Comunicación
    # discord
    # telegram-desktop
    
    # Productividad
    # obsidian
    # notion
    
    # Herramientas de sistema
    # gparted
    # timeshift

		# Programas en terminal:
    ncdu
    btop
    lsd
    yazi
    fzf
    # Añade aquí más paquetes según necesites
  ];
}
