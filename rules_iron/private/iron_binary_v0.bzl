"""To be described."""

def iron_binary_impl(ctx):
    """To be described."""
    created_binary = ctx.actions.declate_file(ctx.label)

    ctx.actions.run(
        inputs = ctx.files.chunks,
        outputs = [created_binary],
        arguments = args,
        progress_message = "Merging into %s" % ctx.outputs.out.short_path,
        executable = ctx.executable.merge_tool,
    )

    return [DefaultInfo(files = depset([quasi_binary_output]))]

iron_binary = rule(
    iron_binary_v0_impl,
    attrs = {
        src: ctx.attr.label(
            allow_single_file = [".fe"],
            mandatory = True,
        ),
    },
    executable = True,
)
