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
    lazygit
    grim
    slurp
    pavucontrol
    calcurse
    wlrctl
    
    
    wget
    git
    curl
    jq
        
  # === Aplicaciones extras ===
    evince
    gparted
    loupe
    steam
    vesktop
    
    mpv
    nautilus
    
    bitwarden-desktop
    unstable.zen-browser
    
    vscode
    gitkraken
    # iconos
    colloid-icon-theme
  ];
}
