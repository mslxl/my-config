{username, ...}: {
  home = {
    inherit username;

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
