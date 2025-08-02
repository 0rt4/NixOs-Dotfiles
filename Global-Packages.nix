{ config, pkgs, ... }:

{
  # + Acceso a Todos los paquetes privados
  nixpkgs.config.allowUnfree = true;

  # + Paquetes instalados en Multiusuario
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ghostty 
    zsh
    steam
    git
    librewolf-bin
    bitwarden-desktop
    # - Paquetes de objetos graficos (iconos, mouse)    

  ];
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  
  # Enable CUPS to print documents.
  services.printing.enable = false;


}
