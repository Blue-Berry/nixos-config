{
  dendritic.profiles.personal.nixos = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        # nixpkgs' native module (the upstreamed Svenum one). userService runs the
        # tray app, matching the old services.solaar behaviour.
        programs.solaar = {
          enable = true;
          package = pkgs.solaar;
          userService.enable = true;
        };
      };
    }
  );
}
