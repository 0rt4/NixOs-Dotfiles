{ config, pkgs, ... }:

{
  # NetworkManager para WiFi/Ethernet
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;  # Para nuevas features
      };
    };
  };
  services.blueman.enable = true;


  # Firewall
  networking.firewall = {
    enable = true;
    # Puertos abiertos si los necesitas
    # allowedTCPPorts = [ 22 80 443 ];
    # allowedUDPPorts = [ ];
  };

  # Configuración de redes WiFi (usa con cuidado, considera secrets)
  # IMPORTANTE: No pongas contraseñas en texto plano aquí
  # Mejor usa NetworkManager GUI o nmcli para conectar
  
  # Si necesitas redes específicas (ej. para auto-conectar):
  # networking.wireless = {
  #   enable = false;  # Usa NetworkManager en su lugar
  #   networks = {
  #     "NombreWiFi" = {
  #       pskRaw = "hash-generado-con-wpa_passphrase";
  #     };
  #   };
  # };

  # DNS
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  # Paquetes de red útiles
  environment.systemPackages = with pkgs; [
    networkmanagerapplet  # Applet de NetworkManager
    wireguard-tools       # Para VPNs
  ];
}