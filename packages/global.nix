{ config, pkgs, ... }:

{
  # + Acceso a Todos los paquetes privados
  nixpkgs.config.allowUnfree = true;

  # + Paquetes instalados en Multiusuario
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ghostty 
    zsh
    code-cursor
    steam
    git
    librewolf-bin
    google-chrome
    bitwarden-desktop
    github-desktop
    # - Paquetes de objetos graficos (iconos, mouse)    

  ];
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  
  # Enable CUPS to print documents.
  services.printing.enable = false;
}
