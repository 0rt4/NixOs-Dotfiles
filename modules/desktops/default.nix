{ ... }:

{
  imports = [
    ./base.nix
    
    ./niri.nix
    ./gnome.nix
    #./kde-plasma.nix # Opcional para quien lo necesite
    #./hyprland.nix
    #./cosmic.nix # Pruebas (Descartado por malo)
    ./mangowc.nix
  ];
}
