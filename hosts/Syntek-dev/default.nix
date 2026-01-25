{ config, pkgs, inputs, lib, ... }:

{
  networking.hostName = "syntek-dev";
  system.stateVersion = "25.11";
  
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  imports = [
    ./Hardware-configuration.nix
    ./Services
    ./Compositors
    ./Shell.nix
    ./Packages.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
  
  time.timeZone = "America/Mexico_City";
  i18n = {
    defaultLocale = "de_DE.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "es_MX.UTF-8";
      LC_IDENTIFICATION = "es_MX.UTF-8";
      LC_MEASUREMENT = "es_MX.UTF-8";
      LC_MONETARY = "es_MX.UTF-8";
      LC_NAME = "es_MX.UTF-8";
      LC_NUMERIC = "es_MX.UTF-8";
      LC_PAPER = "es_MX.UTF-8";
      LC_TELEPHONE = "es_MX.UTF-8";
      LC_TIME = "es_MX.UTF-8";
    };
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "latam";
      options = "";
    };
  };

  console.keyMap = "la-latin1";

  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
    };
  };
# =============================  Usuario   ====================================
  users.users.orta = {
    isNormalUser = true;
    description = "Christopher Orta";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };
  
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    
    users.orta = { inputs, ... }: {
      imports = [
        ../../home/orta
      ];
    };
  };

  # Funciones experimentales
  nixpkgs.config.allowUnfree = true;
  
  programs.fish.enable = true;
  programs.starship.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  security.polkit.enable = true;
  
# ==================== Nix settings con optimizaciones =============================
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      max-jobs = "auto";
      cores = 0;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
  };
}
