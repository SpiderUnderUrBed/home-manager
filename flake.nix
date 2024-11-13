{
  description = "My project using personal NUR repository";

  inputs = {
#    nixpkgs.url = "github:NixOS/nixpkgs/71e91c409d1e654808b2621f28a327acfdad8dc2";
     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
     nixcord = {
       #url = "github:kaylorben/nixcord";
#	url = "github:AwesomeQubic/nixcord";
	url = "github:SpiderUnderUrBed/nixcord/testing";
#	url = "github:SpiderUnderUrBed/nixcord";
     };
#    auto-cpufreq = {
#      url = "github:AdnanHodzic/auto-cpufreq";
#      inputs.nixpkgs.follows = "nixpkgs";
#    };
#    envycontrol.url = "github:bayasdev/envycontrol";
#    lanzaboote = {
#      url = "github:nix-community/lanzaboote/v0.3.0";
#    };
   # sops-nix.url = "github:Mic92/sops-nix";
#    flake-compat = {
#      url = "github:edolstra/flake-compat";
#      flake = false;
#    };
    nix-revsocks.url = "github:SpiderUnderUrBed/nix-revsocks";
#    wallpaper-changer.url = "github:SpiderUnderUrBed/wallpaper-changer";
    sublimation.url = "github:SpiderUnderUrBed/sublimation";
    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
#    nix-software-center.url = "github:snowfallorg/nix-software-center";
#    arion = {
#      url = "github:hercules-ci/arion";
#      inputs.nixpkgs.follows = "nixpkgs";
#    };
   # nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#    devenv.url = "github:cachix/devenv";
 #   flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ { 
        self,
        nixpkgs, 
 #       auto-cpufreq, 
 #       envycontrol, 
 #       arion, 
        home-manager, 
#       sops-nix, 
#        nix-flatpak, 
        plasma-manager, 
  #      nix-software-center, 
  #      flake-compat, 
#       wallpaper-changer, 
	nixcord,
        nix-revsocks, 
   #     lanzaboote, 
        #flake-parts, 
        #devenv,
        nix-index-database,
	sublimation, 
        ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    gitCredentialManager = import ./gcm.nix {
#        inherit pkgs;
	pkgs = pkgs;
        lib = pkgs.lib;
        stdenv = pkgs.stdenv;
        fetchFromGitHub = pkgs.fetchFromGitHub;
        dpkg = pkgs.dpkg;
        dotnet-sdk = pkgs.dotnet-sdk;
        buildDotnetModule = pkgs.buildDotnetModule;
        dotnetCorePackages = pkgs.dotnetCorePackages;
        xorg = pkgs.xorg;
       # libICE = pkgs.libICE;
       # libSM = pkgs.libSM;
        fontconfig = pkgs.fontconfig;
        libsecret = pkgs.libsecret;
        git = pkgs.git;
        git-credential-manager = pkgs.git-credential-manager;
        mkShell = pkgs.mkShell;
    };
      hm-modules = [
	  nix-index-database.hmModules.nix-index
          sublimation.homeManagerModules.sublimation
          nixcord.homeManagerModules.nixcord
          (import ./home.nix { 
                inherit 
                   pkgs 
                   lib
                #   config
                   #(specialArgs = { inherit gitCredentialManager; }) 
                   specialArgs
                   gitCredentialManager; 
                })
      ];	
      specialArgs = { inherit gitCredentialManager; };
      lib = pkgs.lib;
      mkNixosHost = import ./hydenix/hosts/nixos;
      nix-vm = import ./hydenix/hosts/vm/nix-vm.nix;
      userConfig = import ./hydenix/config.nix;
      commonArgs = {
        inherit
          nixpkgs
          pkgs
          home-manager
          system
          userConfig
          nix-index-database
          ;
      };
  in
  {
 #   nixosConfigurations.daspidercave = nixpkgs.lib.nixosSystem {
 #     inherit system;
 #     modules = [
        #(home-manager.nixosModules.home-manager)
	#{
	  #home-manager.useGlobalPkgs = true;
          #home-manager.useUserPackages = true;
	#}
#        { home-manager.extraSpecialArgs = { gitCredentialManager = gitCredentialManager; }; }	
#	];
#    };
    homeConfigurations = {
      home-manager.useGlobalPkgs = true;      
      #home-manager.useUserPackages = false;
      home-manager.specialisation.hydenix.configuration = {
         modules = hm-modules ++ [
               ./hydenix/hosts/nixos/home.nix
         ];
      }; 
      spiderunderurbed = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
      #home-manager.specialisation.hydenix.configuration = {
      #   modules = hm-modules ++ [
      #         ./hydenix/hosts/nixos/home.nix
      #   ];
      #}; 
# gitCredentialManager; 
#system;
#        homeDirectory = "/home/spiderunderurbed";
#        username = "spiderunderurbed";
#	extraSpecialArgs = {
 #          gitCredentialManager = gitCredentialManager;
#	   
 #       };
#	  specialisation.hydenix.configuration = {
#		modules = hm-modules ++ [
#			./hydenix/hosts/nixos/home.nix
#		];
#	  }; 
          extraSpecialArgs = {
            inherit userConfig;
            inherit inputs;
          };
        #imports = [
	#shared
	modules = hm-modules;
 #       home = {
 #         stateVersion = "23.11";
 #         packages = [
#             gitCredentialManager
 #         ];
 #       };

      };
    };
  };
}

