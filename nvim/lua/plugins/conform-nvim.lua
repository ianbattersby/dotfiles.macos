return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>W",
      function()
        local cf = require "conform"
        cf.format({ async = false, lsp_fallback = true })
        vim.cmd [[w!]]
      end,
      desc = "Format and save",
    },
  },
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
