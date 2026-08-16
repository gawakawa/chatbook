{
  description = "chatbook dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.nodejs_24 ];
          shellHook = ''
            corepack enable --install-directory "$PWD/.direnv/bin" 2>/dev/null || true
            export PATH="$PWD/.direnv/bin:$PATH"
          '';
        };
      });
}
