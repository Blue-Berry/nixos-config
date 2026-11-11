{inputs, ...}: {
  dendritic.home.commonPackages = (
    {
      lib,
      pkgs,
      config,
      ...
    }: {
      config = {
        nixpkgs.overlays = [inputs.claude-code.overlays.default];
        home.packages = with pkgs; [
          claude-code
          codex
        ];
      };
    }
  );
}
