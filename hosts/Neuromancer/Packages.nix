{ config, pkgs, inputs, ... }:

{
  # Paquetes del sistema
  environment.systemPackages = with pkgs; [

  # === CLI Tools ===
    direnv # Gestión de entornos
    
  # === Terminal ===
    helix
    ghostty
    starship
    
    duf
    eza        # ls moderno con iconos
    ncdu       # analizador de disco interactivo
    btop       # monitor de sistema completo 
    yazi       # file manager TUI
    ripgrep    # grep rápido
    fd         # find mejorado
    zoxide     # cd inteligente
    
    wget
    git
    curl
    jq
    
    
  # === Aplicaciones extras ===
    #evince
    #gparted
    #loupe
    #mpv
    #nautilus
    steam
    mpv
    
    bitwarden-desktop
    unstable.zen-browser
    
    vscode
  ];
}
