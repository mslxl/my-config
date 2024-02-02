{
  self,
  inputs,
  constants,
}: let
  inherit (inputs.nixpkgs) lib;
  myutils = import ../utils {inherit lib;};
  profiles = import ./profiles.nix;
  specialArgsForSystem = system:
    {
      inherit system;
      inherit (constants) username useremail;
      inherit myutils;
      nix-colors = inputs.nix-colors;
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    } // inputs;
  allSystemSpecialArgs = myutils.attrs.mapAttrs (_: specialArgsForSystem) constants.allSystemAttrs;
  args = myutils.attrs.mergeAttrsList [
    inputs
    constants
    profiles
    {inherit self lib myutils allSystemSpecialArgs; }
  ];
in {
  nixosConfigurations =
    with args;
    with myutils;
    with allSystemAttrs; let
    base_args = {
      inherit home-manager;
      inherit nixpkgs;
      system = x64_system;
      specialArgs = allSystemSpecialArgs.x64_system;
    };
  in {
    mslxl-xiaoxinpro16-2021 = nixosSystem (profiles.xiaoxinpro16-2021 // base_args);
  };
}
