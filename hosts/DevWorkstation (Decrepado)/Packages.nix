{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [

    inputs.noctalia.packages.${pkgs.system}.default

    # === Terminal ===
    helix
    ghostty
    starship

    duf
    eza # ls moderno con iconos
    ncdu # analizador de disco interactivo
    btop # monitor de sistema completo
    yazi # file manager TUI
    ripgrep # grep rápido
    fd # find mejorado
    zoxide # cd inteligente
    lazygit
    #grim
    #slurp
    #pavucontrol
    calcurse
    #wlrctl

    wget
    git
    curl
    jq

    # === Aplicaciones extras ===
    evince
    gparted
    loupe
    steam
    nautilus

    bitwarden-desktop
    unstable.zen-browser

    vscode
    gitkraken
     (python3.withPackages (ps: with ps; [
       pip
       virtualenv
       setuptools
       wheel
     ))
    pyright

    nodejs_22
    corepack_22
    typescript
  ];
}
