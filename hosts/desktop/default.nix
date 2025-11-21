{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ../common
    ./hardware-configuration.nix
  ];
  networking.hostName = lib.mkForce "nixos-desktop";
}
