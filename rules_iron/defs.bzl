"""Rules to build and run code written in 'iron' language."""

load(
    "@bazel_toolchains_explained//rules-iron/private:iron_binary_v0.bzl",
    iron_binary_v0 = "iron_binary",
)

def iron_binary(name, **kwargs):
    """To be described."""
    iron_binary_v0(name = name, **kwargs)
