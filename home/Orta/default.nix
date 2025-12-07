{ config, pkgs, inputs, ... }:

{
  imports = [
    ./packages.nix
    ./programs
    ./themes
  ];

  # ===== CONFIGURACIÓN BÁSICA DE USUARIO =====
    home = {
      username = "Orta";
      homeDirectory = "/home/Orta";
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
			SHELL = "${pkgs.fish}/bin/fish";
    };
}
