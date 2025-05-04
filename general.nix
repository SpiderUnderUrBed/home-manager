{ pkgs, lib, inputs, specialArgs, ... }:
#let keychain = pkgs.writeShellApplication {
#       name = "keychain";
#       runtimeInputs = [ pkgs.keychain ];
 #       text = "keychain --eval --agents ssh id_ecdsa_sk --timeout 5";  
#    };
# in
let 
keychain = "null";
browser = "brave";
terminal = "konsole";
in
{
 # imports = lib.attrValues nur.repos.moredhel.hmModules.rawModules;

#    specialisation.hydenix.configuration = {
#         imports = specialArgs.hm-modules ++ [
##		./home.nix
 #              ./hydenix/hosts/nixos/home.nix
 #        ];
 #     };
  home.packages = [
    # (import ./modules/wallpaper-changer  { folder = "./wallpapers"; })
    #inputs.walker.packages.x86_64-linux.default
    pkgs.bash
  ];
#  home.activation.main = lib.hm.dag.entryAfter ["writeBoundary"]
#    ''
#	rm /home/spiderunderurbed/.gtkrc-2.0.backup	
#    '';
  xdg.desktopEntries = {
   nvim = {
     icon = "/home/spiderunderurbed/neovim.svg";
     name = "neovim";
     exec = "${terminal} -e nvim";
   };
   discord = {
    icon = "/home/spiderunderurbed/vencord.png";
    name = "vesktop";
    exec = "${browser} --app=https://discord.com/app";
   };
  };
  home.sessionVariables = {
#GSK_RENDERER=gl
    BROWSER = "librewolf";
    GSK_RENDERER = "gl";
  };
  imports = [ (import ./primary-wm.nix { inherit pkgs lib inputs; }) ];
  services = {
    #hyprpaper = {
   #	enable = hyprpaperEnable;
    #	package = pkgs.hyprpaper;
    #	settings = {
    #	  ipc = "off";
    #      splash = true;
    #      splash_offset = 2.0;

    #      preload = [
    #		"/home/spiderunderurbed/backrounds/cotl-1.jpg"
    #		"/home/spiderunderurbed/backrounds/cotl-2.png"
    #      ];
	#   [ "/share/wallpapers/buttons.png" "/share/wallpapers/cat_pacman.png" ];

    #      wallpaper = [
    #        "eDP-1,/home/spiderunderurbed/backrounds/cotl-2.png"
    #        "HDMI-A-1,/home/spiderunderurbed/backrounds/cotl-2.png"
    #	  ];
    #	};
    #};
  #  swayosd.enable = true;
 #   hypridle = {
#	enable = hypridleEnable;
#	settings = {
 #       general = {
 #           after_sleep_cmd = "hyprctl dispatch dpms on";
 #           ignore_dbus_inhibit = false;
 #           lock_cmd = "hyprlock";
 # 	  };

 #         listener = [
 #           {
 # 	       timeout = 1200;  
 # #           timeout = 480;
 #              on-timeout = "hyprlock";
 #           }
 #           {
 #               timeout = 1200;
 #               on-timeout = "hyprctl dispatch dpms off";
 #    		on-resume = "hyprctl dispatch dpms on";
 #   	    }
 # 	  ];
#	};	
#    }; 
 };
#  systemd.user.services.dunst = {
#        Unit = {
#          Description = "Dunst notification daemon";
#          After = [ "graphical-session-pre.target" ];
#          PartOf = [ "graphical-session.target" ];
#        };

#        Service = {
#          Type = "dbus";
#          BusName = "org.freedesktop.Notifications";
#          ExecStart = lib.escapeShellArgs ([ "${cfg.package}/bin/dunst" ] ++
#            # Using `-config` breaks dunst's drop-ins, so only use it when an alternative path is set
#            optionals (cfg.configFile != null) [ "-config" cfg.configFile ]);
#          Environment = optionalString (cfg.waylandDisplay != "")
#            "WAYLAND_DISPLAY=${cfg.waylandDisplay}";
#        };
#      };
#    };
#  };
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
#xwayland-satellite
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
#wayland.windowManager.hyprland = 
#{ enable = true; };
#hyprlandConfig;
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
#(vscode-with-extensions.override {
           #vscodeExtensions = with vscode-extensions; [ 
    # nvchad = {
    #	enable = false;
    #	extraPackages = with pkgs; [
    #		rust-analyzer
    #	];
    # };
     zed-editor = {
	enable = true;
	extensions = ["nix" "toml" "make"];
	installRemoteServer = true;
	userSettings = {
        lsp = {
           rust-analyzer = {
             binary = {
                        #                        path = lib.getExe pkgs.rust-analyzer;
               path_lookup = true;
             };
           };
           nix = { 
               binary = { 
                 path_lookup = true; 
              }; 
           };
	};
     };
     };
     vscode = {
	enable = true;
	userSettings = {
           "terminal.integrated.defaultProfile.linux" = "bash";
           "terminal.integrated.profiles.linux" = {
           "bash" = {
              "path" = pkgs.bash;
            };
          };
	};
        extensions = with pkgs.vscode-extensions; [
              svelte.svelte-vscode

             (pkgs.vscode-utils.buildVscodeMarketplaceExtension { 
                    mktplcRef = {
                      name = "python";
                      version = "1.19.1";

                      publisher = "ms-python";
                    };
                    vsix = /home/spiderunderurbed/ms-python-latest.zip;

               })

              ritwickdey.liveserver
              sswg.swift-lang
              vadimcn.vscode-lldb
              bbenoist.nix

              ms-vscode-remote.remote-containers
              ms-vscode-remote.remote-ssh

              rust-lang.rust-analyzer
              ms-azuretools.vscode-docker
	      arrterian.nix-env-selector
              eamodio.gitlens
          ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                #{
                #name = "rust-analyzer";
                #publisher = "rust-lang";
                #version = "0.4.2314";
                #hash = "sha256-cyeWqEqN3WVqBy8qVIXAof4LlW3FpcFV2HY7pIpBdzc=";
                ##sha256 = "ef55fd16687dc34c503fda6e46b2e3e3184b570929632244258f0cd0cf49136a";
                #}
                {
                name = "remove-comments";
                publisher = "plibither8";
                version = "1.2.2";
                sha256 = "ca2ef0e0a937a3da822c849a98c587d280b464287f590883b4febb2ec186d7de";
                }
                {
                name = "rustowl-vscode";
                publisher = "cordx56";
                version = "0.1.1";
                sha256 = "c295da5fc07b966ae79b078c71aa0e64776dcdcdf9b099f263188cf3170231d4";
                }
                {
                name = "vencord-companion";
                publisher = "Vendicated";

                version = "0.1.3";
                sha256 = "9854440646f703deb7a5a1ec3e115a60b7c87c8ea0d17f46bbd45502d5e100e4";
                }
                {

                 name = "codespaces";
                 publisher = "Github";
                 version = "1.16.17";
                 sha256 = "e9c47ef5f69b8cba144f2dc4038f6aaef4274c52b45c6b533008a3db897d546a";
                }
                {
                        name = "remote-ssh-edit";
                        publisher = "ms-vscode-remote";
                        version = "0.47.2";
                        sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
                }
                {
                        name = "Go";
                        publisher = "golang";
                        version = "0.42.0";
                        sha256 = "f47c9ee44ccbb181fc5f718de3ee27de3349d4f603ec155fccef332a882141d5";
                }

          ];
	};

#   wofi = {
#     enable = wofiEnable;
#   };
#   rofi = {
#     enable = lib.mkForce rofiEnable;
#   };
#   hyprlock = hyprlockConfig;
#    waybar = waybarConfig;
   # waybar = waybarConfig // { enable = true; };
   # blesh.enable = true;
   # direnv = {
   #   enable = true;
   #   enableBashIntegration = true; # see note on other shells below
   #   nix-direnv.enable = true;
   # };
neovim = {
  enable = true;
  plugins = with pkgs.vimPlugins; [
    nvim-lspconfig
  ];
  extraConfig = (builtins.readFile ./nvim.vim);
#''
#	set number
#	command! Ct :belowright split | resize 15 | terminal bash -c "cd %:p:h && exec bash"
#  '';
  extraLuaConfig = (builtins.readFile ./nvim.lua);
};

 #   neovim = {
#	enable = true;
#	plugins = with pkgs.vimPlugins; [
      #		nvim-lspconfig
	#];
	#extraConfig = ''
	 #require'lspconfig'.rust_analyzer.setup{
  	 # settings = {
    	 #  ['rust-analyzer'] = {
      	#	diagnostics = {
        #	  enable = false;
      	#	}
    	   #   }
  	  #  }
	 # }
	#'';
    #};
    nixcord = {
      vesktop.enable = true;
      enable = lib.mkForce true;
      userPlugins = {	
	#hideUsers = "git+file:///home/spiderunderurbed/projects/vesktop/hideUsers/target/debug/userplugins/hideUser";
#	hideUsers = "github:SpiderUnderUrBed/hideUsers/7ab6d9d74d393b56684da7760fbe44e5684c1924";
	vc-betterActivities = "github:D3SOX/vc-betterActivities/b42afcd35d0ade108114b301859c7a077f45a8d5";
#	hideUsers = "git+file:///home/spiderunderurbed/projects/vesktop/hideUsers/target/debug/userplugins/hideUser?ref=059e3d299c0f948d0711c04a6f69375e4ed2eee2";
	#hideUsers = "/home/spiderunderurbed/projects/vesktop/attempt-2/hideUsers";
	#hideUsers = "git+file:///home/spiderunderurbed/Documents/Vencord/src/userplugins/hideUser?ref=79e77997b25c324bad86e8f8332babdc846b6182";
     };
      extraConfig = {
	
	plugins = {
	review.enable = true;
	PinDMs.enable = true;
	noBlockedMessages = {
	  enable = true;
	};
	noUnblockToJump.enable = true;
	vc-betterActivities.enable = true;
#	noDevtoolsWarning = true;
	#hideUsers.enable = true;
	};
      };
      config = {
#	userPlugins = {   
#          hideUsers = "github:SpiderUnderUrBed/hideUsers/77d0b79b37ff422ae817830f1fe26372af6f2cbce6c327c7763bc2f62858eed1";
#        };
	themeLinks = [
	  "https://raw.githubusercontent.com/SpaceTheme/Discord/refs/heads/main/SpaceTheme.theme.css"
	];
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
#	alias pasystray-screen='screen -S pasystray-session -d -m pasystray'
	alias xwayland-rootless='xwayland-satellite' 
	alias facer='/etc/nixos/acer-predator-turbo-and-rgb-keyboard-linux-module/facer_rgb.py'
	#alias pasystrayd='screen -S pasystray-session -d -m pasystray'
        alias nix-gc='nix-collect-garbage'
        alias inxi-tmp="nix-shell -p inxi.out --run 'inxi'"
	alias clipboard='copyq "copy(input())"'
	#alias clipboard='xclip -selection clipboard'
        if ! [ ! -x /bin/sudo ]; then
                alias sudo='/bin/sudo '
        else
                alias sudo='/run/wrappers/bin/sudo '
        fi

        #alias sudo='/run/wrappers/bin/sudo'
        export PATH=$PATH:/home/spiderunderurbed/.cargo/bin
 	export NIXPKGS_ALLOW_UNFREE=1
	#export BLE_VERSION-=0.4.0-devel3+1a5c451c
        eval $(thefuck --alias)
        eval "$(zoxide init bash)"

	hyfetch	
	
	eval "$(direnv hook bash)"
	source "$(blesh-share)"/ble.sh --attach=none # does not work currently	 
	ble-attach
#	export NIXPKGS_ALLOW_UNFREE=1

        #eval ()
#       clear
        #hyfetch
#       ##${keychain}/bin/keychain
#        . ~/oldbashrc
#	echo test
      '';
##[[ ! ${BLE_VERSION-} ]] || 

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
