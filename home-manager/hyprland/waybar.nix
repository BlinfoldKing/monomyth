{ pkgs, palette, ... }:
let
  bg = "#${palette.base00}";
  fg = "#${palette.base05}";
  red = "#${palette.base08}";
  green = "#${palette.base0B}";
  blue = "#${palette.base0D}";
  cyan = "#${palette.base0C}";
  yellow = "#${palette.base0A}";
  orange = "#${palette.base09}";
  magenta = "#${palette.base0E}";
  tofi-exec = import ./tofi/default.nix { inherit pkgs palette; };
in
{
  programs.waybar = {
    enable = true;
    # systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";

        position = "bottom";
        # height = "30px";
        margin-bottom = 10;
        margin-right = 10;
        margin-left = 10;
        output = [
          "DP-2"
          "HDMI-A-1"
        ];

        modules-left = [ "custom/launcher" "hyprland/workspaces" "group/cpu-stat" "group/mem-stat" ];
        modules-right = [ "mpris" "pulseaudio" "group/custom-tray" "clock" "custom/power-menu" ];

        "custom/power-menu" = {
          format = "{icon}";
          format-icons = "";
          on-click = "wlogout";
        };

        "custom/launcher" = {
          format = "{icon}";
          format-icons = "󱄅";
          on-click = tofi-exec;
        };

        "custom/cpu-icon" = {
          format = "{icon}";
          format-icons = " ";
          tooltip = true;
          tooltip-format = "cpu stat";
        };

        "group/cpu-stat" = {
          orientation = "horizontal";
          modules = [
            "custom/cpu-icon"
            "cpu"
            "temperature"
          ];
        };

        "group/mem-stat" = {
          orientation = "horizontal";
          modules = [
            "memory"
            "disk"
          ];
        };

        memory = {
          format = " {percentage}%";
        };

        disk = {
          format = " {percentage_used}%";
        };

        cpu = {
          thermal-zone = "cooling_device0";
        };

        "wlr/taskbar" = {
          icon-size = 20;
          on-click = "activate";
          tooltip = true;
          sort-by-app-id = true;
          ignore-list = [ "kitty" ];
        };

        mpris = {
          dynamic-order = [
            "title"
            "artist"
          ];

          dynamic-importance-order = [
            "title"
            "artist"
          ];
          format = "{player_icon} {dynamic} {status_icon}";

          player-icons = {
            default = "🎵";
          };

          status-icons = {
            playing = "  ";
            paused = "  ";
          };

        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
          };

          "persistent-workspaces" = {
            "DP-2" = [ 1 2 3 4 5 ];
            "HDMI-A-1" = [ 6 7 8 9 10 ];
          };
        };

        "custom/screenshot" = {
          format = "{icon}";
          format-icons = "󰄀";
          on-click = ''hyprctl dispatch exec "grimblast copysave area"'';
        };

        "group/custom-tray" = {
          orientation = "horizontal";
          modules = [
            "tray"
            "custom/screenshot"
          ];
        };

        tray = {
          icon-size = 20;
          spacing = 5;
          show-passive-items = true;
        };

        pulseaudio = {
          states = {
            low = 25;
            med = 100;
            high = 150;
          };
          max-volume = 150;
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          scroll-step = 1;
          on-click = "pwvucontrol";
          ignored-sinks = [ "Easy Effects Sink" ];
        };
      };
    };

    style = ''
      * {
        font-family: Caskaydia Cove Nerd Font;
        border: none;
        background-color: transparent;
        margin: 0 5px; 
      }

      tooltip {
        background: ${bg};
      }

      tooltip label {
        color: ${fg};
      }

      #workspaces {
        background: ${bg};
        color: ${fg};
        border-radius: 5px;
        min-height: 40px;
        font-size: 20px;
      }
      
      #clock, #custom-tray {
        background: ${bg};
        color: ${fg};
        border-radius: 5px;
        min-height: 40px;
        font-size: 12px;
        min-width: 60px;
        padding: 0 10px;
      }

      #custom-screenshot {
        font-size: 16px;
        margin: 0 10px;
      }

      #clock {
        font-weight: bold;
      }

      #tray menu {
        background: ${bg};
      }

      #wireplumber, #pulseaudio {
        background: ${bg};
        color: ${fg};
        border-radius: 5px;
        min-height: 40px;
        font-size: 12px;
        min-width: 100px;
      }

      #mpris {
        background: ${bg};
        color: ${fg};
        border-radius: 5px;
        min-height: 40px;
        font-size: 12px;
        min-width: 100px;
        padding: 0 10px;
      }

      #mpris.playing {
        background: ${blue};
        color: ${bg};
      }

      #custom-power-menu {
        min-height: 40px;
        min-width: 40px;
        border-radius: 5px;
        padding-left: 7px;
        padding-right: 13px;
        background: ${red};
        color: ${bg};
      }

      #custom-launcher {
        min-height: 40px;
        min-width: 40px;
        font-size: 20px;
        border-radius: 5px;
        padding-left: 7px;
        padding-right: 13px;
        background: ${fg};
        color: ${bg};
      }

      #cpu-stat {
        min-height: 40px;
        min-width: 40px;
        border-radius: 5px;
        padding-left: 7px;
        padding-right: 13px;
        padding: 0 10px;
        background: ${cyan};
        font-size: 12px;
        color: ${bg};
      }

      #mem-stat {
        min-height: 40px;
        min-width: 40px;
        border-radius: 5px;
        padding-left: 7px;
        padding-right: 13px;
        padding: 0 10px;
        background: ${green};
        font-size: 12px;
        color: ${bg};
      }
    '';
  };
}
