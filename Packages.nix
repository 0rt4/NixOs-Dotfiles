{ config, pkgs, ... }:

{
  # + Acceso a Todos los paquetes privados
  nixpkgs.config.allowUnfree = true;

  # + Paquetes instalados en Multiusuario
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ghostty
    steam
    git
    librewolf-bin
    bitwarden-desktop
    # - Paquetes de objetos graficos (iconos, mouse)    

  ];

  # Enable CUPS to print documents.
  services.printing.enable = false;


}
