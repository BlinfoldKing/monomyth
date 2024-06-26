{ pkgs, inputs, palette, lib, config, ... }:
let
  widgetDir = "${./widgets}";
  # eww -c ${widgetDir} open-many header tray workspace-primary workspace-secondary quicklaunch &
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    swww init &
    sleep 1 &
    nm-applet &
    blueman-applet &
    waybar &
    swww img ${./../../assets/wallpapers/Sif.png} &
  '';

in
{
  imports = [
    (import ./wofi.nix { inherit pkgs palette; })
    (import ./waybar.nix { inherit pkgs palette; })
    (import ./swaylock.nix { inherit pkgs palette; })
    (import ./wlogout.nix { inherit pkgs palette; })
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = with palette; {
      # prefer display port
      # TODO: make this value not hardcoded

      monitor = with buildConfig; [
        "DP-2,3440x1440@59.99,0x0,auto"
        "HDMI-A-1,1920x1080@60,760x1440,1"
      ];

      workspace = [
        # first monitor
        "1,monitor:DP-2,default:true"
        "2,monitor:DP-2,"
        "3,monitor:DP-2,"
        "4,monitor:DP-2,"
        "5,monitor:DP-2,"

        # second monitor
        "6,monitor:HDMI-A-1,"
        "7,monitor:HDMI-A-1,"
        "8,monitor:HDMI-A-1,"
        "9,monitor:HDMI-A-1,"
        "10,monitor:HDMI-A-1,"
      ];

      general = {

        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgb(${base08}) rgb(${base05}) 60deg";
        "col.inactive_border" = "rgb(${base01})";

        "col.nogroup_border_active" = "rgb(${base08}) rgb(${base05}) 60deg";
        "col.nogroup_border" = "rgb(${base01})";


        layout = "dwindle";

        allow_tearing = false;
      };

      group = {
        "col.border_active" = "rgb(${base08}) rgb(${base05}) 60deg";
        "col.border_inactive" = "rgb(${base01})";

        groupbar = {
          enabled = true;
          "col.active" = "rgb(${base08})";
          "col.inactive" = "rgb(${base05})";
        };
      };

      opengl = {
        nvidia_anti_flicker = true;
      };

      decoration =
        {
          rounding = 5;

          blur = {
            enabled = true;
            size = 10;
            passes = 1;
          };

          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgb(${base00})";
        };

      misc = {
        disable_hyprland_logo = true;
      };


      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$menu" = import ./tofi/default.nix { inherit pkgs palette; };
      "$lock" = "swaylock";
      "$power" = "wlogout";

      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];

      dwindle = {
        preserve_split = true;
        no_gaps_when_only = false;
        smart_split = false;
      };


      windowrulev2 = [
        "stayfocused,class:^(rofi)"
        "float,title:(Bluetooth Devices)"
        "float,title:(Network Connections)"
        "float,title:(Pipewire Volume Control)"
        "opacity 0.95 0.95,class:^(google-chrome)"
        "opacity 0.95 0.95,class:^(kitty)"
      ];

      "$mod1" = "SUPER";
      "$mod2" = "ALT";

      bind = [
        "$mod1, RETURN, exec, $terminal"
        "$mod1, L, exec, $lock"
        "$mod1, Q, killactive, "
        "$mod1, M, exec, $power"
        "$mod1, E, exec, $fileManager"
        "$mod1, F, togglefloating, "
        "$mod1, R, exec, $menu"
        "$mod1, P, pseudo,"
        "$mod1, J, togglesplit,"
        "$mod1, G, togglegroup,"

        "$mod1, mouse_down, workspace, e+1"
        "$mod1, mouse_up, workspace, e-1"

        "$mod1, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

        "$mod2, 1, workspace, 1"
        "$mod2, 2, workspace, 2"
        "$mod2, 3, workspace, 3"
        "$mod2, 4, workspace, 4"
        "$mod2, 5, workspace, 5"
        "$mod2, 6, workspace, 6"
        "$mod2, 7, workspace, 7"
        "$mod2, 8, workspace, 8"
        "$mod2, 9, workspace, 9"
        "$mod2, 0, workspace, 10"

        "$mod2 SHIFT, 1, movetoworkspace, 1"
        "$mod2 SHIFT, 2, movetoworkspace, 2"
        "$mod2 SHIFT, 3, movetoworkspace, 3"
        "$mod2 SHIFT, 4, movetoworkspace, 4"
        "$mod2 SHIFT, 5, movetoworkspace, 5"
        "$mod2 SHIFT, 6, movetoworkspace, 6"
        "$mod2 SHIFT, 7, movetoworkspace, 7"
        "$mod2 SHIFT, 8, movetoworkspace, 8"
        "$mod2 SHIFT, 9, movetoworkspace, 9"
        "$mod2 SHIFT, 0, movetoworkspace, 10"

        "$mod2, S, togglespecialworkspace, magic"
        "$mod2 SHIFT, S, movetoworkspace, special:magic"
      ];

      bindm = [
        "$mod1, mouse:272, movewindow"
        "$mod1, mouse:273, resizewindow"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
      ];

      bindl = [
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      exec-once = [
        "wl-paste --type text --watch cliphist store" #Stores only text data
        "wl-paste --type image --watch cliphist store" #Stores only image data 

        "xhost + > /dev/null"
        "${startupScript}/bin/start"
      ];
    };
  };
}
