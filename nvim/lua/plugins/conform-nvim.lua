return {
  "stevearc/conform.nvim",
  config = function()
    require "conform".setup({
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
        -- lua = { "stylua" },
        yaml = { "yamlfix" },
      },
      formatters = {
        yamlfix = {
          command = require "mason-registry".get_package "yamlfix":get_install_path() .. "/venv/bin/yamlfix",
          env = {
            YAMLFIX_EXPLICIT_START = "false",
            YAMLFIX_SEQUENCE_STYLE = "block_style",
            YAMLFIX_QUOTE_BASIC_VALUES = "true",
          },
        },
      },
    })
  end,
}
