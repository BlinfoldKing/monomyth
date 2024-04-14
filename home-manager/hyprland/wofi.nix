{ palette, ... }: {

  programs.wofi = {
    enable = true;
    settings = { };
    style = with palette;
      ''
        * {
          font-family: "Caskaydia Cove Nerd Font";
        }

        window {
          background-color: ${base00};
        }

        #inner-box {
        padding: 20px;
        }

        #outer-box {
        }

        #entry.selected {
          outline: none;
          border-radius: 0px;
        }
      '';
  };
}


