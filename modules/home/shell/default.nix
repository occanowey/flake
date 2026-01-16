{
  lib,
  pkgs,
  config,
  ...
}: {
  home.packages = [
    # utils
    pkgs.jq
    pkgs.just
  ];

  # -- Shell --
  programs.bash.enable = true; # enable bash for nix develop shells
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    defaultKeymap = "emacs";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      # maybe just use oh my zsh
      ${builtins.readFile ./take.zsh}
    '';
  };

  # -- History --
  # remember: ctrl+r
  programs.fzf.enable = true;

  # -- Prompt --
  programs.starship = {
    enable = true;
    settings = let
      theme = "mocha";
      themeRepo = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "starship";
        rev = "e99ba6b";
        sha256 = "sha256-1w0TJdQP5lb9jCrCmhPlSexf0PkAlcz8GBDEsRjPRns=";
      };

      readToml = file: (builtins.fromTOML (builtins.readFile file));
    in
      lib.mkMerge [
        # theme
        (readToml (themeRepo + "/themes/${theme}.toml"))
        {palette = "catppuccin_${theme}";}

        # nerd font symbols
        (readToml ./starship-nerd-font-symbols.toml)

        # config
        (readToml ./starship.toml)
      ];
  };

  # -- Replacements --
  # find replacement
  programs.fd.enable = true;

  # ls replacement
  programs.eza.enable = true;

  # cat replacement
  programs.bat.enable = true;

  # cd "replacement"
  programs.zoxide.enable = true;

  # grep replacement
  programs.ripgrep.enable = true;
}
