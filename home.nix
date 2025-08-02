{ config, pkgs, ... }:

{
  # ===== Configuración básica =====
  home.username = "orta";
  home.homeDirectory = "/home/orta";
  home.stateVersion = "25.05";

  # ===== Avatar de usuario =====
  home.file = {
    ".face".source = ./avatar.jpg;
    ".face.icon".source = ./avatar.jpg;
  };

  # ===== Cursor Bibata =====
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
  
  #==================ZSH==================
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };
  # ===== Temas GTK =====
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };
  
  # ===== Configuración adicional para QT/KDE =====
  qt = {
    enable = true;
    platformTheme = "gnome";  # Usa la configuración de GNOME como base
    style = {
      name = "adwaita-dark";  # Debe coincidir con el nombre del tema GTK
      package = pkgs.adwaita-qt;
    };
  };

  
  # ===== Extensiones de GNOME =====
  home.packages = with pkgs; [
    # Todas tus extensiones
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.vitals
    gnomeExtensions.gsconnect
    gnomeExtensions.openweather-refined
    gnomeExtensions.forge
    gnomeExtensions.fuzzy-app-search
    gnomeExtensions.app-menu-is-back
    gnomeExtensions.open-bar
    gnomeExtensions.tiling-shell
    gnomeExtensions.vertical-workspaces
    gnomeExtensions.search-light
    gnomeExtensions.burn-my-windows
    
    # Herramienta para gestionar extensiones
    gnome-extension-manager
  ];

  # ===== Activar y configurar extensiones =====
  dconf.settings = {
    "org/gnome/shell" = {
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

    # Configuraciones específicas (personaliza según necesites)
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



  # ===== Variables de entorno =====
  home.sessionVariables = {
    #QT_STYLE_OVERRIDE = "gtk2";
    XCURSOR_THEME = "Bibata-Modern-Classic";
  };
}
