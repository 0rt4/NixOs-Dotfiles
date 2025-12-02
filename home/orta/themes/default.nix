{pkgs, ...}: {
  imports = [
    ./Cursor.nix
    ./GTK.nix
    ./QT.nix
  ];
}
