{
  lib,
  config,
  ...
}: {
  options.commonModules.system.user = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "liam";
      example = "john";
      description = "Primary system username";
    };

    fullName = lib.mkOption {
      type = lib.types.str;
      default = "Liam Berry";
      example = "John Doe";
      description = "User's full name (used in Git, etc.)";
    };

    email = lib.mkOption {
      type = lib.types.str;
      default = "Liamandberry@gmail.com";
      example = "john@example.com";
      description = "User's email address (used in Git, etc.)";
    };

    homeDirectory = lib.mkOption {
      type = lib.types.str;
      default = "/home/${config.commonModules.system.user.username}";
      defaultText = lib.literalExpression ''/home/''${config.commonModules.system.user.username}'';
      example = "/home/john";
      description = "User's home directory path";
    };
  };
}
