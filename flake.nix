{
  description = "NixOS Flake Configuration - Modular Setup";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    
    # Agregar qml-niri
    qml-niri = {
      url = "github:imiric/qml-niri";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, zen-browser, quickshell, qml-niri, ... }@inputs:
  let
    system = "x86_64-linux";
    
    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      } // {
        zen-browser = inputs.zen-browser.packages.${system}.default;
        quickshell = inputs.quickshell.packages.${system}.default;
      };
    };
    
    # Overlay para qml-niri
    overlay-qml-niri = final: prev: {
      qml-niri = prev.stdenv.mkDerivation {
        pname = "qml-niri";
        version = "unstable-2024-11-23";
        
        src = qml-niri;
        
        nativeBuildInputs = with prev; [
          cmake
          pkg-config
          qt6.wrapQtAppsHook
        ];
        
        buildInputs = with prev; [
          qt6.qtbase
          qt6.qtdeclarative
        ];
        
        cmakeFlags = [ "-DQT_VERSION_MAJOR=6" ];
        
        # El directorio build/ se crea automáticamente por CMake en /build/source/
        # No necesitamos crear un subdirectorio build/
        installPhase = ''
          runHook preInstall
          mkdir -p $out/lib/qt-6/qml
          # Copiar desde el directorio donde CMake construyó
          cp -r Niri $out/lib/qt-6/qml/
          runHook postInstall
        '';
        
        meta = with prev.lib; {
          description = "QML plugin para niri compositor";
          homepage = "https://github.com/imiric/qml-niri";
          license = licenses.mit;
          platforms = platforms.linux;
        };
      };
    };
    
    enabledDesktops = {
      gnome = true;
      plasma = false;
      hyprland = false;
      niri = true;
    };
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        
        specialArgs = { 
          inherit inputs enabledDesktops;
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
        };
        
        modules = [
          # Overlays
          ({ config, pkgs, ... }: { 
            nixpkgs.overlays = [ 
              overlay-unstable 
              overlay-qml-niri  # Agregar el overlay de qml-niri
            ]; 
          })
          
          # Configuraciones base
          ./configuration.nix
          ./hardware-configuration.nix
          
          # Servicios del sistema
          ./services/network.nix
          ./services/audio.nix
          ./services/video.nix
          
          # Desktops
          ./desktops/base.nix
          (if enabledDesktops.gnome then ./desktops/gnome.nix else {})
          (if enabledDesktops.plasma then ./desktops/plasma.nix else {})
          (if enabledDesktops.hyprland then ./desktops/hyprland.nix else {})
          (if enabledDesktops.niri then ./desktops/niri.nix else {})
          
          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { 
              inherit inputs enabledDesktops; 
              pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
            };
            home-manager.users.orta = import ./home/Orta/Orta.nix;
          }
        ];
      };
    };
  };
}
