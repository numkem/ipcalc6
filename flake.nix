{
  description = ''an ipv6 calculator built in rust that "looks and feel" like the ipcalc command on linux'';

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: rec {
        packages.ipcalc6 = pkgs.rustPlatform.buildRustPackage {
          pname = "ipcacl6";
          version = "0.1.0";

          src = ./.;

          cargoSha256 = "sha256-wo+l3UQrJaPfHFKwXNDqaKV+5dXE+8EgpSAkXYmk2vY=";
        };

        packages.default = self'.packages.ipcalc6;

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustc
            cargo
          ];
        };
      };
      flake = { };
    };
}
