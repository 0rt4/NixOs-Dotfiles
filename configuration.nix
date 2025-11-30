{ config, pkgs, lib, ... }:

{
  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking
  networking.hostName = "nixos"; # Cambia esto por tu hostname

  # Zona horaria y localización
  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "es_MX.UTF-8";
  
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_MX.UTF-8";
    LC_IDENTIFICATION = "es_MX.UTF-8";
    LC_MEASUREMENT = "es_MX.UTF-8";
    LC_MONETARY = "es_MX.UTF-8";
    LC_NAME = "es_MX.UTF-8";
    LC_NUMERIC = "es_MX.UTF-8";
    LC_PAPER = "es_MX.UTF-8";
    LC_TELEPHONE = "es_MX.UTF-8";
    LC_TIME = "es_MX.UTF-8";
  };

  # Usuarios
  users.users.orta = {
    isNormalUser = true;
    description = "Christopher Orta";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
  };

  # Permitir paquetes unfree
  nixpkgs.config.allowUnfree = true;

  # Habilitar flakes y comando nix experimental
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Garbage collection automático
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Paquetes del sistema base
  environment.systemPackages = with pkgs; [
    wget
    git
    curl
    unzip
    zip
  ];

  # OpenSSH (opcional)
  # services.openssh.enable = true;

  # Firewall
  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [ ];
    # allowedUDPPorts = [ ];
  };
  
  programs.steam.enable = true;
  
  # No cambiar esto sin entender las implicaciones
  system.stateVersion = "24.11";
}
