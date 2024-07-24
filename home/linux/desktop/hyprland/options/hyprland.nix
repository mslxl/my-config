{
  pkgs,
  hyprland,
  system,
  lib,
  config,
  nix-colors,
  myutils,
  pkgs-stable,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hyprland;
in {
  options.modules.desktop.hyprland = {
    monitors = mkOption {
      default = [",preferred,auto,auto"];
      type = with types; listOf str;
      description = ''
        Monitor fields in hyprland
      '';
    };

    extraConfig = mkOption {
      default = "";
      type = types.str;
      description = ''
        Host related config
      '';
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile."hypr/script".source = ../conf/script;
    home.packages = with pkgs; [
      grim
      slurp
      swappy
      pngquant
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = hyprland.packages.${system}.hyprland;
      settings = {
        env = [
          "NIXOS_OZONE_WL,1" # for any ozone-based browser & electron apps to run on wayland
          "MOZ_ENABLE_WAYLAND,1" # for firefox to run on wayland
          "MOZ_WEBRENDER,1"
          # misc
          "_JAVA_AWT_WM_NONREPARENTING,1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_QPA_PLATFORM,wayland"
          "SDL_VIDEODRIVER,wayland"
          "GDK_BACKEND,wayland"
        ];
      };

      extraConfig = let
        monitorSection = builtins.concatStringsSep "\n" (map (field: "monitor=" + field) cfg.monitors);
        confFile = builtins.readFile ../conf/hyprland.conf;

        colorScheme =
          ((nix-colors.lib.contrib {inherit pkgs;}).colorSchemeFromPicture {
            path = config.modules.desktop.background.source;
            variant = config.modules.desktop.background.variant;
          })
          .palette;
      in ''

        # Generated by nix-colors
        $background = rgb(${colorScheme.base00})
        $foreground = rgb(${colorScheme.base0F})
        $color00 = rgb(${colorScheme.base00})
        $color01 = rgb(${colorScheme.base01})
        $color02 = rgb(${colorScheme.base02})
        $color03 = rgb(${colorScheme.base03})
        $color04 = rgb(${colorScheme.base04})
        $color05 = rgb(${colorScheme.base05})
        $color06 = rgb(${colorScheme.base06})
        $color07 = rgb(${colorScheme.base07})
        $color08 = rgb(${colorScheme.base08})
        $color09 = rgb(${colorScheme.base09})
        $color10 = rgb(${colorScheme.base0A})
        $color11 = rgb(${colorScheme.base0B})
        $color12 = rgb(${colorScheme.base0C})
        $color13 = rgb(${colorScheme.base0D})
        $color14 = rgb(${colorScheme.base0E})
        $color15 = rgb(${colorScheme.base0F})

        ${monitorSection}
        ${confFile}
        ${cfg.extraConfig}

        exec-once = fcitx5 -d
        exec-once = hyprctl setcursor Bibata-Modern-Ice 24
        exec-once = ${pkgs.networkmanagerapplet}/bin/nm-applet
        exec-once = ${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent
        exec-once = wl-paste --watch cliphist store
        exec-once = kdeconnect-indicator
        exec-once = ${pkgs.wlsunset}/bin/wlsunset -l 36.6 -L 117
        exec-once = (swww query || swww init) && swww img "${config.modules.desktop.background.source}"
        exec = ${pkgs.writeShellScript "restart-waybar" ''
          pkill waybar
          ${pkgs.waybar}/bin/waybar
        ''}

        exec-once = clash-verge

        # register in nix modules
        ${
          lib.concatStringsSep "\n"
          (builtins.map (prog: "exec-once = ") config.modules.desktop.exec.once)
        }
        ${
          lib.concatStringsSep "\n"
          (builtins.map (prog: "exec = ") config.modules.desktop.exec.always)
        }
      '';
      # exec-once = ${pkgs.kdePackages.plasma-workspace}/bin/xembedsniproxy
    };
  };
}
