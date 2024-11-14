{ specialArgs, pkgs, lib, ... }: 
let
  enable = true;
  type = "general";

  # Define the derivation for the script using resholve.phraseSolution
  myDerivation = pkgs.stdenv.mkDerivation rec {
    pname = "specializations";
    version = "1.0";
    src = ./.;  # The source directory containing default.sh
    env = {
	inherit type;
    };
    # Define the resolution using resholve.phraseSolution
    installPhase = ''
      # Ensure the output directory exists
      mkdir -p $out
      touch $out/default.sh
      chmod +w $out/default.sh
      echo "type=\"$type\"" > $out/default.sh
      cat $src/default.sh >> $out/default.sh
      chmod +x $out/default.sh
      ${pkgs.resholve.phraseSolution "default-specializations" {
        scripts = [ "default.sh" ];  # Specify the script to resolve
        interpreter = "${pkgs.bash}/bin/bash";  # Specify the interpreter
        inputs = [ pkgs.coreutils pkgs.bash pkgs.home-manager pkgs.gawk ];  # Specify input dependencies
	execer = [
	  "cannot:${pkgs.home-manager}/bin/home-manager"
	  "cannot:home-manager"
	];
      }}

      # Optionally, run the script and log the output (uncomment if necessary)
      #$out/default.sh $type > $out/script_output.log 2>&1
    '';

    meta = with lib; {
      description = "Custom script for default specializations";
      license = licenses.mit;
      platforms = platforms.linux;
    };
  };

in
{
  home.activation = lib.mkIf enable {
    startup = specialArgs.home-manager.lib.hm.dag.entryAfter [ "writeBoundry" ] ''
      # Ensure the resolved script is called during activation
      echo "Invoking resolved script at: ${myDerivation}/default.sh"
      ${myDerivation}/default.sh  # Run the resolved script
    '';
  };
}
