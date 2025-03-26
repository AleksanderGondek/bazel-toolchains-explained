{localSystem ? builtins.currentSystem, ...} @ args: let
  external_sources = import ./nix/sources.nix;

  nixpkgs_import_args = {
    inherit localSystem;
    config = {};
  };
  nixpkgs = import external_sources.nixpkgs nixpkgs_import_args;

  # To use bazelisk, not Bazel
  devShell = (nixpkgs.buildFHSEnv {
    name = "bazel_toolchains_explained-shell";

    targetPkgs = pkgs: (with pkgs; [
      alejandra
      bashInteractive
      bazelisk
      bazel-buildtools
      cocogitto
      git
      helix
      niv
      statix
      # Required by downloaded bazel
      zlib
    ]);

    runScript = nixpkgs.writeScript "bazel_toolchains_explained-shell-init.sh" ''
      cat <<EOF > user.bazelrc
      # Bazel from nix fails processing of repo-rules
      # without this being set (sic!)
      # TODO: Investigate further.
      # (/bin:/usr/bin are for the benefit of the 'hermetic' gcc toolchain...)
      common --action_env='PATH=/bin:/usr/bin:$PATH'
      EOF
      exec bash
    '';
  }).env;
in {
  inherit devShell nixpkgs;
}
