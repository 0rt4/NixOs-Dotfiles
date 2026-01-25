{ config, pkgs, ... }:

{
  imports = [
    ./Audio.nix
    ./Network.nix
    ./Video.nix
  ];
}
