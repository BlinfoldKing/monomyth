{ palette, ... }: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      simplified_ui = true;
      default_layout = "compact";
      theme = "custom";
      on_force_close = "quit";
      pane_frames = false;
      themes.custom = with palette;{
        fg = "#${base05}";
        bg = "#${base00}";
        black = "#${base00}";
        red = "#${base08}";
        green = "#${base0B}";
        yellow = "#${base0A}";
        blue = "#${base0D}";
        magenta = "#${base0E}";
        cyan = "#${base0C}";
        white = "#${base07}";
        orange = "#${base09}";
      };
    };
  };
}
