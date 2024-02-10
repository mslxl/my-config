{
  pkgs,
  lib,
  config,
  nix-colors,
  ...
}: with lib; let
  cfg = config.modules.desktop.sway;
in {
  config = mkIf cfg.enable {
    programs.wlogout.enable = true;

    xdg.configFile."wlogout/icons".source = ../../base-wayland-tile/wlogout/icons;
    xdg.configFile."wlogout/layout".source = ../../base-wayland-tile/wlogout/layout;
    xdg.configFile."wlogout/noise.png".source = ../../base-wayland-tile/wlogout/noise.png;
    xdg.configFile."wlogout/style.css".text = let
      colors = ((nix-colors.lib.contrib {inherit pkgs;}).colorSchemeFromPicture {
        path = config.modules.desktop.background.source;
        variant = config.modules.desktop.background.variant;
      }).palette;
    in ''
      /*
       * generated by nix-colors
       */
      @define-color foreground #${colors.base0F};
      @define-color background #${colors.base00};
      @define-color cursor #${colors.base0F};

      @define-color color0 #${colors.base00};
      @define-color color1 #${colors.base01};
      @define-color color2 #${colors.base02};
      @define-color color3 #${colors.base03};
      @define-color color4 #${colors.base04};
      @define-color color5 #${colors.base05};
      @define-color color6 #${colors.base06};
      @define-color color7 #${colors.base07};
      @define-color color8 #${colors.base08};
      @define-color color9 #${colors.base09};
      @define-color color10 #${colors.base0A};
      @define-color color11 #${colors.base0B};
      @define-color color12 #${colors.base0C};
      @define-color color13 #${colors.base0D};
      @define-color color14 #${colors.base0E};
      @define-color color15 #${colors.base0F};
    ''
    + builtins.readFile ../../base-wayland-tile/wlogout/style.css;
  };

}
