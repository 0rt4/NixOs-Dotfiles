{ config, pkgs, ... }:

{
  # Paquetes globales disponibles para todos los usuarios
  environment.systemPackages = with pkgs; [
    # Componentes esenciales de Hyprland
    hyprland
    hypridle
    hyprlock
    hyprpicker
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    polkit_gnome
    
    # Clipboard / utilidades
    cliphist
    inotify-tools
    app2unit
    
    # Interfaz
    mako
    conky

    # Terminal / CLI
    starship
    fastfetch
    btop
    jq
    eza
    trash-cli
    ghostty 
    zsh

    # Apariencia / temas
    adw-gtk3 
    papirus-icon-theme
    libsForQt5.qt5ct
    kdePackages.qt6ct

    #Aplicaciones Extras indispensables
    git
    gitkraken
    onlyoffice-bin
    syncthing
  ];
}

