{
  description = "NixOS Configuration";

  inputs = {
    # Indispensables
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktops Managers
    #plasma-manager = {
    #  url = "github:pjones/plasma-manager";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};


    # Herramientas especiales
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Apps Individuales
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser,... }@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      Omen-Laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/Omen-Laptop  

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.backupFileExtension = "backup";
            home-manager.users.Orta = { inputs, ... }: {
              imports = [
                ./home/Orta
              ];
            };
          }

          # Overlay para flakes
          ({ pkgs, lib, ... }: {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = prev.unstable or {} // {
                  zen-browser = inputs.zen-browser.packages.${system}.default;
                };
              })
            ];
          })
        ];
      };
    };
  };
}
