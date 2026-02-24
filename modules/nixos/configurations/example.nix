{ flake, config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.networking.hostName == "example") {
    networking.hosts = {
      "127.0.0.1" = [ "example.com" ];
    };
  };
}
