{ pkgs, palette, ... }: {
  programs.swaylock = {
    package = pkgs.swaylock-effects;
    enable = true;
    settings = {
      screenshots = true;
      clock = true;
      effect-blur = "7x5";
      effect-greyscale = true;
      fade-in = "0.2";
      ring-color = palette.base05;
      ring-clear-color = palette.base0D;
      ring-ver-color = palette.base0B;
      ring-wrong-color = palette.base08;
      ring-caps-lock-color = palette.base0C;
      key-hl-color = palette.base0B;
      line-color = palette.base00;
      separator-color = palette.base00;
      grace = 2;

      inside-color = palette.base00;
      inside-clear-color = palette.base00;
      inside-ver-color = palette.base00;
      inside-wrong-color = palette.base00;
      inside-caps-lock-color = palette.base00;

      text-color = palette.base05;
      text-clear-color = palette.base05;
      text-ver-color = palette.base05;
      text-wrong-color = palette.base05;
      text-caps-lock-color = palette.base05;
    };
  };
}
