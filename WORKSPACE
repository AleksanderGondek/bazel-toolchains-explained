workspace(name = "bazel_toolchains_explained")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_cc",
    sha256 = "2037875b9a4456dce4a79d112a8ae885bbc4aad968e6587dca6e64f3a0900cdf",
    strip_prefix = "rules_cc-0.0.9",
    urls = ["https://github.com/bazelbuild/rules_cc/releases/download/0.0.9/rules_cc-0.0.9.tar.gz"],
)

# TODO: Comment
http_archive(
    name = "gcc_toolchain",
    integrity = "sha256-iqcSkkfwbhKrNWeX957qE/I4fzKuj3GEB06OZAJ5Apk=",
    strip_prefix = "gcc-toolchain-0.6.0",
    urls = ["https://github.com/f0rmiga/gcc-toolchain/archive/refs/tags/0.6.0.tar.gz"],
)

load("@gcc_toolchain//toolchain:repositories.bzl", "gcc_toolchain_dependencies")

gcc_toolchain_dependencies()

# Gcc deps setup
load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

load("@aspect_bazel_lib//lib:repositories.bzl", "aspect_bazel_lib_dependencies")

aspect_bazel_lib_dependencies()

load("@gcc_toolchain//toolchain:defs.bzl", "gcc_register_toolchain", "ARCHS")

gcc_register_toolchain(
    name = "gcc_toolchain_x86_64",
    target_arch = ARCHS.x86_64,
)

# Definitions below are outside of scope of explanations.
# They are needed to ensure sh script will be able to run in an empty container.
# (in other words: to boostrap a hermetic way of executing shell).
http_archive(
    name = "rules_sh",
    sha256 = "3243af3fcb3768633fd39f3654de773e5fb61471a2fae5762a1653c22c412d2c",
    strip_prefix = "rules_sh-0.4.0",
    urls = ["https://github.com/tweag/rules_sh/releases/download/v0.4.0/rules_sh-0.4.0.tar.gz"],
)

load("@rules_sh//sh:repositories.bzl", "rules_sh_dependencies")

rules_sh_dependencies()

load("@bazel_toolchains_explained//:hermetic_sh/defs.bzl", "hermetic_sh")

hermetic_sh(name = "busybox_sh")

register_toolchains("@busybox_sh//:toolchain")
