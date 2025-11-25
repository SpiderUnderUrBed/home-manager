{ pkgs, lib, ... }: {
  #modules = {
  #home = {
  wayland.windowManager.hyprland.enable = true;
  programs = {
    #hyprland.enable = true;
    waybar.enable = true;
    rofi.enable = true;
    hyprlock.enable = true;
  };
  #};
  #};
}
