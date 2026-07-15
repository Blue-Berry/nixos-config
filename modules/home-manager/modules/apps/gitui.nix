{
  lib,
  config,
  ...
}:
let
  cfg = config.homeModules.apps.gitui;
in
{
  options.homeModules.apps.gitui = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable delta gitui";
  };

  config = lib.mkIf cfg {
    programs.gitui = {
      enable = true;
      keyConfig = ''
        (
            move_left: Some(( code: Char('h'), modifiers: "")),
            move_right: Some(( code: Char('l'), modifiers: "")),
            move_up: Some(( code: Char('k'), modifiers: "")),
            move_down: Some(( code: Char('j'), modifiers: "")),

            stash_open: Some(( code: Char('l'), modifiers: "")),
            open_help: Some(( code: F(1), modifiers: "")),

            status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),
            quit: Some(( code: Char('q'), modifiers: "")),
        )
      '';
    };
    stylix.targets.gitui.enable = true;
  };
}
