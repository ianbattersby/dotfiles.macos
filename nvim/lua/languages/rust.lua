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

  -- -nargs=* -complete=customlist,v:lua.rust_tools_get_graphviz_backends
  if rt_config.commands then
    for k, v in pairs(rt_config.commands) do
      local nvim_opts = { desc = v.description or nil }

      if k == "RustViewCrateGraph" then
        -- There is no easy to way to translate this automatically, in example:
        -- "-nargs=* -complete=customlist,v:lua.rust_tools_get_graphviz_backends"
        nvim_opts = vim.tbl_deep_extend("force", nvim_opts, {
          nargs = "*",
          complete = function(_, _, _)
            return require("rust-tools").rust_tools_get_graphviz_backends()
          end,
        })
      elseif k == "RustSSR" then
        nvim_opts = vim.tbl_deep_extend("force", nvim_opts, { nargs = "?" })
      end

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
