"""To be described."""

def iron_binary_impl(ctx):
    """To be described."""
    created_binary = ctx.actions.declate_file(ctx.label)

    ctx.actions.run(
        inputs = [
            ctx.file._iron_compiler_template,
        ],
        outputs = [created_binary],
        arguments = [],
        progress_message = "Iron compiling %s" % created_binary.short_path,
        executable = ctx.executable._iron_compiler,
    )

    return [DefaultInfo(files = depset([created_binary]))]

iron_binary = rule(
    iron_binary_v0_impl,
    attrs = {
        src: ctx.attr.label(
            allow_single_file = [".fe"],
            mandatory = True,
        ),
        "_iron_compiler": ctx.attr.label(
            allow_single_file = True,
            default = Label("@bazel_toolchains_explained//rules_iron/private/compiler:iron-compile.sh"),
            executable = True,
        ),
        "_iron_compiler_template": ctx.attr.label(
            allow_single_file = [".template"],
            default = Label("@bazel_toolchains_explained//rules_iron/private/compiler:iron.cpp.template"),
        ),
    },
    executable = True,
)
