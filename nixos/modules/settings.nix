{config, pkgs, lib, ...}:

with lib;

{
  options = {
    settings = {
      name = mkOption {
        default = "Bjorn Martens";
	type = with types; uniq str;
      };
      username = mkOption {
        default = "bjorn";
	type = with types; uniq str;
      };
      email = mkOption {
        default = "bjorn@expeditious.nl";
	type = with types; uniq str;
      };
      vm = mkOption {
        type = types.bool;
	default = false;
      };
    };
  };
}

