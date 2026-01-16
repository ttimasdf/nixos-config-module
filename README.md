# Private Module Shim

This module is used as a placeholder for the private module in `flake.nix` in [ttimasdf/nixos-config](https://github.com/ttimasdf/nixos-config).

## Usage for Public Users

Public user should include in their flake input:

```nix
inputs = {
  ttimasdf-nixos-config = {
    url = "github:ttimasdf/nixos-config";
    inputs.private-module.follows = "private-module";
  };
  private-module = {
    url = "github:ttimasdf/nixos-config-module";
  };
};
```

Then use `inputs.ttimasdf-nixos-config.packages` and `inputs.ttimasdf-nixos-config.overlays` in their nixos config.
