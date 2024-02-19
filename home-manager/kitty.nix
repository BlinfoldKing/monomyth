{ pkgs, inputs, palette, ... }: {
  programs = with palette;
    {
      kitty = {
        enable = true;
        settings = {
          foreground = "#${base05}";
          background = "#${base00}";

          color0 = "#${base00}";
          color8 = "#${base01}";

          #red
          color1 = "#${base08}";
          color9 = "#${base08}";

          # green
          color2 = "#${base0B}";
          color10 = "#${base0B}";

          # yellow
          color3 = "#${base0A}";
          color11 = "#${base0A}";

          # blue
          color4 = "#${base0D}";
          color12 = "#${base0D}";

          # magenta
          color5 = "#${base0E}";
          color13 = "#${base0E}";

          # cyan
          color6 = "#${base0C}";
          color14 = "#${base0C}";

          # gray
          color7 = "#${base05}";
          color15 = "#${base05}";

          # Window borders
          active_border_color = "#${base0C}";
          inactive_border_color = "#${base04}";
          bell_border_color = "#${base0A}";

          font_family = "Caskaydia Cove Nerd Font";

          # tab_bar_style = "fade";
          tab_bar_style = "powerline";
          active_tab_foreground = "#${base05}";
          active_tab_background = "#${base0A}";
          active_tab_font_style = "bold";
          inactive_tab_foreground = "#${base00}";
          inactive_tab_background = "#${base05}";
          tab_bar_background = "#${base00}";

          background_opacity = "0.95";
          window_padding_width = "10";
        };
        keybindings = {
          "F5" = "launch --location=hsplit";
          "F6" = "launch --location=vsplit";
          "F7" = "layout_action rotate";

          "shift+up" = "move_window up";
          "shift+left" = "move_window left";
          "shift+right" = "move_window right";
          "shift+down" = "move_window down";

          "ctrl+up" = "neighboring_window up";
          "ctrl+left" = "neighboring_window left";
          "ctrl+right" = "neighboring_window right";
          "ctrl+down" = "neighboring_window down";
        };
      };
    };
}
