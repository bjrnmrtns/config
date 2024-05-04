{ pkgs, lib, inputs, ... }: {
  programs.helix = {
    package = pkgs.helix;
    enable = true;
    languages = {
      language = [{ name = "rust"; }];
    };
    settings = {
      editor = {
        lsp.display-messages = true;
      };
    };
  };
}
