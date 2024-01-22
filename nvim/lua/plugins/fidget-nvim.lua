return {
  "j-hui/fidget.nvim",
  opts = {
    notification = {
      redirect = function(msg, level, opts)
        if opts and opts.on_open then
          return require "fidget.integration.nvim-notify".delegate(msg, level, opts)
        end
      end
    },
    integration = {
      ["nvim-tree"] = {
        enable = true,
      },
    },
  },
}
