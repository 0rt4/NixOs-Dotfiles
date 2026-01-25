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
    
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Apps Individuales
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @inputs:  # Solo necesitas nixpkgs aquí
  let
    # Overlay compartido por todos los hosts
    sharedOverlays = [
      (final: prev: {
        unstable = prev.unstable or {} // {
          zen-browser = inputs.zen-browser.packages.${prev.stdenv.hostPlatform.system}.default;
        };
      })
    ];
    
    mkNixosConfig = hostName: system: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/${hostName}
        ({ pkgs, lib, ... }: {
          nixpkgs.overlays = sharedOverlays;
        })
      ];
    };

  in {
    nixosConfigurations = {
      Syntek-dev = mkNixosConfig "Syntek-dev" "x86_64-linux";
      Neuromancer = mkNixosConfig "Neuromancer" "x86_64-linux";
    };
  };
}
