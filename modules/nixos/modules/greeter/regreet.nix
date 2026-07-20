{
  lib,
  config,
  ...
}:
let
  cfg = config.nixosModules.greeter.regreet;
in
{
  options.nixosModules.greeter.regreet = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.greeter.enable;
    defaultText = lib.literalExpression "config.nixosModules.greeter.enable";
    description = "Enable ReGreet GTK-based greeter";
  };

  config = lib.mkIf cfg {
    programs.regreet = {
      enable = true;
      cageArgs = [
        "-s"
        "-mlast"
      ];
    };
    stylix.targets.regreet = {
      enable = true;
      image.enable = true;
    };
  };
}
