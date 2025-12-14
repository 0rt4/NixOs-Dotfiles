{pkgs, ...}: {
  imports = [
    ./Cursor.nix
    ./GTK.nix
    ./QT.nix

    #temas de Desktops
    #./DE: KDE-Plasma.nix
    ./DE_Niri.nix
  ];
}
