{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    llvm
    lldb
    fd
    zsh
  ];
}
