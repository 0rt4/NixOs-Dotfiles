{ config, pkgs, lib, ... }:

{
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
  };

  services = {
    printing.enable = false;
    libinput.enable = true;
    avahi.enable = false;
    resolved.enable = true;
    thermald.enable = true;
    upower.enable = true;
    gnome.gnome-keyring.enable = lib.mkDefault true;
  };

  systemd = {
    services = {
      "network-local-commands".enable = false;
    };
    settings.Manager = {
      DefaultTimeoutStopSec = "10s";
    };
  };

  documentation = {
    enable = false;
    nixos.enable = false;
    man.enable = false;
    info.enable = false;
  };

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
