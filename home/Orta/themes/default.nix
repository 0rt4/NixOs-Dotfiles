{pkgs, ...}: {
  imports = [
    ./Cursor.nix
    ./GTK.nix
    ./QT.nix

    #temas de Desktops
    #./KDE-Plasma.nix
    ./Niri.nix
  ];
}
