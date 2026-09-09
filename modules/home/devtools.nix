{
  lib,
  config,
  ...
}: let
  inherit (lib) mkDefault;

  cfg = config.profiles.devtools;
in {
  options.profiles.devtools = let
    inherit (lib) mkEnableOption;
  in {
    enable = mkEnableOption "Profile for development tools";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "Griffin T";
          email = "griffin_git@thommo.io";
        };

        alias = {
          st = "status -s";
          lol = "log --oneline --graph --all";
        };

        init.defaultBranch = "main";

        # yoinked from:
        # https://blog.gitbutler.com/how-git-core-devs-configure-git/
        column.ui = "auto";
        branch.sort = "-committerdate";
        tag.sort = "version:refname";

        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicPrefix = "true";
          renames = "true";
        };

        push = {
          default = "simple";
          autoSetupRemote = "true";
          followTags = "true";
        };

        help.autocorrect = "prompt";

        rerere = {
          enabled = "true";
          autoupdate = "true";
        };

        rebase = {
          autoSquash = "true";
          autoStash = "true";
          updateRefs = "true";
        };

        marge.conflictstyle = "zdiff3";
      };
    };

    programs.difftastic = {
      enable = true;
      git.enable = true;
      options.background = "dark";
    };

    # enable bash for nix develop shells
    programs.bash.enable = mkDefault true;

    programs.direnv = {
      enable = mkDefault true;
      nix-direnv.enable = mkDefault true;
    };
  };
}
