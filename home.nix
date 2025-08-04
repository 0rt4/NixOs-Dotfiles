{ config, pkgs, lib, ... }:

let
  # Detección del entorno de escritorio usando variables de sesión
  currentDesktop = "$XDG_CURRENT_DESKTOP";  # Esto se expandirá en tiempo de ejecución
  isGnome = pkgs.gnome-shell != null;
  isKDE = lib.hasInfix "KDE" currentDesktop;
in
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
  
  # ================== ZSH ==================
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    initExtra = ''
      ${lib.optionalString isGnome ''
        # Configuración GNOME
        gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      ''}
      ${lib.optionalString isKDE ''
        # Configuración KDE
        kwriteconfig5 --file kdeglobals --group General --key ColorScheme "BreezeDark"
      ''}
    '';
  };

  # ===== Configuración GTK =====
  gtk = {
    enable = true;
    theme = {
      name = if isGnome then "Adwaita-dark" else "Breeze-Dark";
      package = if isGnome then pkgs.gnome-themes-extra else pkgs.libsForQt5.breeze-qt5;
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
  
    # ===== Extensiones de GNOME (solo si estamos en GNOME) =====
  home.packages = with pkgs; lib.optionals isGnome [
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
    gnome-extension-manager   # Gestor de extensiones (alternativo)
  ];
  

  # ===== Configuración dconf solo para GNOME =====
  dconf = lib.mkIf isGnome {
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


  # ===== Configuración QT =====
  qt = {
    enable = true;
    platformTheme = if isKDE then "kde" else "gnome";
    style = {
      name = if isKDE then "breeze" else "adwaita-dark";
      package = if isKDE then pkgs.libsForQt5.breeze-qt5 else pkgs.adwaita-qt;
    };
  };

  # ===== Variables de sesión =====
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    QT_STYLE_OVERRIDE = if isKDE then "breeze" else "adwaita-dark";
  };
}
