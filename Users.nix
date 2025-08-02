 { config, pkgs, ... }:

{
  # + Define usuarios en la computadora
   users.users.orta = {
    isNormalUser = true;
    description = "Christopher";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ]; #Paquetes individuales por usuario
  };
}

