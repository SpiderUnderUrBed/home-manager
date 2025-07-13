{ pkgs, lib, inputs, specialArgs, ... }:
let
  gitCredentialManager = specialArgs.gitCredentialManager;
  enableGeneral = false;
  general = (import ./general.nix { 
   inherit 
    pkgs 
    lib
#    config
    inputs
    #(specialArgs = { inherit gitCredentialManager; }) 
#   specialArgs = newSpecialArgs;
    specialArgs
    gitCredentialManager;
#   lib = home-manager.lib;  
  });
  #specialisation = "hydenix";
in
{
 disabledModules = [
    #"services/dunst.nix"
#    "modules/services/dunst.nix" 
 ];     
 imports = specialArgs.hm-modules ++ [ 
	general
	./themes
	#./modules/dunst.nix
	#(import ./activate.nix {
	#inherit pkgs lib specialArgs;
	#})
  ];
  home = {
    username = lib.mkForce "spiderunderurbed";
    homeDirectory = lib.mkForce "/home/spiderunderurbed"; 
  };
  
    home.enableNixpkgsReleaseCheck = false;
    home.stateVersion = "24.11";
    specialisation.general.configuration = lib.mkIf enableGeneral {
      imports = 
	#specialArgs.hm-modules ++ [ 
	 	[
		general
      		];
    };  
    specialisation.hydenix.configuration = {
         imports = 
		#specialArgs.hm-modules ++ 
		[
		 #(import ./b)
		 (import ./basic.nix { inherit pkgs lib; })		 
#                 ./hydenix/hosts/nixos/home.nix
        	];
     };   
}
