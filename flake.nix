{
  description = "Sistema NixOS con Quickshell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";  
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";  
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };

    caelestia-cli = {
      url = "github:caelestia-dots/cli";  

    };
  };

  outputs = { self, nixpkgs, home-manager, quickshell, caelestia-shell, caelestia-cli, ... }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit quickshell caelestia-shell; };

          home-manager.users.orta = import ./home-manager/orta.nix {
            inherit pkgs quickshell caelestia-shell;
          };
        }
      ];
    };
  };
}
