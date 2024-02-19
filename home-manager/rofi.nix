{ config, pkgs, palette, ... }: {
  programs.rofi = {
    enable = true;

    plugins = with pkgs; [
      rofi-calc
      rofi-systemd
    ];

    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
        bg0 = "#${palette.base00}D9";
        bg1 = "#${palette.base00}D9";
        bg2 = "#${palette.base08}D9";

        fg0 = "#${palette.base05}";
        fg1 = "#${palette.base00}";
        fg2 = "#${palette.base05}";
      in
      {
        "*" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "${fg0}";
        };

        window = {
          background-color = mkLiteral "${bg0}";
          location = mkLiteral "center";
          width = 640;
          border-radius = 8;
        };

        inputbar = {
          padding = mkLiteral "12px";
          spacing = mkLiteral "12px";
          children = [ "icon-search" "entry" ];
        };

        icon-search = {
          expand = false;
          filename = "search";
          size = mkLiteral "28px";
        };

        "icon-search, entry, element-icon, element-text" = {
          vertical-align = mkLiteral "0.5";
        };

        entry = {
          font = mkLiteral "inherit";

          placeholder = "Search";
          placeholder-color = mkLiteral "${fg2}";
        };

        message = {
          border = mkLiteral "2px 0 0";
          border-color = mkLiteral "${bg1}";
          background-color = mkLiteral "${bg1}";
        };

        textbox = {
          padding = mkLiteral "8px 24px";
        };

        listview = {
          lines = 10;
          columns = 1;

          fixed-height = false;
          border = mkLiteral "1px 0 0";
          border-color = mkLiteral "${bg1}";
        };

        element = {
          padding = mkLiteral "8px 16px";
          spacing = mkLiteral "16px";
          background-color = mkLiteral "transparent";
        };

        "element normal active" = {
          text-color = mkLiteral "${bg2}";
        };

        "element selected normal, element selected active" = {
          background-color = mkLiteral "${bg2}";
          text-color = mkLiteral "${fg1}";
        };

        element-icon = {
          size = mkLiteral "1em";
        };

        element-text = {
          text-color = mkLiteral "inherit";
        };
      };
  };
}
