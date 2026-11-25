# Public no-op shim for the private module's option surface.
#
# The reference configuration in ttimasdf/nixos-config sets a handful of
# `rabitprivate.nixos.*` options that are implemented by the real private
# module. This file declares the same options and default values so that the
# public configuration evaluates (and `nix flake check` passes) without access
# to the private repository.
#
# Real deployments replace this input with the private checkout, e.g.
#   --override-input private-module path:./private
# (the `xc` tasks in the reference configuration do this automatically).
#
# If the public configuration starts using a new `rabitprivate.*` option, add a
# matching declaration here.
{ lib, ... }:
{
  options.rabitprivate.nixos = {
    hosts = {
      corpo.enable = lib.mkEnableOption "corpo host entries";
      intra.enable = lib.mkEnableOption "intra host entries";
      pentest.enable = lib.mkEnableOption "pentest host entries";
    };

    cacerts = {
      csteam.enable = lib.mkEnableOption "csteam CA certificate";
      csteam2.enable = lib.mkEnableOption "csteam2 CA certificate";
      mitmca.enable = lib.mkEnableOption "mitmca CA certificate";
      mitmca2.enable = lib.mkEnableOption "mitmca2 CA certificate";
    };

    homelab.domain = lib.mkOption {
      type = lib.types.str;
      default = "rabit.lan";
      description = "Domain name of the intra network.";
    };
  };
}
