{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./default.nix
    ../hardware/desktop.nix
  ];
  networking.hostName = lib.mkForce "nixos-desktop";
  services.logind.settings.Login.HandlePowerKey = "ignore";
}
