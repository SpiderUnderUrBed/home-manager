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
    dunst = {
	enable = true;

	systemdOptions = {
          Unit.wantedBy = [ "wayland-wm@Hyprland.service" ];
    	};
	
	iconTheme = {
	  name = "Adwaita";
	  package = pkgs.adwaita-icon-theme;
	};
	settings = {
#	 icon_position = "off";
	 global = {
    	  width = 300;
    	  height = 300;
    	  offset = "30x50";
    	  origin = "top-right";
    	  transparency = 10;
    	  frame_color = "#eceff1";
    	  font = "Droid Sans 9";
         };

  	 urgency_normal = {
    	   background = "#37474f";
    	   foreground = "#eceff1";
    	   timeout = 10;
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
