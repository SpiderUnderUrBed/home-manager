{ gitCredentialManager ? { }, options ? { }, specialArgs ? { }
, modulesPath ? { }, lib, pkgs }:
let
  hyprlockConfig = {
    package = pkgs.hyprlock;
    enable = true;
    settings = {
      gexneral = {
        grace = 5;
        #           hide_cursor = true;
      };
      background = {
        path = "/home/spiderunderurbed/backrounds/cotl-1.jpg";
        blur_passes = 1;
        blur_size = 7;
        #/home/spiderunderurbed/test.jpg
        #/home/spiderunderurbed/test2.png 
      };
      label = {
        #monitor =
        #           text = 'cmd[update:43200000] date +"%A, %d %B %Y"';
        #          text = "cmd[update:43200000] date +\"%A, %d %B %Y\"";
        text = ''cmd[update:43200000] date +"%A, %d %B %Y %I:%M %p"'';
        color = "$text";
        font_size = 25;
        #font_family = $font
        position = "-30, -150";
        halign = "center";
        valign = "top";
      };
      input-field = {
        #monitor =
        size = "300, 60";
        outline_thickness = 4;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "$accent";
        inner_color = "$surface0";
        font_color = "$text";
        fade_on_empty = false;
        #placeholder_text = "<span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></spa>
        #placeholder_text = "<span foreground=\"##$textAlpha\"><i>󰌾 Logged in as </i><span foreground=\"##$accentAlpha\">$USER</span><>
        placeholder_text = "Log in as spiderunderurbed";
        hide_input = false;
        check_color = "$accent";
        fail_color = "$red";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = "$yellow";
        position = "0, -47";
        halign = "center";
        valign = "center";
      };
    };
  };
in hyprlockConfig
