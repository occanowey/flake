{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };

        inherit (pkgs) writeShellScriptBin;
        inherit (pkgs.lib) getExe;

        packwiz_pw = writeShellScriptBin "pw" ''
          pushd $PACK_ROOT > /dev/null
          ${getExe pkgs.packwiz} "$@"
          popd > /dev/null
        '';

        pw = getExe packwiz_pw;
      in {
        formatter = pkgs.alejandra;

        # assumptions, bad
        packages.initialize = writeShellScriptBin "packwiz_project_initialize" ''
          set -e

          # update flake.lock
          nix flake update

          # allow direnv to add packwiz to path
          direnv allow

          # initialize project
          nix develop -c bash -c "mkdir -p pack && pw init"
        '';

        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.packwiz

            packwiz_pw

            (writeShellScriptBin "mra" ''${pw} mr add "$@"'')
            (writeShellScriptBin "cfa" ''${pw} cf add "$@"'')
          ];

          shellHook = ''
            export PACK_ROOT="$(pwd)/pack"
          '';
        };
      }
    );
}
