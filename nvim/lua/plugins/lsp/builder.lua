local M = {}

function M:init(config, keymaps, commands)
  config = config or {}
  setmetatable(config, self)
  self.__index = self
  self.lang_keymaps = keymaps or {}
  self.lang_commands = commands or {}
  self.lang_formatting = nil
  return config
end

function M.new(keymaps, commands)
  local inst = {}
  setmetatable(inst, { __index = M })
  inst:init(nil, keymaps, commands)
  return inst
end

function M.supports_format(client)
  if
    client.config
    and client.config.capabilities
    and client.config.capabilities.documentFormattingProvider == false
  then
    return false
  end
  return client.supports_method "textDocument/formatting" or client.supports_method "textDocument/rangeFormatting"
end

function M.toggle_format(toggle_state)
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    toggle_state.formatting = false
  else
    toggle_state.formatting = not toggle_state.formatting
  end

  if toggle_state.formatting then
    require "lazy.core.util".info("Enabled format on save", { title = "Format" })
  else
    require "lazy.core.util".warn("Disabled format on save", { title = "Format" })
  end
end

function M.toggle_diagnostic_virtual_text(bufnr, toggle_state)
  toggle_state.diagnostic_virtual_text = not toggle_state.diagnostic_virtual_text

  toggle_state.diagnostic_virtual_lines =
    toggle_state.diagnostic_virtual_lines and false

  M.update_diagnostic_config(bufnr, toggle_state)

  require "lazy.core.util".info(
    toggle_state.diagnostic_virtual_text and "Enabled virtual text"
    or "Disabled virtual text", { title = "Diagnostics" }
  )
end

function M.toggle_diagnostic_virtual_lines(bufnr, toggle_state)
  toggle_state.diagnostic_virtual_lines = not toggle_state.diagnostic_virtual_lines

  toggle_state.diagnostic_virtual_text =
    toggle_state.diagnostic_virtual_text and false

  M.update_diagnostic_config(bufnr, toggle_state)

  require "lazy.core.util".info(
    toggle_state.diagnostic_virtual_lines and "Enabled virtual lines"
    or "Disabled virtual lines", { title = "Diagnostics" }
  )
end

function M.update_diagnostic_config(bufnr, toggle_state)
  vim.diagnostic.show(
    nil,
    bufnr,
    nil,
    {
      virtual_text = toggle_state.diagnostic_virtual_text and require "plugins.lsp.diagnostics".virtual_text or false,
      virtual_lines = toggle_state.diagnostic_virtual_lines and require "plugins.lsp.diagnostics".virtual_lines or false,
    }
  )
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

function M:on_attach()
  return function(client, bufnr)
    local treesitter_active = require "vim.treesitter.highlighter".active[bufnr]

    local toggle_state = {
      formatting = M.supports_format(client),
      diagnostic_virtual_text = false,
      diagnostic_virtual_lines = false,
    }

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    ---@format disable
    local keymaps = {
      {
        mode = "n",
        keybinding = "<leader>cd",
        action = function()
          local config = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "line",
            format = function(d)
              local code = d.code or (d.user_data and d.user_data.lsp.code)
              if code then
                return string.format("%s [%s]", d.message, code):gsub("1. ", "")
              end
              return d.message
            end,
          }
          vim.diagnostic.open_float(0, config)
        end,
        desc = "Line Diagnostics"
      },
      { keybinding = "<leader>cl", action = "<cmd>LspInfo<cr>", desc = "Lsp Info" },
      client.supports_method "textDocument/codeLens" and { keybinding = "cr", action = function() vim.lsp.codelens.run() end, desc = "Run" } or {},
      client.supports_method "textDocument/definition" and { keybinding = "gd", action = "<cmd>Glance definitions<cr>", desc = "Goto Definition" } or {},
      { keybinding = "gr", action = "<cmd>Glance references<cr>", desc = "References" },
      { keybinding = "gD", action = vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { keybinding = "gI", action = "<cmd>Glance implementations<cr>", desc = "Goto Implementation" },
      { keybinding = "gy", action = "<cmd>Glance type_definitions<cr>", desc = "Goto T[y]pe Definition" },
      { keybinding = "K", action = function()
          if treesitter_active then
            local winid = require "ufo".peekFoldedLinesUnderCursor()
            if not winid then
              vim.lsp.buf.hover()
            end
          else
            vim.lsp.buf.hover()
          end
        end,desc = "Hover" },

      client.supports_method("textDocument/signatureHelp") and { keybinding = "gK", action = vim.lsp.buf.signature_help, desc = "Signature Help" } or {},
      client.supports_method("textDocument/signatureHelp") and { keybinding = "<c-k>", mode = "i", action = vim.lsp.buf.signature_help, desc = "Signature Help" } or {},

      { keybinding = "]d", action = M.diagnostic_goto(true), desc = "Next Diagnostic" },
      { keybinding = "[d", action = M.diagnostic_goto(false), desc = "Prev Diagnostic" },
      { keybinding = "]e", action = M.diagnostic_goto(true, "ERROR"), desc = "Next Error" },
      { keybinding = "[e", action = M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
      { keybinding = "]w", action = M.diagnostic_goto(true, "WARN"), desc = "Next Warning" },
      { keybinding = "[w", action = M.diagnostic_goto(false, "WARN"), desc = "Prev Warning" },

      M.supports_format(client) and {
        keybinding = "<leader>cf",
        action = function()
          if vim.b.autoformat == false then
            return false
          end

          vim.lsp.buf.format({ timeout_ms = 2000 })
        end,
        desc = "Format"
      } or {},

      M.supports_format(client) and client.supports_method("textDocument/rangeFormatting") and { keybinding = "<leader>cf", mode = "v", action = "", desc = "Format Range" } or {},

      client.supports_method("textDocument/codeAction") and { keybinding = "<leader>ca", action = vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } } or {},
      client.supports_method("textDocument/codeAction") and {
        keybinding = "<leader>cA",
        action = function()
          vim.lsp.buf.code_action({
            context = {
              only = {
                "source",
              },
              diagnostics = {},
            },
          })
        end,
        desc = "Source Action",
        has = "codeAction",
      } or {},

      { keybinding = "<leader>wl", action = function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "List Folders" },
      { keybinding = "<leader>wa", action = function() vim.lsp.buf.add_workspace_folder() end, desc = "Add Folder" },
      { keybinding = "<leader>wr", action = function() vim.lsp.buf.remove_workspace_folder() end, desc = "Remove Folder" },

      treesitter_active and { keybinding = "zR", action = require "ufo".openAllFolds, desc = "Open Folds" } or {},
      treesitter_active and { keybinding = "zM", action = require "ufo".closeAllFolds, desc = "Close Folds" } or {},
      treesitter_active and { keybinding = "zr", action = require "ufo".openFoldsExceptKinds, desc = "Open Folds (Except Kinds)" } or {},
      treesitter_active and { keybinding = "zm", action = require "ufo".closeFoldsWith, desc = "Close Folds (Except Kinds)" } or {},

      M.supports_format(client) and { keybinding = "<leader>uf", action = function() M.toggle_format(toggle_state) end, desc = "Toggle format on Save" } or {},

      {
        keybinding = "<leader>uv",
        action = function()
          M.toggle_diagnostic_virtual_text(bufnr, toggle_state)
        end,
        desc = "Toggle Diagnostics (Virtual Text)"
      },

      {
        keybinding = "<leader>uV",
        action = function()
          M.toggle_diagnostic_virtual_lines(bufnr, toggle_state)
        end,
        desc = "Toggle Diagnostics (Virtual Lines)"
      },
    }

    -- Enable inlay hints if supported
    local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

    if inlay_hint and client.supports_method "textDocument/inlayHint" then
      inlay_hint(bufnr, true)
    end

    -- Merge language-specific mappings with defaults
    local keymaps_merged = vim.tbl_deep_extend("force", keymaps or {}, self.custom_keymaps or {})

    -- Load custom keymaps
    for _, keymap in pairs(keymaps_merged) do
      if keymap.keybinding ~= nil then
        vim.keymap.set(
          keymap.mode or "n",
          keymap.keybinding,
          keymap.action,
          { noremap = true, silent = true, desc = keymap.desc or "", buffer = bufnr }
        )
      end
    end

    -- Set some keybinds conditional on server capabilities
    if M.supports_format(client) then
      local format_opts = { timeout_ms = 2000 }

      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          if toggle_state.formatting then
            vim.lsp.buf.format(format_opts)
          end
        end,
      })
    end

    -- Load custom commands
    for _, v in pairs(self.lang_commands) do
      vim.validate {
        ["command.name"] = { v.name, "s" },
        ["command.fn"] = { v.command, "f" },
      }

      vim.api.nvim_buf_create_user_command(bufnr, v.name, v.command, v.opts)
    end

    --if client.server_capabilities.documentDiagnosticProvider then
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = "rounded",
          source = "always",
          prefix = " ",
          scope = "cursor",
        }
        vim.diagnostic.open_float(nil, opts)
      end,
    })

    if client.supports_method "textDocument/documentHighlight" then
      vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
      vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = "lsp_document_highlight",
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = "lsp_document_highlight",
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client.supports_method "textDocument/codeLens" then
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = bufnr,
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })
    end

  end
end

return M
