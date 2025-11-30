{pkgs, ...}: {
  imports = [
    ./Cursor.nix
    ./Fonts.nix
    ./GTK.nix
    ./QT.nix
  ];
}
