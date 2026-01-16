{
  description = "KnownRabbit's Private NixOS Config Module (Placeholder)";

  inputs = {
    # Helpers used as inputs for other flakes
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-unified.url = "github:srid/nixos-unified";
  };

  # Wired using https://nixos-unified.org/autowiring.html
  outputs = inputs:
    inputs.nixos-unified.lib.mkFlake {
      inherit inputs;
      root = ./.;
    };
}
