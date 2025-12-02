{pkgs, ...}: # home.nix (si usas home-manager)
{
  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "kvantum-dark";
      package = pkgs.libsForQt5.qtstyleplugin-kvantum;
    };
  };
}
