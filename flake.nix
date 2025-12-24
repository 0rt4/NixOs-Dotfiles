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

    flake-parts.url = "github:hercules-ci/flake-parts";
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # Herramientas especiales
    #quickshell = {
    #  url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    # Apps Individuales
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser,flake-parts, ... } @inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = { # Hosts
      omen-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/omen-laptop  

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.backupFileExtension = "backup";
            home-manager.users.orta = { inputs, ... }: {
              imports = [
                ./home/orta
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
      
      syntek-dev = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/syntek-dev  
          
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.backupFileExtension = "backup";
            home-manager.users.orta = { inputs, ... }: {
              imports = [
                ./home/orta
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
      
      neuromancer = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/neuromancer  

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.backupFileExtension = "backup";
            home-manager.users.orta = { inputs, ... }: {
              imports = [
                ./home/orta # CONSIDERAR CAMBIAR EL USUARIO
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
