{
  dendritic.home.commonApps = (
    {
      lib,
      config,
      pkgs,
      ...
    }: let
      cfg = config.homeModules.apps.git;
      userCfg = config.commonModules.system.user;
    in {
      options.homeModules.apps.git = {
        userName = lib.mkOption {
          type = lib.types.str;
          default = userCfg.fullName;
          defaultText = lib.literalExpression "config.commonModules.system.user.fullName";
          description = "Git user name";
        };

        userEmail = lib.mkOption {
          type = lib.types.str;
          default = userCfg.email;
          defaultText = lib.literalExpression "config.commonModules.system.user.email";
          description = "Git user email";
        };

        defaultBranch = lib.mkOption {
          type = lib.types.str;
          default = "main";
          description = "Default branch name for new repositories";
        };

        extraAliases = lib.mkOption {
          type = lib.types.attrs;
          default = {};
          description = "Additional git aliases";
        };
      };

      config = {
        home.packages = [pkgs.git];
        programs.git.settings = {
          enable = true;
          userName = cfg.userName;
          userEmail = cfg.userEmail;
          init.defaultBranch = cfg.defaultBranch;
          alias =
            {
              lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
              lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
              lg = "lg1";
            }
            // cfg.extraAliases;
        };
      };
    }
  );
}
