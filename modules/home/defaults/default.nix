self: {
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ../shell
    ../devtools.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.nh.enable = true;

  home.packages = [pkgs.gdu];

  programs.btop.enable = true;
}
