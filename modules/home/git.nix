{...}: {
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
}
