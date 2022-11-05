-- Inspired and significantly reliant on the awesome rust-tools.nvim, but
-- lconfig allows more control and to follow the setup pattern already used.
-- https://github.com/simrat39/rust-tools.nvim
--
-- Hack to workaround the removal of config-based commands support:
-- https://github.com/neovim/nvim-lspconfig/pull/2092

local function merge_config()
  local rt_config = require("rust-tools").config.options.server

  local rt_keymaps = {
    {
      mode = "n",
      keybinding = "<leader>cc",
      action = ':lua require("rust-tools.hover_actions").hover_actions()<CR>',
      desc = "Actions (Hover)",
    },
  }

  local rt_commands = {}

  if rt_config.commands then
    for k, v in pairs(rt_config.commands) do
      local nargs = v[2] and (string.match(v[2], "-nargs=([0-9?*]) ") or string.match(v[2], "-nargs=([0-9?*])$")) or nil
      local complete = v[2] and (string.match(v[2], "-complete=(.*) ") or string.match(v[2], "-complete=(.*)$")) or nil

      local nvim_opts = {
        desc = v.description or nil,
        nargs = nargs,
        complete = complete,
      }

      rt_commands[k] = {
        name = k,
        command = v[1],
        opts = nvim_opts,
      }
    end
  end

  local config = vim.tbl_deep_extend("keep", {}, rt_config)

  config.on_attach = require("lspbuilder").new(rt_keymaps, rt_commands):on_attach() -- Use our attach function
  config.commands = {} -- Newer versions of lspconfig want you to use nvim_create_user_command

  return config
end

return { server = "rust_analyzer", config = merge_config() }
