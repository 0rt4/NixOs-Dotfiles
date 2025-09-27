{ config, pkgs, ... }:

{
  programs.caelestia = {
    enable = true;

    systemd = {
      enable = false;
      target = "graphical-session.target";
    };

    settings = {
      font = {
        family = {
          material = "Material Symbols Rounded";
          mono = "FiraCode Nerd Font";
          sans = "Inter";
        };
        size = {
          scale = 1;
        };
      };

      paths = {
        mediaGif = "/home/orta/Imágenes/Logos-iconos/Umbreon DJ.gif";
        sessionGif = "/home/orta/Imágenes/Logos-iconos/Pixel Pokemon Sticker.gif";
        wallpaperDir = "/home/orta/Imágenes/Wallpapers";
      };
    };

    cli = {
      enable = true;
      settings = {
        theme.enableGtk = false;
      };
    };
  };
}

