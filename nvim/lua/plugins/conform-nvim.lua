return {
  "stevearc/conform.nvim",
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
        helm = { "yamlfmt" },
        yaml = { "yamlfmt" },
        hcl = { "hclfmt" },
      },
      formatters = {
        yamlfmt = {
          command = require "mason-registry".get_package "yamlfmt":get_install_path() .. "/yamlfmt",
        },
        hclfmt = {
          command = require "mason-registry".get_package "hclfmt":get_install_path() .. "/hclfmt",
        }
      },
    })
  end,
}
