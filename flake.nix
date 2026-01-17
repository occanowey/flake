{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    formatter.${system} = pkgs.alejandra;

    packages.${system}.net-debug = pkgs.callPackage ./net-debug.nix {};

    homeManagerModules.default = import ./modules/home/defaults/default.nix self;
  };
}
