{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

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
  
  #services.blueman.enable = true;

  networking.firewall.enable = true;

  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  
  networking.firewall.allowedUDPPortRanges = [
  { from = 50000; to = 60000; } # Common Discord UDP range
];
}
