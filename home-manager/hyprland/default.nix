{ pkgs, inputs, config, ... }:
let startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
  waybar &
  nm-applet &

  swww init & sleep 1 &
  swww img ${./../../assets/mario.gif} &
'';
in
{

  wayland.windowManager.hyprland = {
    enable = true;

    settings = with config.colorScheme.palette; {
      "monitor" = ",preferred,auto,auto";

      general = {

        gaps_in = 5;
        gaps_out = 20;
        border_size = 5;
        "col.active_border" = "0x${base0A} 0x${base08} 45deg";
        "col.inactive_border" = "0x${base04}";

        layout = "wdwindle";

        allow_tearing = false;
      };

      decoration =
        {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 10;

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };

          drop_shadow = "yes";
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "0x${base00}";
        };


      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";



      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];

      dwindle = {
        preserve_split = true;
        no_gaps_when_only = true;
        smart_split = true;
      };


      "windowrulev2" = "nomaximizerequest, class:.*";

      "$mod1" = "SUPER";
      "$mod2" = "ALT";

      bind = [
        "$mod1, Q, exec, $terminal"
        "$mod1, C, killactive, "
        "$mod1, M, exit, "
        "$mod1, E, exec, $fileManager"
        "$mod1, V, togglefloating, "
        "$mod1, R, exec, $menu"
        "$mod1, P, pseudo,"
        "$mod1, J, togglesplit,"
        "$mod1, G, togglegroup,"

        "$mod1, mouse_down, workspace, e+1"
        "$mod1, mouse_up, workspace, e-1"

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

      exec-once = "${startupScript}/bin/start";
    };
  };
}
