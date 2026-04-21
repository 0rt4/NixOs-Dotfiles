{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # === Terminal ===
    bottom
    duf
    eza # ls moderno con iconos
    ncdu # analizador de disco interactivo
    yazi # file manager TUI
    ripgrep # grep rápido
    fd # find mejorado
    zoxide # cd inteligente
    lazygit
    #grim
    #slurp
    #pavucontro|l
    #calcurse
    #wlrctl #Para scripts de pantalla

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
    nautilus
    faugus-launcher
    onlyoffice-desktopeditors

    bitwarden-desktop
    unstable.zen-browser

    # Desarollo
    ghostty
    starship
    helix
    gitkraken
    vscode
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Opcional: Abre puertos para Steam Remote Play
    #dedicatedServer.openFirewall = true; # Opcional: Abre puertos para Source Dedicated Server
  };

  programs.fish.enable = true;
  programs.starship.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.gpu-screen-recorder.enable = true;

#services.mysql = {
#  enable = true;
#  package = pkgs.mysql80;
#};


}
