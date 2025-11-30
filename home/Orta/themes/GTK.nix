{pkgs, ...}: {

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        #gtk-theme = "Orchis-Grey-Dark";
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

  gtk = {
    enable = true;

    font = {
      name = "Inter";
      size = 11;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Orchis-Grey-Dark";
      package = pkgs.orchis-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    
    gtk3.extraCss = ''
      .background {
        background-color: rgba(30, 30, 30, 0.8);
      }
      
      window {
        background-color: rgba(30, 30, 30, 0.8);
      }
      
      .window-frame {
        box-shadow: none;
        margin: 0;
      }
    '';

    gtk4.extraCss = ''
      window {
        background-color: rgba(30, 30, 30, 0.8);
      }
      
      .background {
        background-color: rgba(30, 30, 30, 0.8);
      }
    '';
  };

}
