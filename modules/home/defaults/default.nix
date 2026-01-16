self: {
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ../shell
    ../git.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [pkgs.gdu];

  programs.nh.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.btop.enable = true;
}
