{pkgs, ...}: # home.nix (si usas home-manager)
{
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
