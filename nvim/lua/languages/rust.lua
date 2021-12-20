-- Inspired and significantly reliant on the awesome rust-tools.nvim, but
-- lconfig allows more control and to follow the setup pattern already used.
-- https://github.com/simrat39/rust-tools.nvim
local lconfig = require("lspbuilder").new {
  {
    mode = "n",
    keybinding = "<leader>cc",
    action = '<cmd>lua require("rust-tools.hover_actions").hover_actions()<CR>',
  },
}

local config = {
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importMergeBehavior = "last",
        importPrefix = "by_self",
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
      checkOnSave = {
        allFeatures = true,
        overrideCommand = {
          "cargo",
          "clippy",
          "--workspace",
          "--message-format=json",
          "--all-targets",
          "--all-features",
        },
      },
    },
  },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
          resolveSupport = {
            properties = { "documentation", "detail", "additionalTextEdits" },
          },
        },
      },
    },
    experimental = {
      hoverActions = true,
      hoverRange = true,
      serverStatusNotification = true,
      snippetTextEdit = true,
      codeActionGroup = true,
      ssr = true,
      commands = {
        "rust-analyzer.runSingle",
        "rust-analyzer.debugSingle",
        "rust-analyzer.showReferences",
        "rust-analyzer.gotoLocation",
        "editor.action.triggerParameterHints",
      },
    },
  },
  commands = {
    ["RustSetInlayHints"] = { require("rust-tools.inlay_hints").set_inlay_hints },
    ["RustDisableInlayHints"] = { require("rust-tools.inlay_hints").disable_inlay_hints },
    ["RustToggleInlayHints"] = { require("rust-tools.inlay_hints").toggle_inlay_hints },
    ["RustExpandMacro"] = { require("rust-tools.expand_macro").expand_macro },
    ["RustOpenCargo"] = { require("rust-tools.open_cargo_toml").open_cargo_toml },
    ["RustParentModule"] = { require("rust-tools.parent_module").parent_module },
    ["RustJoinLines"] = { require("rust-tools.join_lines").join_lines },
    ["RustRunnables"] = { require("rust-tools.runnables").runnables },
    ["RustDebuggables"] = { require("rust-tools.debuggables").debuggables },
    ["RustHoverActions"] = { require("rust-tools.hover_actions").hover_actions },
    ["RustHoverRange"] = { require("rust-tools.hover_range").hover_range },
    ["RustMoveItemDown"] = { require("rust-tools.move_item").move_item },
    ["RustMoveItemUp"] = {
      function()
        require("rust-tools.move_item").move_item(true)
      end,
    },
    ["RustViewCrateGraph"] = {
      function(backend, output)
        require("rust-tools.crate_graph").view_crate_graph(backend, output)
      end,
      "-nargs=* -complete=customlist,v:lua.rust_tools_get_graphviz_backends",
      description = "`:RustViewCrateGraph [<backend> [<output>]]` Show the crate graph",
    },
    ["RustSSR"] = {
      function(query)
        require("rust-tools.ssr").ssr(query)
      end,
      "-nargs=?",
      description = "`:RustSSR [query]` Structural Search Replace",
    },
    ["RustReloadWorkspace"] = { require("rust-tools/workspace_refresh").reload_workspace },
    ["RustCodeAction"] = {
      function()
        require("rust-tools/code_action_group").code_action_group()
      end,
    },
  },
  handlers = {
    ["textDocument/hover"] = require("rust-tools.utils.utils").mk_handler(require("rust-tools.hover_actions").handler),
    ["experimental/serverStatus"] = require("rust-tools.utils.utils").mk_handler(
      require("rust-tools.server_status").handler
    ),
  },
  on_attach = lconfig:on_attach(),
  root_dir = function(filename)
    local fname = filename or vim.api.nvim_buf_get_name(0)
    local cargo_crate_dir = require("lspconfig.util").root_pattern "Cargo.toml"(fname)
    local cmd = { "cargo", "metadata", "--no-deps", "--format-version", "1" }
    if cargo_crate_dir ~= nil then
      cmd[#cmd + 1] = "--manifest-path"
      cmd[#cmd + 1] = require("lspconfig.util").path.join(cargo_crate_dir, "Cargo.toml")
    end
    local cargo_metadata = ""
    local cm = vim.fn.jobstart(cmd, {
      on_stdout = function(_, d, _)
        cargo_metadata = table.concat(d, "\n")
      end,
      stdout_buffered = true,
    })
    if cm > 0 then
      cm = vim.fn.jobwait({ cm })[1]
    else
      cm = -1
    end
    local cargo_workspace_dir = nil
    if cm == 0 then
      cargo_workspace_dir = vim.fn.json_decode(cargo_metadata)["workspace_root"]
    end
    return cargo_workspace_dir
      or cargo_crate_dir
      or require("lspconfig.util").root_pattern "rust-project.json"(fname)
      or require("lspconfig.util").find_git_ancestor(fname)
  end,
}

local function finalize()
  require("rust-tools.commands").setup_lsp_commands()
  require("rust-tools.utils.utils").override_apply_text_edits()
end

return { server = "rust_analyzer", config = config, finalize = finalize }
