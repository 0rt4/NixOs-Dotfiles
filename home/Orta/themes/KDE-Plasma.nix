{
  programs.plasma = {
    enable = true;
    overrideConfig = true; # Borrará tu configuración manual de Plasma

    workspace = {
      clickItemTo = "open"; # If you liked the click-to-open default from plasma 5
      #lookAndFeel = "org.kde.breezedark.desktop";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 32;
      };
      iconTheme = "Papirus-Dark";
      #wallpaper = "/home/orta/Imágenes/Wallpapers/01.png";
    };

    hotkeys.commands."launch-konsole" = {
      name = "Launch Ghostty";
      key = "Meta+Alt+K";
      command = "ghostty";
    };

    fonts = {
      general = {
        family = "JetBrains Mono";
        pointSize = 14;
      };
    };

    # Comenta esta sección si no vas a usar widgets
    # desktop.widgets = [
    #   {
    #     name = "org.kde.plasma.digitalclock";
    #   }
    # ];

  };
}