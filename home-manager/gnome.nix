{ config, pkgs, lib, ... }:

{
  imports = [ ./default.nix ]; 
  
  # ===== Configuración dconf=====
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "Adwaita-dark";
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "blur-my-shell@aunetx"
          "caffeine@patapon.info"
          "Vitals@CoreCoding.com"
          "gsconnect@andyholmes.github.io"
          "openweather-extension@jenslody.de"
          "forge@jmmaranan.com"
          "fuzzy-app-search@leavitals"
          "app-menu-is-back@nulldev"
          "open-bar@jean"
          "tiling-shell@leavitals"
          "vertical-workspaces@G-dH.github.com"
          "search-light@icedman.github.com"
          "burn-my-windows@schneegans.github.com"
        ];
      };
      "org/gnome/shell/extensions/blur-my-shell" = {
        brightness = 0.7;
        sigma = 30;
      };
      "org/gnome/shell/extensions/caffeine" = {
        enable-fullscreen = true;
      };
      "org/gnome/shell/extensions/gsconnect" = {
        show-indicators = true;
      };
      "org/gnome/shell/extensions/forge" = {
        window-gap = 5;
      };
    };
  };
  
  # ===== TEMA GTK PARA GNOME =====
  gtk.theme = {
    name = "Adwaita-dark";
    package = pkgs.gnome-themes-extra;
  };
  
  # ===== PAQUETES ESPECÍFICOS PARA GNOME =====
  home.packages = with pkgs; [
    zsh-powerlevel10k
    direnv
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.vitals
    # ... otras extensiones
  ];
}
