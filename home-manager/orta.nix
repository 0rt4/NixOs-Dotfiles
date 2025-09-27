{ config, pkgs, quickshell, caelestia-shell }:
{
  imports = [
    ./Desktops-Envs/gnome.nix
    ./Desktops-Envs/hyprland.nix
    caelestia-shell.homeManagerModules.default
  ]; 
  
  # ===== CONFIGURACIÓN BÁSICA DE USUARIO =====
  home.username = "orta";
  home.homeDirectory = "/home/orta";
  home.stateVersion = "25.05";
  
  # ===== CURSOR Y FUENTES PERSONALIZADAS =====
  fonts.fontconfig.enable = true;
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
  
  # ===== PAQUETES =====
  home.packages = with pkgs; [
    code-cursor
    helix
    steam
    thunderbird
    spicetify-cli
    spotify
    obsidian
    stremio
    librewolf-bin
    google-chrome
    bitwarden-desktop
    
    # Fuentes
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.meslo-lg
    inter
    fira-code
    jetbrains-mono
    
    # shell
    quickshell.packages.${pkgs.system}.default
  ];
  
  # ===== SHELL ZSH =====
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = false;
    initExtra = ''
      # Cargar Powerlevel10k
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      # Ejecutar Fastfetch al iniciar la terminal (si está instalado)
      if command -v fastfetch >/dev/null 2>&1; then
          fastfetch
      fi
    '';
  };
  
  home.sessionVariables = {
    QML2_IMPORT_PATH = "${quickshell.packages.${pkgs.system}.default}/lib/qt-6/qml";
  };
  
  # ===== GTK =====
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
