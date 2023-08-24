-- Inspired and significantly reliant on the awesome rust-tools.nvim, but
-- lconfig allows more control and to follow the setup pattern already used.
-- https://github.com/simrat39/rust-tools.nvim
--
-- Hack to workaround the removal of config-based commands support:
-- https://github.com/neovim/nvim-lspconfig/pull/2092

local function initialize()
  local mason_registry = require "mason-registry"
  local mason_codelldb = mason_registry.get_package "codelldb":get_install_path()

  require "rust-tools".setup {
    tools = {
      runnables = { use_telescope = true },
      inlay_hints = { auto = false }, --{ show_parameter_hints = true },
      hover_actions = { auto_focus = true },
      -- on_initialized = function()
      --   vim.cmd [[
      --     augroup RustLSP
      --       autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
      --       autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
      --       " autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
      --     augroup END
      --   ]]
      -- end,
    },
    dap = {
      adapter = require "rust-tools.dap".get_codelldb_adapter(
        mason_codelldb .. "/codelldb",
        mason_codelldb .. "/extension/lldb/lib/liblldb.dylib"
      ),
    },
  }

  require "rust-tools.dap".setup_adapter()
end

local function merge_config()
  local rt_config = require "rust-tools".config.options.server

  local rt_keymaps = {
    {
      mode = "n",
      keybinding = "K",
      action = "<cmd>RustHoverActions<cr>",
      desc = "Hover Actions (Rust)",
    },
    {
      mode = "n",
      keybinding = "<leader>cR",
      action = "<cmd>RustCodeAction<cr>",
      desc = "Code Action (Rust)",
    },
    {
      mode = "n",
      keybinding = "<leader>dr",
      action = "<cmd>RustDebuggables<cr>",
      desc = "Run Debuggables (Rust)",
    }
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

  -- Use our attach function
  config.on_attach = require "plugins.lsp.builder".new(rt_keymaps, rt_commands):on_attach()
  config.commands = {} -- Newer versions of lspconfig want you to use nvim_create_user_command

  return config
end

return { server = "rust_analyzer", config = merge_config, initialize = initialize }
