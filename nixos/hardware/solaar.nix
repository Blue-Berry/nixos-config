{ pkgs, ... }: {
  services.solaar = {
    enable = true;
    package = pkgs.solaar;
  };
}
