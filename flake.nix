{
  description = "Configuración de NixOS con Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";  # Usa la misma versión de nixpkgs
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {  # Cambia "nixos" por tu hostname (`hostname`)
      system = "x86_64-linux";
      modules = [
        ./configuration.nix  # Tu configuración actual de NixOS
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.orta = import ./home.nix;  # Cambia "orta" por tu usuario
        }
      ];
    };
  };
}
