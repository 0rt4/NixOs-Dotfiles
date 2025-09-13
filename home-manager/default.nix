{ config, pkgs, ... }:

{
  # ===== CONFIGURACIÓN BÁSICA DE USUARIO =====
  home.username = "orta";
  home.homeDirectory = "/home/orta";
  home.stateVersion = "25.05";
  
  # ===== ARCHIVOS PERSONALES =====
  #home.file = {
   # ".face".source = ./avatar.jpg;
    #".face.icon".source = ./avatar.jpg;
  #};
  
  # ===== FUENTE NERD FONT (FIERAZO PARA POWERLEVEL10K) =====
  fonts.fontconfig.enable = true;  # Necesario para que las aplicaciones detecten las fuentes
 home.packages = with pkgs; [
    # Fuentes Nerd Fonts individuales
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
 
    nerd-fonts.meslo-lg  # Intenta con este nombre
    # Otras fuentes
    inter
    fira-code
    jetbrains-mono
  ];
  
  # ===== CURSOR PERSONALIZADO =====
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
  
  # ===== SHELL ZSH =====
programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;

  # Desactivar oh-my-zsh si lo tenías (Powerlevel10k no lo necesita)
  oh-my-zsh.enable = false;

  initExtra = ''
    # Cargar Powerlevel10k
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

    # Configuración personalizada (generada interactivamente con `p10k configure`)
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  '';
};
  # ===== CONFIGURACIÓN GTK BÁSICA =====
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
