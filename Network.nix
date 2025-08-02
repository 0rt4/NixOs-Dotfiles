{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;  # NetworkManager gestionará WiFi

  # Configura redes WiFi directamente en NetworkManager (no en networking.wireless)
  environment.etc."NetworkManager/system-connections/Bolillo_Premium_Extra_Crujient_.nmconnection" = {
    text = ''
      [connection]
      id=Bolillo_Premium_Extra_Crujient_
      type=wifi

      [wifi]
      mode=infrastructure
      ssid=Bolillo_Premium_Extra_Crujient_

      [wifi-security]
      key-mgmt=wpa-psk
      psk=dTDh7Z9cmGXbEAX

      [ipv4]
      method=auto

      [ipv6]
      addr-gen-mode=stable-privacy
      method=auto
    '';
    mode = "0600";  # Permisos seguros
  };

  # + Abrir puertos de Firewall
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # + Desactivarlos todos de una
  # networking.firewall.enable = false;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
  # + Configuración de SSH
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # + Configuración de proxis
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


}
