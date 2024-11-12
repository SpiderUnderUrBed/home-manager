{ gitCredentialManager ? {}, options ? {}, specialArgs ? {}, modulesPath ? {}, config, lib, pkgs }:
let
waybarConfig = {
 style = (builtins.readFile ./style.css);
 settings = [(lib.importJSON ./config.json)];
# settings = (builtins.fromJSON ''${(builtins.readFile ./config.jsonc)}'' );
};
in
waybarConfig
