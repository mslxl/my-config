{pkgs, wallpaper, ...}: {

  imports = [
    ./wofi
    ./waybar
    ./dunst
  ];


  # hyprland configs, based on https://github.com/notwidow/hyprland
  xdg.configFile.".config/hypr" = {
    source = ./hypr-conf;
    # copy the scripts directory recursively
    recursive = true;
  };

  # allow fontconfig to discover fonts and configurations installed through home.packages
  fonts.fontconfig.enable = true;

  systemd.user.sessionVariables = {
    "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
    "MOZ_ENABLE_WAYLAND" = "1"; # for firefox to run on wayland
    "MOZ_WEBRENDER" = "1";

    # for hyprland with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
    "LIBVA_DRIVER_NAME" = "nvidia";
    "XDG_SESSION_TYPE" = "wayland";
    # "GBM_BACKEND" = "nvidia-drm";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    "WLR_NO_HARDWARE_CURSORS" = "1";
    "WLR_EGL_NO_MODIFIRES" = "1";
  };

  home.packages = with pkgs; [
    hyprpaper
  ];

  xdg.configFile.".config/hypr/wallpaper/".source = wallpaper;

  xdg.configFile.".config/hypr/hyprpaper.conf".text = ''
    preload = ~/.config/hypr/wallpaper/nix-wallpaper-dracula.png
    wallpaper = eDP-1,~/.config/hypr/wallpaper/nix-wallpaper-dracula.png
  '';

}
