{
  dendritic.profiles.work.nixos = (
    {
      config,
      lib,
      pkgs,
      ...
    }: let
      username = "liam";
    in {
      # Boot Configuration
      nixosModules.boot = {
        kernelPackages = pkgs.linuxPackages_6_12;
        dualBoot = true;
      };

      # Apps
      nixosModules.apps = {
        wireguard = {
          autostart = true;
          interfaces = {
            wg0 = {
              ips = ["10.12.0.200/32"];
              listenPort = 51820;
              privateKeyFile = "/home/liam/wireguard-keys/private";
              peers = [
                {
                  publicKey = "r2drw8KEHF9OO1L/rGT4iNYl1k9XNmtO58l5UMyB3DM=";
                  allowedIPs = ["10.12.0.0/16"];
                  endpoint = "102.133.148.40:51820";
                  persistentKeepalive = 25;
                }
              ];
            };
            wg1 = {
              ips = ["10.64.0.2/32"];
              listenPort = 51821;
              privateKeyFile = "/home/liam/wireguard-keys/private";
              peers = [
                {
                  publicKey = "MYaTPEhxXQANDdHW9lPdJ4D4Yrbrk4PPP/v9X6BQ+hc=";
                  allowedIPs = ["10.64.0.0/16"];
                  endpoint = "grovewalk.duckdns.org:51820";
                  persistentKeepalive = 25;
                }
              ];
            };
          };
        };
      };

      # System
      nixosModules.system = {
        envVars = {
          muProfile = "work";
        };
      };

      # Boot-time tuning
      systemd.services = {
        NetworkManager-wait-online.enable = false;
      };
    }
  );
  dendritic.profiles.work.home = (
    {
      config,
      lib,
      pkgs,
      ...
    }: let
      # DisplayLink can swap the DVI-I-N names when dlm restarts, so match by serial.
      left = "Samsung Electric Company LF24T35 HFAT604227";
      center = "Samsung Electric Company LF24T35 HFAWA02918";
      right = "HDMI-A-1";
    in {
      # Apps

      # Desktop
      homeModules.desktop = {
        kanshi = {
          settings = [
            {
              profile.name = "work-docked";
              profile.outputs = [
                {
                  criteria = left;
                  mode = "1920x1080";
                  position = "0,0";
                  scale = 1.0;
                }
                {
                  criteria = center;
                  mode = "1920x1080";
                  position = "1920,0";
                  scale = 1.0;
                }
                {
                  criteria = right;
                  mode = "1920x1080@60Hz";
                  position = "3840,0";
                  scale = 1.0;
                }
                {
                  criteria = "eDP-1";
                  status = "disable";
                }
              ];
            }
            {
              profile.name = "work-undocked";
              profile.outputs = [
                {
                  criteria = "DP-1";
                  mode = "1920x1080@120Hz";
                  scale = 1.0;
                }
              ];
            }
            {
              profile.name = "Ferdi-Desk";
              profile.outputs = [
                {
                  criteria = "DVI-I-2";
                  mode = "1920x1080";
                  position = "0,0";
                  scale = 1.0;
                }
                {
                  criteria = "DVI-I-1";
                  mode = "1920x1080";
                  position = "1920,0";
                  scale = 1.0;
                }
                {
                  criteria = "eDP-1";
                  status = "disable";
                }
              ];
            }
          ];
        };
        niri = {
          monitors = [
            left # Mod+1
            center # Mod+2
            right # Mod+3
          ];
          startupApps = [
            {
              command = ["ghostty"];
              appId = "com.mitchellh.ghostty";
              monitor = left;
              workspace = 1;
            }
            {
              command = ["zen-beta"];
              appId = "zen-beta";
              monitor = right;
              workspace = 1;
            }
            {
              command = ["spotify"];
              appId = "spotify";
              monitor = center;
              workspace = 2;
            }
            {
              command = ["teams-for-linux"];
              appId = "electron";
              title = ".*Microsoft Teams$";
              monitor = right;
              workspace = 2;
            }
          ];
          layout.gaps = 5;
        };
      };

      # Other modules
      homeModules.envVars = {
        muProfile = "work";
      };

      homeModules.syncthing = {
        devices = {
          "phone" = {
            id = "7FACKTB-VRXUUBY-62KQYCB-XUSHLG2-7UGUEDP-O2DXFOF-LCG67E5-TCFNOAO";
          };
          "personal" = {
            id = "EAQAYXJ-XQMSQRB-F4FCS5Q-W7AC2LO-S7EBTFK-EHWSU5O-LAN5RBC-5CXP5AC";
          };
          "iPad" = {
            id = "OMHQ3OT-D4PW3LQ-5A75Z4K-4I6OUMM-YGKIQCV-IKPEJJC-7FR6TUR-CUL5EQZ";
          };
          "server" = {
            id = "NHYRSMI-44ZQYV2-H35TA3I-NXQ7PT5-VINFYAS-L2JXBWJ-SSGE64A-3RPL7QE";
          };
        };
        folders = {
          "Documents" = {
            path = "~/Documents";
            devices = [
              "phone"
              "personal"
              "iPad"
              "server"
            ];
            ignorePerms = false;
          };
          "roam" = {
            path = "~/org/roam/";
            devices = [
              "phone"
              "personal"
            ];
            ignorePerms = false;
          };
          "library" = {
            path = "~/library/";
            devices = [
              "phone"
              "personal"
              "iPad"
              "server"
            ];
            ignorePerms = false;
          };
          Audiobooks = {
            path = "~/audiobooks/";
            devices = [
              "phone"
              "personal"
              "iPad"
              "server"
            ];
            ignorePerms = false;
          };
        };
      };
    }
  );
}
