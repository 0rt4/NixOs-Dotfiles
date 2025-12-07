{
  description = "NixOS Configuration";

  inputs = {
<<<<<<< Updated upstream
		# Indispensables
    nixpkgs.url = 			"github:nixos/nixpkgs/nixos-unstable";
    home-manager = 		{ url = "github:nix-community/home-manager"; 									inputs.nixpkgs.follows = "nixpkgs"; };
		
		# Desktops Managers 
    niri = 						{	url = "github:sodiboo/niri-flake";														inputs.nixpkgs.follows = "nixpkgs"; };
    cosmic = 					{ url = "github:lilyinstarlight/nixos-cosmic"; 								inputs.nixpkgs.follows = "nixpkgs"; };

		# Heramientas especiales
    quickshell = 			{ url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";		inputs.nixpkgs.follows = "nixpkgs";};

		# Apps Individuales
    zen-browser = 			{ url = "github:0xc000022070/zen-browser-flake";								inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, nixpkgs, home-manager, niri, cosmic, zen-browser, ... }@inputs:
  let
    system = "x86_64-linux";  # ← DEFINIDA en let
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/laptop
          
=======
    # Indispensables
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktops Managers
    #niri = {
    #  url = "github:sodiboo/niri-flake";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

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
          ./hosts/Omen-Laptop/

>>>>>>> Stashed changes
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
<<<<<<< Updated upstream
            home-manager.users.orta = import ./home/orta;
          }

          # Overlay - usa la variable system
=======
            home-manager.backupFileExtension = "backup";
            home-manager.users.Orta = { inputs, ... }: {
              imports = [
                # 1. Importa el módulo plasma-manager
                #inputs.plasma-manager.homeManagerModules.plasma-manager #OPCION BETA, DESHABILITADO
                #niri.nixosModules.niri
                # 2. Importa tu configuración personal
                ./home/Orta
              ];
            };
          }

          # Overlay para zen-browser
>>>>>>> Stashed changes
          ({ pkgs, lib, ... }: {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = prev.unstable or {} // {
                  zen-browser = inputs.zen-browser.packages.${system}.default;
                };
              })
            ];
          })
<<<<<<< Updated upstream

          niri.nixosModules.niri
          cosmic.nixosModules.default
=======
>>>>>>> Stashed changes
        ];
      };
    };
  };
}
