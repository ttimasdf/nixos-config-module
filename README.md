# Private Module

This module serves as a template for the private module in [`flake.nix`](https://github.com/ttimasdf/nixos-config/blob/main/flake.nix) within [ttimasdf/nixos-config](https://github.com/ttimasdf/nixos-config).

## Usage

### Adding the private flake into your public flake

Include the following in your flake inputs:

```nix
inputs = {
  private-module = {
    url = "github:<your_username>/nixos-config-private";
    inputs.nixpkgs.follows = "nixpkgs";
    # inputs.nixos-unified.follows = "nixos-unified";
    # inputs.flake-parts.follows = "flake-parts";
  };
};
```

### Create a GitHub Fine-grained personal access token

1.  Create a new GitHub Fine-grained personal access token at https://github.com/settings/personal-access-tokens with the following permissions:
    - repository: `<your_username>/nixos-config-private`
    - permissions: **content** (read-only), **metadata** (read-only)

    The token should start with `github_pat_xxxxx`
2.  Set up the GitHub access token in `~/.config/nix/nix.conf`
    ```ini
    access-tokens = github.com=github_pat_xxxxxxxx
    ```
    Reference: https://nix.dev/manual/nix/2.28/command-ref/conf-file#conf-access-tokens
3.  Run `nix flake update private-module` to verify that the access token has been successfully applied.
    If no error message appears, the setup is complete.


### Write NixOS modules

Add new NixOS modules in the [`modules/nixos`](modules/nixos) folder.

### Import private NixOS modules from your own flake

For example, to import `all` modules from `private-module`:

```nix
{ flake, ... }:

let
  inherit (flake.inputs) private-module;
in
{
  imports = [
    private-module.nixosModules.all
    # ... other modules
  ];
}
```

The best practice is to import `all` module to automatically load everything else, avoiding the exposure of your internal module structure.

### Writing NixOS config

You can write machine-specific configurations in the [`modules/nixos/configurations`](modules/nixos/configurations) folder. Refer to [`modules/nixos/configurations/example.nix`](modules/nixos/configurations/example.nix) for an example:

```nix
{ flake, config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.networking.hostName == "example") {
    networking.hosts = {
      "127.0.0.1" = [ "example.com" ];
    };
  };
}
```
