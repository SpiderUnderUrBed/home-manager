{ pkgs, lib, inputs, ... }:
let
wofiEnable = false;
rofiEnable = false;
hypridleEnable = true;
#hyprlockEnable = false;
walkerEnable = true;
hyprpaperEnable = true;
waybarConfig = ((import ./hyprland/waybar.nix) {  lib = lib; pkgs = pkgs; }) // { enable = true; };
hyprlandConfig = ((import ./hyprland/hyprland.nix) {  lib = lib; pkgs = pkgs; inputs = inputs; }) // { enable = true; };
hyprlockConfig = ((import ./hyprland/hyprlock.nix) { lib = lib; pkgs = pkgs; }) // { enable = true; };
in 
{
   imports = [inputs.walker.homeManagerModules.default];
   wayland.windowManager.hyprland = 
     hyprlandConfig;

   programs = {
     walker = {
       enable = true;
       runAsService = true;

       # All options from the config.json can be used here.
       config = {
        search.placeholder = "Example";
        ui.fullscreen = true;
       list = {
         height = 200;
       };
       websearch.prefix = "?";
       switcher.prefix = "/";
      };

      # If this is not set the default styling is used.
     # style = ''
     # * {
     #  color: #dcd7ba;
     #  }
     #'';
   };

     wofi = {
       enable = wofiEnable;
     };
     rofi = {
      enable = lib.mkForce rofiEnable;
     };
     hyprlock = hyprlockConfig;
     waybar = waybarConfig;
   };
   services = {
#    dunst = {
#	enable = true;
#	configFile = "./config/dunstrc";
#	systemdOptions = {
 #         Unit.wantedBy = [ "wayland-wm@Hyprland.service" ];
#    	};
#	
#	iconTheme = {
#	  name = "Adwaita";
#	  package = pkgs.adwaita-icon-theme;
#	};
#	settings = {
#	 icon_position = "off";
#	 global = {
#    	  width = 300;
#    	  height = 300;
#    	  offset = "30x50";
#    	  origin = "top-right";
#    	  transparency = 10;
#    	  frame_color = "#eceff1";
#    	  font = "Droid Sans 9";
#         };

#  	 urgency_normal = {
#    	   background = "#37474f";
#    	   foreground = "#eceff1";
#    	   timeout = 10;
#  	 };

	#};
 #   };
    dunst = {
    enable = true;
    settings = {
      global = {
        follow = "mouse";
        width = 350;
        height = "(0, 300)";
        origin = "top-right";
        offset = "(35, 35)";
        indicate_hidden = true;
        notification_limit = 5;
        gap_size = 12;
        padding = 12;
        horizontal_padding = 20;
        frame_width = 1;
        sort = false;
        progress_bar_frame_width = 0;
        progress_bar_corner_radius = 3;
        foreground = "#ffffff";
        frame_color = "#FF8C00";
        highlight = "#FF8C00";
        font = "Noto Sans CJK JP 10";
        markup = "full";
        format = "<small>%a</small>\n<b>%s</b>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = -1;
        hide_duplicate_count = false;
        icon_position = "left";
        min_icon_size = 54;
        max_icon_size = 80;
        icon_path = "/usr/share/icons/Arc/status/96:/usr/share/icons/Arc/status/symbolic";
        icon_corner_radius = 4;
        dmenu = "wofi --show drun --prompt 'Open with'";
        corner_radius = 10;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };
      urgency_low = {
        background = "#FF8C00f0";
        timeout = 3;
      };
      urgency_normal = {
        background = "#FF8C00f0";
        timeout = 8;
      };
      urgency_critical = {
        background = "#FF8C00f0";
        frame_color = "#FF8C00";
        highlight = "#FF8C00";
        timeout = 0;
      };
      fullscreen_delay_everything = {
        fullscreen = "delay";
      };
      fullscreen_show_critical = {
        msg_urgency = "critical";
        fullscreen = "show";
      };
    };
  };
    swayosd.enable = true;
    hypridle = {
        enable = hypridleEnable;
        settings = {
        general = {
            after_sleep_cmd = "hyprctl dispatch dpms on";
            ignore_dbus_inhibit = false;
            lock_cmd = "hyprlock";
          };

          listener = [
            {
               timeout = 1200;  
  #           timeout = 480;
               on-timeout = "hyprlock";
            }
            {
                timeout = 1200;
                on-timeout = "hyprctl dispatch dpms off";
                on-resume = "hyprctl dispatch dpms on";
            }
          ];
        };      
    }; 
    hyprpaper = {
        enable = hyprpaperEnable;
        package = pkgs.hyprpaper;
        settings = {
          ipc = "off";
          splash = true;
          splash_offset = 2.0;

          preload = [
                "/home/spiderunderurbed/backrounds/cotl-1.jpg"
                "/home/spiderunderurbed/backrounds/cotl-2.png"
          ];
        #   [ "/share/wallpapers/buttons.png" "/share/wallpapers/cat_pacman.png" ];

          wallpaper = [
            "eDP-1,/home/spiderunderurbed/backrounds/cotl-2.png"
            "HDMI-A-1,/home/spiderunderurbed/backrounds/cotl-2.png"
          ];
        };
    };
  };
}

