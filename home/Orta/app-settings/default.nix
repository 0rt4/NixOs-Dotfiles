{ pkgs, inputs, enabledDesktops, ... }: {
  imports = [
    ./ghostty.nix
    ./spicetify.nix
    ./zed.nix
    ./terminal-settings.nix
    
  ] ++ (if enabledDesktops.niri then [
    #inputs.caelestia-shell.homeManagerModules.default
    ./fuzzel.nix
    ./swaync.nix
    ./Helix.nix
  ] else []);
}

