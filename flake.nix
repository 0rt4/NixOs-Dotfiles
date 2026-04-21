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
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ambxst = {
      url = "github:Axenide/Ambxst";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Apps Individuales
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      # Overlay compartido por todos los hosts
      sharedOverlays = [
        (final: prev: {
          unstable = prev.unstable or { } // {
            zen-browser =
              inputs.zen-browser.packages.${prev.stdenv.hostPlatform.system}.default;
          };

          # --- PARCHE PARA ILLOGICAL-FLAKE ---
          # Esto soluciona el error 'python-magic not installed' en Python 3.13
          pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
            (python-final: python-prev: {
              kde-material-you-colors =
                python-prev.kde-material-you-colors.overridePythonAttrs
                (oldAttrs: {
                  dependencies = (oldAttrs.dependencies or [ ])
                    ++ [ python-final.python-magic ];
                });
            })
          ];
          # -----------------------------------
        })
      ];

      mkNixosConfig = hostName: system:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/${hostName}
            ({ pkgs, lib, ... }: {
              nixpkgs.overlays = sharedOverlays;

              # Requisito para illogical-flake a nivel de sistema
              programs.dconf.enable = true;
            })
          ];
        };

    in {
      nixosConfigurations = {
        Main = mkNixosConfig "Main" "x86_64-linux";
        #DevWorkstation = mkNixosConfig "DevWorkstation" "x86_64-linux";
      };
    };
}
