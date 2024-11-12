{ pkgs, config, lib, specialArgs, ... }:
#let keychain = pkgs.writeShellApplication {
#       name = "keychain";
#       runtimeInputs = [ pkgs.keychain ];
 #       text = "keychain --eval --agents ssh id_ecdsa_sk --timeout 5";  
#    };
# in
let keychain = "null";
#  regex = "github:([[:alnum:].-]+)/([[:alnum:]/-]+)/([0-9a-f]{40})";
#  userPlugins = value: { rev, branch ? null, deepClone ? false, fetchSubmodules ? false }: let
#    matches = builtins.match regex value;
#    owner = builtins.elemAt matches 0;
#    repo = builtins.elemAt matches 1;
#  in builtins.fetchGit {
#    url = "https://github.com/${owner}/${repo}";
#    inherit rev;
#    inherit branch;
#    inherit deepClone;
#    inherit fetchSubmodules;
#  };
# nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};
#hyprlandConfig = { 
#inherit (import ./hyprland.nix);
#enable = true;
#};
#hyprlandConfig = ((import ./hyprland.nix).hyprlandConfig) // { enable = true; };
 #hyprlandConfig = ((import ./hyprland.nix) {config lib pkgs}).hyprlandConfig // {enable = false;};
#hyprlandConfig = ((import ./hyprland.nix) { config = config; lib = lib; pkgs = pkgs; }).hyprlandConfig // { enable = false; };
waybarConfig = ((import ./waybar.nix) { config = config; lib = lib; pkgs = pkgs; }) // { enable = true; };
hyprlandConfig = ((import ./hyprland.nix) { config = config; lib = lib; pkgs = pkgs; }) // { enable = true; };
in
{
 # imports = lib.attrValues nur.repos.moredhel.hmModules.rawModules;
  home = {
    username = "spiderunderurbed";
    homeDirectory = "/home/spiderunderurbed";
  };
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.11";
  home.packages = [
    # (import ./modules/wallpaper-changer  { folder = "./wallpapers"; })
  ];
  home.sessionVariables = {
#GSK_RENDERER=gl
    GSK_RENDERER = "gl";
  };
  services = {
    swayosd.enable = true;
  };
#  services.unison = {
#    enable = lib.mkOverride true;
#    profiles = {
#      org = {
#        src = "/home/moredhel/org";
#        dest = "/home/moredhel/org.backup";
#        extraArgs = "-batch -watch -ui text -repeat 60 -fat";
#      };
#    };
#  };
#  programs.mpv = {
#    enable = true;
##    profiles = {
##      osc="no";
##    };
##    osc=false;
#    config.osc = "no";
#    scripts = builtins.attrValues {
#      inherit
#        (pkgs.mpvScripts)
#        sponsorblock
#        thumbfast
#        mpv-webm
#        uosc
#        ;
#    };
#}; 
#  programs.mpv = {
 #   enable = true;
#    config.osc = "no";
 #   scripts = [ pkgs.mpvScripts.thumbfast ];
#  };  
#  global-keybind = {
#   enable = true;
#   device = "/dev/input/event0";
#   display = ":1";
#   key_to_press = 125;
#   key_to_send = "Super_L";
#  };
#dconf = {    
#     settings = {
#      "org/virt-manager/virt-manager/connections" = {
#           autoconnect = ["qemu:///system"];
#           uris = ["qemu:///system"];
#          };
#         };
#      };
wayland.windowManager.hyprland = hyprlandConfig;
# { inherit (hyprlandConfig); };
 #wayland.windowManager.hyprland = 
#{
#   enable = false;
#   #bind=SUPER,F,fullscreen 
#   settings = {
#     "$terminal" = "konsole";
#     "exec-once" = "${pkgs.blueman}/bin/blueman-applet,${pkgs.waybar}/bin/waybar";#
	#nwg-panel
#"${pkgs.waybar}/bin/waybar"
#     "misc:overlay" = "0";
#	hyprctl kill
#     bind = [
#Super+C = kill window
	#"SUPER+SHIFT+LEFT,movewindow,mon:eDP-1"
	#"SUPER+SHIFT+RIGHT,movewindow,mon:HDMI-A-1"
	#"SUPER+SHIFT+RIGHT,movewindow,mon:r"
	#"SUPER+SHIFT+LEFT,movewindow,mon:l"
#	"SUPER+SHIFT,V,exec,flatpak run dev.vencord.Vesktop"
#	"SUPER,K,exec,hyprctl kill"
#	"SUPER,L,exec,librewolf"
#	"SUPER+F,1,fullscreen"
#	"SUPER,F,fullscreen,1"	
 #    ];
#	++ (
#	 builtins.concatLists(builtins.genList (i:
#	 	let ws = i + 1;
#			in [
#			
#			]
#	)
   # misc = {
    #  default_terminal = "konsole"; # e.g., "alacritty", "foot", "kitty"
    #};
  # };
  #keybinds = [
  #  { mod = "SUPER"; key = "F"; action = "fullscreen"; }
  #];
  # extraConfig = (builtins.readFile /etc/nixos/spiderunderurbed/hyprland.conf);
#''
	#$terminal = konsole
#   '';
 #};
 programs = {
    waybar = waybarConfig;
   # waybar = waybarConfig // { enable = true; };
    nixcord = {
      vesktop.enable = true;
      enable = true;
      userPlugins = {	
	#hideUsers = "git+file:///home/spiderunderurbed/projects/vesktop/hideUsers/target/debug/userplugins/hideUser";
#	hideUsers = "github:SpiderUnderUrBed/hideUsers/7ab6d9d74d393b56684da7760fbe44e5684c1924";
	vc-betterActivities = "github:D3SOX/vc-betterActivities/b42afcd35d0ade108114b301859c7a077f45a8d5";
#	hideUsers = "git+file:///home/spiderunderurbed/projects/vesktop/hideUsers/target/debug/userplugins/hideUser?ref=059e3d299c0f948d0711c04a6f69375e4ed2eee2";
	hideUsers = "/home/spiderunderurbed/projects/vesktop/attempt-2/hideUsers";
	#hideUsers = "git+file:///home/spiderunderurbed/Documents/Vencord/src/userplugins/hideUser?ref=79e77997b25c324bad86e8f8332babdc846b6182";
     };
      extraConfig = {
	
	plugins = {
	vc-betterActivities.enable = true;
#	noDevtoolsWarning = true;
	hideUsers.enable = true;
	};
      };
      config = {
#	userPlugins = {   
#          hideUsers = "github:SpiderUnderUrBed/hideUsers/77d0b79b37ff422ae817830f1fe26372af6f2cbce6c327c7763bc2f62858eed1";
#        };
	enableReactDevtools = true;
	plugins = {
	 # hideUsers.enable = true;
	  noDevtoolsWarning.enable = true;
	  messageLogger.enable = true;
	  reviewDB.enable = true;
	};	
      };
    };
    #  firefox = {
    #    enable = true;
    #    package = pkgs.librewolf;
    #    nativeMessagingHosts = [ pkgs.plasma-browser-integration ];
    #    policies.ExtensionSettings = {
    #           "uBlock0@raymondhill.net" = {
    #                install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
    #                installation_mode = "force_installed";
    #            };
    #            "446900e4-71c2-419f-a6a7-df9c091e268b" = {
    #                install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
    #                installation_mode = "force_installed";
    #            };      
    #      };
    #};
   #    chromium = {
   #     enable = true;
   #     package = pkgs.brave;
   #     extensions = [
   #       { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
   #       { id = "nngceckbapebfimnlniiiahkandclblb"; }
   #       { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; }
   #       { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }
   #    ];
   # };
 
#dconf = {    
#     settings = {
#      "org/virt-manager/virt-manager/connections" = {
#          autoconnect = ["qemu:///system"];
#          uris = ["qemu:///system"];
#         };
#        };
#      };
#       }
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    mpv = {
       enable = true;
#    profiles = {
#       osc="no";
#    };

#    osc=false;
        config.osc = "no";
        scripts = builtins.attrValues {
          inherit
            (pkgs.mpvScripts)
            sponsorblock
            thumbfast
            mpv-webm
            uosc
            ;
        };
   
    }; 
    git = {
        enable = true;
#       extraConfig = {
#         credential.helper = "${
#         pkgs.override { withLibsecret = true; }
#        }/bin/git-credential-libsecret";
#       };
#       package = pkgs.gitFull;
#       config.credential.helper = "libsecret";
        extraConfig = {
        # credentialStore = "store"; 
	credential = {
	  credentialStore = "secretservice";
          helper = "${specialArgs.gitCredentialManager}/bin/git-credential-manager";
	};
         #helper = "${specialArgs.nurPkgs.repos.utybo.git-credential-manager}/bin/git-credential-manager-core";
        };
    };
    librewolf = {
        enable = false;
#       nativeMessagingHosts = [ pkgs.plasma-browser-integration ];
   };
    bash = {
      enable = true;
      bashrcExtra = ''
#        eval $(ksuperkey)
        alias nix-gc='nix-collect-garbage'
        alias facer='/etc/nixos/acer-predator-turbo-and-rgb-keyboard-linux-module/facer_rgb.py'
	alias clipboard='copyq "copy(input())"'
	#alias clipboard='xclip -selection clipboard'
        if not [ ! -x /bin/sudo ]; then
                alias sudo='/bin/sudo '
        else
                alias sudo='/run/wrappers/bin/sudo '
        fi

        #alias sudo='/run/wrappers/bin/sudo'
        export PATH=$PATH:/home/spiderunderurbed/.cargo/bin
 	export NIXPKGS_ALLOW_UNFREE=1
        eval $(thefuck --alias)
        eval "$(zoxide init bash)"
#	export NIXPKGS_ALLOW_UNFREE=1

        #eval ()
#       clear
        hyfetch
#       ##${keychain}/bin/keychain
#        . ~/oldbashrc
      '';
    };
 #  nix-revsocks = {
 #       enable = true;
 #       instances."first instance".connect = "192.168.68.77";
 #   };
  #  wallpaper-changer = {
  #    enable = true;
  #    folder = "test";
  #  };
#    plasma = {
#      enable = true;
#      workspace = {
#        clickItemTo = "select";
#        lookAndFeel = "YaruPlasma.V1.Plasma6";
#       # cursorTheme = "Bibata-Modern-Ice";
#       # iconTheme = "papirus-icon-theme";
#        wallpaper = "/home/spiderunderurbed/test2.png";
#      };
#      hotkeys.commands = {
#        "yakuake" = {
#          key = "Meta+`";
#          command = "yakuake";
#        };
#      };
#      shortcuts = {
#        ksmserver = {
#          "Lock Session" = [ "Screensaver" "Meta+Ctrl+Alt+L" ];
#        };
#        kwin = {
#          "Expose" = "Meta+,";
#          "Switch Window Down" = "Meta+J";
#          "Switch Window Left" = "Meta+H";
#          "Switch Window Right" = "Meta+L";
#          "Switch Window Up" = "Meta+K";
#        };
#      };
 #     configFile = {
#        "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
#        "kwinrc"."org\\.kde\\.kdecoration2"."ButtonsOnLeft" = "SF";
#       "kwinrc"."ModifierOnlyShortcuts"."Meta" = "org.kde.plasmashell,/PlasmaShell,org.kde.PlasmaShell,activateLauncherMenu"; 
#"org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu";
#      };
 
  #   utils.kconfig.files.kwinrc.items = [
   #     (mkItem "ModifierOnlyShortcuts" "Meta" "org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu")
   #   ];

    #  utils.kconfig.files.lattedockrc.items = [
   #     (mkItem "General" "Number of Actions" "0")
   #     (mkItem "PlasmaThemeExtended" "outlineWidth" "1")
   #     (mkItem "UniversalSettings" "badges3DStyle" "false")
   #     (mkItem "UniversalSettings" "canDisableBorders" "true")
   #     (mkItem "UniversalSettings" "contextMenuActionsAlwaysShown" "_layouts,_preferences,_quit_latte,_separator1,_add_latte_widgets,_add_view")
   #     (mkItem "UniversalSettings" "inAdvancedModeForEditSettings" "true")
   #     (mkItem "UniversalSettings" "inConfigureAppletsMode" "true")
   #     (mkItem "UniversalSettings" "isAvailableGeometryBroadcastedToPlasma" "true")
   #     (mkItem "UniversalSettings" "launchers" "")
   #     (mkItem "UniversalSettings" "memoryUsage" "0")
   #     (mkItem "UniversalSettings" "metaPressAndHoldEnabled" "false")
   #     (mkItem "UniversalSettings" "mouseSensitivity" "2")
   #     (mkItem "UniversalSettings" "parabolicSpread" "3")
   #     (mkItem "UniversalSettings" "parabolicThicknessMarginInfluence" "1")
   #     (mkItem "UniversalSettings" "screenTrackerInterval" "1000")
   #     (mkItem "UniversalSettings" "showInfoWindow" "true")
   #     (mkItem "UniversalSettings" "singleModeLayoutName" "MyDock")
   #     (mkItem "UniversalSettings" "version" "2")
  #    ];

 #     environment.overlay = mkOverlayTree user {
 #       lattedockrc = {
 #         target = c "lattedockrc";
 #         source = config.utils.kconfig.files.lattedockrc.path;
 #       };
#      };

#      environment.persistence = mkPersistDirsTree user [
#        (c "latte") (ls "latte")
#      ];
#    };
  };
}
