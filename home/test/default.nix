{ config, pkgs, inputs, ... }:

{
  imports = [
    ./App-settings.nix
  ];

  # ===== CONFIGURACIÓN BÁSICA DE USUARIO =====
    home = {
      username = "test";
      homeDirectory = "/home/test";
      stateVersion = "25.11";
    };

    # Git config
    programs.git.settings = {
      enable = true;
      userName = "0rt4";
      userEmail = "ortal.christopher@outlook.com";
    };

    # Variables de entorno
    home.sessionVariables = {
      EDITOR = "helix";
      SHELL = "${pkgs.fish}/bin/fish";
    };
}
