{
  inputs,
  lib,
  ...
}: {
  perSystem = {
    system,
    pkgs,
    ...
  }: {
    checks = lib.optionalAttrs (system == "x86_64-linux") {
      nixos-personal = inputs.self.nixosConfigurations.personal.config.system.build.toplevel;
      nixos-work = inputs.self.nixosConfigurations.work.config.system.build.toplevel;
      home-personal = inputs.self.homeConfigurations.personal.activationPackage;
      home-work = inputs.self.homeConfigurations.work.activationPackage;
      shared-user-vm = import ../../tests/nixos/smoke.nix {
        inherit pkgs;
        commonSystem = inputs.self.commonModules.system;
      };
      profile-invariants = let
        personal = inputs.self.nixosConfigurations.personal.config;
        work = inputs.self.nixosConfigurations.work.config;
        personalHome = inputs.self.homeConfigurations.personal.config;
        workHome = inputs.self.homeConfigurations.work.config;
      in
        assert personal.networking.hostName == "liam-nixos";
        assert work.networking.hostName == "liam-nixos";
        assert personal.system.stateVersion == "24.05" && work.system.stateVersion == "24.05";
        assert personalHome.home.stateVersion == "24.05" && workHome.home.stateVersion == "24.05";
        assert personalHome.home.username == "liam" && workHome.home.username == "liam";
        assert personal.programs.steam.enable && !work.programs.steam.enable;
        assert personal.services.sunshine.enable && !work.services.sunshine.enable;
        assert personal.virtualisation.libvirtd.enable && !work.virtualisation.libvirtd.enable;
        assert !personal.nixosModules.boot.dualBoot && work.nixosModules.boot.dualBoot;
        assert personal.programs.niri.enable && work.programs.niri.enable;
        assert personal.programs.dms-greeter.enable && work.programs.dms-greeter.enable;
        assert builtins.attrNames personal.networking.wg-quick.interfaces
        == [
          "wg0"
          "wg1"
        ];
        assert builtins.attrNames work.networking.wg-quick.interfaces
        == [
          "wg0"
          "wg1"
        ];
        assert personalHome.homeModules.desktop.niriConfigured && workHome.homeModules.desktop.niriConfigured;
        assert personalHome.commonModules.system.user.email != workHome.commonModules.system.user.email;
          pkgs.runCommand "profile-invariants" {} "touch $out";
    };
  };
}
