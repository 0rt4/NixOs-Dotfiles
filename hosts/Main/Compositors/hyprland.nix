{ pkgs, inputs, ... }: {

  environment.systemPackages = with pkgs; [
    inputs.ambxst.packages.${pkgs.system}.default
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
}
