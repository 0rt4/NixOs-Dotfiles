{ config, pkgs, lib, enabledDesktops, ... }:

let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "black_hole";
     themeConfig = {
    #   AccentColor = "#746385";
    #   Background = "path/to/background.jpg";
    #   FormPosition = "left";
    #
    #   ForceHideCompletePassword = true;
    #   Font = config.stylix.fonts.sansSerif.name;
     };
  };
in
{
  # Configuraciones comunes para todos los entornos de escritorio
  programs.xwayland.enable = true;
  services.xserver = {
    enable = true;
    xkb = {
      layout = "latam";
      variant = "";
    };
  };
  
  #services.displayManager.gdm.enable = true;

  services.displayManager.sddm = { 
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme"; 
      
      settings = {
        Theme = {
          CursorTheme = "Bibata-Modern-Classic";
        };
      };
      extraPackages = with pkgs; [ sddm-astronaut kdePackages.qtmultimedia];
  };

  environment.systemPackages = with pkgs; [
    sddm-astronaut
    kdePackages.qtmultimedia
  ];
  
  # Touchpad (para laptops)
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
    };
  };
  
  # Portales XDG
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ] ++ lib.optionals enabledDesktops.gnome [ xdg-desktop-portal-gnome ]
      ++ lib.optionals enabledDesktops.plasma [ xdg-desktop-portal-kde ]
      ++ lib.optionals enabledDesktops.hyprland [ xdg-desktop-portal-hyprland ]
      ++ lib.optionals enabledDesktops.niri [ xdg-desktop-portal-wlr ];
  };
}

