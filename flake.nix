{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    forAllSystems = f:
      nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-darwin"] (system: f (import nixpkgs {inherit system;}));
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    packages = forAllSystems (pkgs: {
      net-debug = pkgs.callPackage ./net-debug.nix {};
    });

    homeManagerModules.default = import ./modules/home/defaults/default.nix self;

    templates = import ./templates {};
  };
}
