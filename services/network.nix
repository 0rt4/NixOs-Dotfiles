{ config, pkgs, lib, ... }:

{
  # NetworkManager
  networking.networkmanager.enable = true;

  # Habilitar Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  # Blueman (gestor gráfico de Bluetooth)
  #services.blueman.enable = true;

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
    # Para KDE Connect (si lo usas)
    # allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    # allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  };

  # DNS
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  # Paquetes de red
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    wireguard-tools
  ];
}
