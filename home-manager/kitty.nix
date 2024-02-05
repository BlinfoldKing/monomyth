{ pkgs, config, inputs, ... }: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.oxocarbon-dark;

  programs = {
    kitty = {
      enable = true;
      settings = {
        foreground = "#${config.colorScheme.palette.base05}";
        background = "#${config.colorScheme.palette.base00}";

        # black
        color0 = "#${config.colorScheme.palette.base00}";
        color8 = "#${config.colorScheme.palette.base01}";

        # red
        color1 = "#${config.colorScheme.palette.base0A}";
        color9 = "#${config.colorScheme.palette.base0C}";

        # green
        color2 = "#${config.colorScheme.palette.base0D}";
        color10 = "#${config.colorScheme.palette.base0C}";

        # yellow
        color3 = "#${config.colorScheme.palette.base0E}";
        color11 = "#${config.colorScheme.palette.base06}";

        # blue
        color4 = "#${config.colorScheme.palette.base0E}";
        color12 = "#${config.colorScheme.palette.base0F}";

        # magenta
        color5 = "#${config.colorScheme.palette.base0E}";
        color13 = "#${config.colorScheme.palette.base0F}";


        # cyan
        color6 = "#${config.colorScheme.palette.base07}";
        color14 = "#${config.colorScheme.palette.base08}";


        # white
        color7 = "#${config.colorScheme.palette.base05}";
        color15 = "#${config.colorScheme.palette.base06}";


        font_family = "Caskadia Code Nerd Font";

        tab_bar_style = "powerline";
        background_opacity = "0.8";
        window_padding_width = "10";
      };
      keybindings = {
        "F5" = "launch --location=hsplit";
        "F6" = "launch --location=vsplit";
        "F7" = "layout_action rotate";
      };
    };
  };
}
