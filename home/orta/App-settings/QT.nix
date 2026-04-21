{ pkgs, ... }: {
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  home.sessionVariables = {
    # Añadimos :$XDG_DATA_DIRS para concatenar con las rutas existentes.
    XDG_DATA_DIRS = "${pkgs.papirus-icon-theme}/share:$XDG_DATA_DIRS";
  };
}
