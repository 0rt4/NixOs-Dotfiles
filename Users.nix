 { config, pkgs, ... }:

{
  # + Define usuarios en la computadora
   users.users.orta = {
    isNormalUser = true;
    description = "Christopher";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ #Paquetes individuales por usuario
    #  thunderbird
    ];
  };

    # + Habilitar Home Manager
  home-manager = {
    useGlobalPkgs = true;    # Usa los mismos pkgs que NixOS
    useUserPackages = true;  # Permite instalar paquetes para el usuario
    users.irta = {     # Reemplaza 'tu_usuario' con tu nombre de usuario
      imports = [ ./home.nix ];  # Ruta a tu configuración de Home Manager
    };
  };

  # + Necesario para que funcione
  programs.zsh.enable = true;  # O bash si usas bash
}
