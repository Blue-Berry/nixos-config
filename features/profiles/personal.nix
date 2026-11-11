{
  dendritic.profiles.personal.nixos = (
    {
      config,
      lib,
      pkgs,
      ...
    }: {
      # Boot Configuration
      nixosModules.boot = {
        dualBoot = false;
      };

      # Apps
      nixosModules.apps = {
        wireguard = {
          interfaces = {
            wg0 = {
              ips = ["10.12.7.239/32"];
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
          muProfile = "personal";
        };
      };
    }
  );
  dendritic.profiles.personal.home = (
    {
      config,
      lib,
      pkgs,
      ...
    }: {
      # Apps

      # Desktop
      homeModules.desktop = {
        kanshi = {
          settings = [
            {
              profile.name = "personal";
              profile.outputs = [
                {
                  criteria = "DP-2";
                  mode = "1920x1080";
                  position = "0,0";
                  scale = 1.0;
                }
                {
                  criteria = "HDMI-A-1";
                  mode = "1920x1080";
                  position = "1920,0";
                  scale = 1.0;
                }
              ];
            }
          ];
        };
        niri = {
          monitors = [
            "DP-2" # Mod+1 - Left monitor
            "HDMI-A-1" # Mod+2 - Right monitor
          ];
        };
      };

      # Other modules
      homeModules.envVars = {
        muProfile = "personal";
      };

      homeModules.syncthing = {
        devices = {
          "phone" = {
            id = "7FACKTB-VRXUUBY-62KQYCB-XUSHLG2-7UGUEDP-O2DXFOF-LCG67E5-TCFNOAO";
          };
          "work" = {
            id = "R6KDI5U-O4CUY7L-IATHVCY-MIDKOJR-MSLFJVT-VE6HTMN-JDALETZ-AX4SRQC";
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
              "work"
              "iPad"
              "server"
            ];
            ignorePerms = false;
          };
          "roam" = {
            path = "~/org/roam/";
            devices = [
              "phone"
              "work"
            ];
            ignorePerms = false;
          };
          "library" = {
            path = "~/library/";
            devices = [
              "phone"
              "work"
              "iPad"
              "server"
            ];
            ignorePerms = false;
          };
          Audiobooks = {
            path = "~/audiobooks/";
            devices = [
              "phone"
              "work"
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
