{...}: {
  modpack = {
    packwiz = rec {
      name = "Packwiz Modpack";
      description = ''
        A Minecraft modpack using packwiz.
      '';

      path = ./modpack/packwiz;

      welcomeText = ''
        # ${name}
        ${description}

        ## Getting started:
        - Run init script:

          ```sh
          # nix run .#initialize
          ```

        ## Tools:
        - `packwiz` - the main tool to manage the modpack

        - `pw` - an alias for packwiz that works from any directory

        - `mra` an alias for `pw modrinth add`
        - `cfa` an alias for `pw curseforge add`
      '';
    };
  };
}
