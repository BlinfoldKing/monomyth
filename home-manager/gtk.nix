{ pkgs, ... }: {
  gtk = {
    enable = true;
    theme = {
      package = pkgs.whitesur-gtk-theme;
      name = "GTK Big Sur";
    };
  };
}
