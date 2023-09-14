{ config, pkgs, nur, nixpkgs, ... }:


let
  nur-no-pkgs = import nur {
    nurpkgs = import nixpkgs { system = "x86_64-linux"; };
  };
in
{
  imports = [
    ./shell
    ./desktop/gtk.nix
    ./desktop/hyprland
    ./programs/media
    ./programs/office

    ./programs/git.nix
    ./programs/browsers
    ./programs/devtool
    ./programs/jetbrains-ide
    ./programs/neovim
    ./programs/obs-studio.nix

    ./programs/tencent/wemeet.nix
  ];

  home = {
    username = "mslxl";
    homeDirectory = "/home/mslxl";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;
  xdg.userDirs.enable = true;

  home.packages = with pkgs; [
    aria2
    vscode.fhs
  ];
}
