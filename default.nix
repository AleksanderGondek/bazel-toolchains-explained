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

    shellHook = ''
      cat <<EOF > user.bazelrc
      # Bazel from nix fails processing of repo-rules
      # without this being set (sic!)
      # TODO: Investigate further.
      # (/bin:/usr/bin are for the benefit of the 'hermetic' gcc toolchain...)
      common --action_env='PATH=/bin:/usr/bin:$PATH'
      EOF
    '';
  };
in {
  inherit devShell nixpkgs;
}
