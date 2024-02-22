{ palette, ... }:
let
  lock-icon = ''url("${../../assets/icons/lock_white.png}")'';
  logout-icon = ''url("${../../assets/icons/logout_white.png}")'';
  suspend-icon = ''url("${../../assets/icons/suspend_white.png}")'';
  hibernate-icon = ''url("${../../assets/icons/hibernate_white.png}")'';
  shutdown-icon = ''url("${../../assets/icons/shutdown_white.png}")'';
  reboot-icon = ''url("${../../assets/icons/reboot_white.png}")'';
in
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        text = "shutdown";
        action = "systemctl poweroff";
        keybind = "s";
      }

      {
        label = "logout";
        text = "logout";
        action = "pkill -KILL -u $USER";
        keybind = "l";
      }

      {
        label = "reboot";
        text = "reboot";
        action = "systemctl reboot";
        keybind = "r";
      }

      {
        label = "lock";
        text = "lock";
        action = "swaylock";
        keybind = "l";
      }

      {
        label = "suspend";
        text = "suspend";
        action = "systemctl suspend";
        keybind = "u";
      }

      {
        label = "hibernate";
        text = "hibernate";
        action = "systemctl hibernate";
        keybind = "h";
      }
    ];
    style = ''  
      * {
        font-family: Caskaydia Cove Nerd Font;
        background-image: none;
        box-shadow: none;
      }

      window {
        background: none;
      }

      button {
        border-radius: 20px;
        color: #${palette.base05};
        background-color: #${palette.base00};
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        outline-style: none;
      }
      
      button:focus, button:hover, button:active {
          background-color: #${palette.base05};
          color: #${palette.base00};
      }

      #lock {
        background-image: image(${lock-icon}, ${lock-icon});
      }

      #logout {
        background-image: image(${logout-icon}, ${logout-icon});
      }

      #suspend {
        background-image: image(${suspend-icon}, ${suspend-icon});
      }

      #hibernate {
        background-image: image(${hibernate-icon}, ${hibernate-icon});
      }

      #shutdown {
        background-image: image(${shutdown-icon}, ${shutdown-icon});
      }

      #reboot {
        background-image: image(${reboot-icon}, ${reboot-icon});
      }
    '';
  };
}
