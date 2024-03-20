"""Repository rule to boostrap simple, busybox-based sh toolchain."""

def _hermetic_sh_impl(rctx, **kwargs):
    rctx.download(
        url = rctx.attr.busybox_url,
        integrity = rctx.attr.integrity,
        output = "./busybox",
        executable = True,
    )

    busybox_path = rctx.path("./busybox")
    repo_path = busybox_path.dirname

    res = rctx.execute([
        str(busybox_path),
        "--install",
        str(repo_path),
    ], working_directory = str(repo_path))

    if res.return_code:
        fail("Could not install busybox under the execroot!")

    rctx.template("BUILD.bazel", Label("@bazel_toolchains_explained//:hermetic_sh/BUILD.bazel.template"), executable = False)

hermetic_sh = repository_rule(
    _hermetic_sh_impl,
    attrs = {
        "busybox_url": attr.string(default = "https://www.busybox.net/downloads/binaries/1.35.0-x86_64-linux-musl/busybox"),
        "integrity": attr.string(default = "sha384-L7OBIsPu9enNHn7FqpBT1kOg/mCLNmetSeNMA3i4Y60Z5jTgnlX3qX3zcQtLx5AB"),
    },
    local = False,
    configure = False,
)
