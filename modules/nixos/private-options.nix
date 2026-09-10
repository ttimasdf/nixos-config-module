# Public no-op shim for the private module's option surface.
#
# The reference configuration in ttimasdf/nixos-config sets a handful of
# `rabitprivate.nixos.*` options that are implemented by the real private
# module. This placeholder declares the same options as no-ops so that the
# public configuration evaluates (and `nix flake check` passes) without access
# to the private repository.
#
# Real deployments replace this input with the private checkout, e.g.
#   --override-input private-module path:./private
# (the `xc` tasks in the reference configuration do this automatically).
#
# If the public configuration starts using a new `rabitprivate.*` option, add a
# matching no-op declaration here.
{ lib, ... }:
{
  options.rabitprivate.nixos = {
    hosts = {
      corpo.enable = lib.mkEnableOption "corpo host entries (no-op in the public shim)";
      intra.enable = lib.mkEnableOption "intra host entries (no-op in the public shim)";
      pentest.enable = lib.mkEnableOption "pentest host entries (no-op in the public shim)";
    };

    cacerts = {
      csteam.enable = lib.mkEnableOption "csteam CA certificate (no-op in the public shim)";
      csteam2.enable = lib.mkEnableOption "csteam2 CA certificate (no-op in the public shim)";
      mitmca.enable = lib.mkEnableOption "mitmca CA certificate (no-op in the public shim)";
      mitmca2.enable = lib.mkEnableOption "mitmca2 CA certificate (no-op in the public shim)";
    };
  };
}
