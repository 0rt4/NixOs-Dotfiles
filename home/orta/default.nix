{ config, pkgs, inputs, ... }:

{
  imports = [
    ./packages.nix
    ./programs
    ./themes
  ];

  # ===== CONFIGURACIÓN BÁSICA DE USUARIO =====
    home = {
      username = "orta";
      homeDirectory = "/home/orta";
      stateVersion = "25.05";
    };

    # Git config
    programs.git.settings = {
      enable = true;
      userName = "Tu Nombre";
      userEmail = "tu@email.com";
    };

    # Variables de entorno
    home.sessionVariables = {
      EDITOR = "helix";
      # SHELL = "${pkgs.zsh}/bin/zsh";
    };

    # ===== SHELL ZSH =====
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh.enable = false;
      initContent = ''
        # Cargar Powerlevel10k
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        # Ejecutar Fastfetch al iniciar la terminal (si está instalado)
        if command -v fastfetch >/dev/null 2>&1; then
            fastfetch
        fi
      '';
    };
}