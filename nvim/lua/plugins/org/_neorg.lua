local function config()
  require("neorg").setup {
    load = {
      ["core.defaults"] = {},
      --["core.integrations.telescope"] = {},
      ["core.integrations.treesitter"] = {},
      ["core.norg.concealer"] = {},
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            my_workspace = "~/neorg",
          },
          autodetect = true,
          --autochdir = true,
        },
        ["core.norg.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
      },
    },
  }
end

return {
  setup = function(use)
    use {
      "nvim-neorg/neorg",
      config = config,
      opt = true,
    }
  end,
}
