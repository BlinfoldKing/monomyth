{ palette, ... }: {
  services.mako = with palette; {
    enable = true;

    layer = "top";
    anchor = "top-right";

    defaultTimeout = 5000;

    backgroundColor = "#${base00}";
    textColor = "#${base05}";
    borderColor = "#${base08}";
    progressColor = "#${base0B}";

    borderRadius = 5;
    padding = "10";
  };
}
