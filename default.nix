{localSystem ? builtins.currentSystem, ...} @ args: let
  external_sources = import ./nix/sources.nix;

  nixpkgs_import_args = {
    inherit localSystem;
    config = {};
  };
  nixpkgs = import external_sources.nixpkgs nixpkgs_import_args;

  devShell = nixpkgs.mkShell {
    name = "bazel_toolchains_explained-shell";

    packages = with nixpkgs; [
      alejandra
      bazel_7
      bazel-buildtools
      cocogitto
      git
      helix
      niv
      statix
    ];
  };
in {
  inherit devShell nixpkgs;
}
