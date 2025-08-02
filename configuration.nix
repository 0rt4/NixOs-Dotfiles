# Cada configuracion de Nix esta distribuida en sus
# respectivos archivos de configuración para mejorar
# su lectura

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix #  hardware scan.
      ./Video-Drivers.nix # Drivers (Nivida)
      ./Sound-Drivers.nix # Drivers (Pipewire)
      ./Enviroment/Desktops-Enviroments.nix # Entorno de Escritorio y sus parametros
      ./Network.nix # Network (Wifi, FIrewall, Conexiones SSH, VNC)
      ./Packages.nix # Paquetes instalados en el sistema
      ./Users.nix # Usuarios y paquetes instalados individualmente
      ./Region-Language.nix # Configuracion de idioma y teclado
    ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #Configuraciones Experimentales
  nix.settings.experimental-features = [ "nix-command" "flakes" ];   
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
