local M = {}

local function attach_gitsigns(bufnr)
  local gs = package.loaded.gitsigns

  vim.keymap.set("n", "]g", function()
    if vim.wo.diff then
      return "]g"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, { expr = true, desc = "Next hunk" })

  vim.keymap.set("n", "[g", function()
    if vim.wo.diff then
      return "[g"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, { expr = true, desc = "Previous hunk" })

  vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk", buffer = bufnr })
  vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk", buffer = bufnr })
  vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer", buffer = bufnr })
  vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk", buffer = bufnr })
  vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer", buffer = bufnr })
  vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Previous hunk", buffer = bufnr })
  vim.keymap.set("n", "<leader>hb", function()
    gs.blame_line { full = true }
  end, { desc = "Blame line", buffer = bufnr })
  vim.keymap.set("n", "<leader>htb", gs.toggle_current_line_blame, { desc = "Toggle line blame", buffer = bufnr })
  vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "Diff file", buffer = bufnr })
  vim.keymap.set("n", "<leader>hD", function()
    gs.diffthis "~"
  end, { desc = "Diff directory", buffer = bufnr })
  vim.keymap.set("n", "<leader>htd", gs.toggle_deleted, { buffer = bufnr })
  vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk", buffer = bufnr })
end

function M:init(config, keymaps, commands)
  config = config or {}
  setmetatable(config, self)
  self.__index = self
  self.keymaps = keymaps or {}
  self.commands = commands or {}
  return config
end

function M.new(keymaps, commands)
  local inst = {}
  setmetatable(inst, { __index = M })
  inst:init(nil, keymaps, commands)
  return inst
end

function M:on_attach()
  return function(client, bufnr)
    local treesitter_active = require("vim.treesitter.highlighter").active[bufnr]

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set(
      "n",
      "<leader>qq",
      "<CMD>TroubleToggle document_diagnostics<CR>",
      { noremap = true, silent = true, desc = "Document", buffer = bufnr }
    )

    vim.keymap.set(
      "n",
      "<leader>qw",
      "<CMD>TroubleToggle workspace_diagnostics<CR>",
      { noremap = true, silent = true, desc = "Workspace", buffer = bufnr }
    )

    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { noremap = true, silent = true, desc = "List Folders", buffer = bufnr })

    vim.keymap.set("n", "<leader>wa", function()
      vim.lsp.buf.add_workspace_folder()
    end, { noremap = true, silent = true, desc = "Add Folder", buffer = bufnr })

    vim.keymap.set("n", "<leader>wr", function()
      vim.lsp.buf.remove_workspace_folder()
    end, { noremap = true, silent = true, desc = "Remove Folder", buffer = bufnr })

    vim.keymap.set(
      "n",
      "<leader>wd",
      "<CMD>TroubleToggle workspace_diagnostics<CR>",
      { noremap = true, silent = true, desc = "Diagnostics", buffer = bufnr }
    )

    vim.keymap.set("n", "<leader>ca", function()
      vim.lsp.buf.code_action()
    end, { noremap = true, silent = true, desc = "Actions", buffer = bufnr })

    vim.keymap.set(
      "n",
      "<leader>cd",
      "<CMD>Telescope lsp_range_code_actions<CR>",
      { noremap = true, silent = true, desc = "Actions (Range)", buffer = bufnr }
    )

    vim.keymap.set("n", "<leader>cl", function()
      vim.lsp.codelens.run()
    end, { noremap = true, silent = true, desc = "Lens", buffer = bufnr })

    vim.keymap.set("n", "<leader>crr", function()
      vim.lsp.buf.rename()
    end, { noremap = true, silent = true, desc = "Rename", buffer = bufnr })

    vim.keymap.set(
      "n",
      "gd",
      "<CMD>TroubleToggle lsp_definitions<CR>",
      { noremap = true, silent = true, desc = "Declaration", buffer = bufnr }
    )

    vim.keymap.set("n", "gD", function()
      vim.lsp.buf.declaration()
    end, { noremap = true, silent = true, desc = "Definition", buffer = bufnr })

    vim.keymap.set(
      "n",
      "gI",
      "<CMD>TroubleToggle lsp_implementations<CR>",
      { noremap = true, silent = true, desc = "Implementation", buffer = bufnr }
    )

    vim.keymap.set("n", "gl", function()
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
    end, { noremap = true, silent = true, desc = "Show Line Diagnostics", buffer = bufnr })

    vim.keymap.set(
      "n",
      "gr",
      require("telescope.builtin").lsp_references,
      { noremap = true, silent = true, desc = "References", buffer = bufnr }
    )

    vim.keymap.set(
      "n",
      "gs",
      vim.lsp.buf.signature_help,
      { noremap = true, silent = true, desc = "Signature", buffer = bufnr }
    )

    vim.keymap.set("n", "gS", function()
      if treesitter_active then
        require("telescope.builtin").treesitter(require("telescope.themes").get_ivy {})
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end, { noremap = true, silent = true, desc = "Symbols", buffer = bufnr })

    vim.keymap.set("n", "K", function()
      if treesitter_active then
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      else
        vim.lsp.buf.hover()
      end
    end, { noremap = true, silent = true, desc = "Hover", buffer = bufnr })

    vim.keymap.set("n", "]d", function()
      require("trouble").next { skip_groups = true, jump = true }
    end, { noremap = true, silent = true, desc = "Diagnostic Next", buffer = bufnr })

    vim.keymap.set("n", "[d", function()
      require("trouble").previous { skip_groups = true, jump = true }
    end, { noremap = true, silent = true, desc = "Diagnostic Prev", buffer = bufnr })

    if treesitter_active then -- we use treesitter to power the folds
      vim.keymap.set(
        "n",
        "zR",
        require("ufo").openAllFolds,
        { desc = "Open all folds", noremap = true, silent = true, buffer = bufnr }
      )
      vim.keymap.set(
        "n",
        "zM",
        require("ufo").closeAllFolds,
        { desc = "Close all folds", noremap = true, silent = true, buffer = bufnr }
      )
      vim.keymap.set(
        "n",
        "zr",
        require("ufo").openFoldsExceptKinds,
        { desc = "Open folds (except Kinds)", noremap = true, silent = true, buffer = bufnr }
      )
      vim.keymap.set(
        "n",
        "zm",
        require("ufo").closeFoldsWith,
        { desc = "Close folds with", noremap = true, silent = true, buffer = bufnr }
      )
    end

    -- Load custom keymaps
    for _, keymap in ipairs(self.keymaps) do
      vim.keymap.set(
        keymap.mode,
        keymap.keybinding,
        keymap.action,
        { noremap = true, silent = true, desc = keymap.desc, buffer = bufnr }
      )
    end

    -- Load custom commands
    for _, v in pairs(self.commands) do
      vim.validate {
        ["command.name"] = { v.name, "s" },
        ["command.fn"] = { v.command, "f" },
      }

      vim.api.nvim_buf_create_user_command(bufnr, v.name, v.command, v.opts)
    end

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
      local format_opts = { timeout_ms = 2000 }

      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format(format_opts)
        end,
      })

      vim.keymap.set("n", "<leader>cf", function()
        vim.lsp.buf.format(format_opts)
      end, { noremap = true, silent = true, desc = "Format Document", buffer = bufnr })

      vim.keymap.set("v", "<C-k><C-k>", function()
        vim.lsp.buf.format(
          vim.tbl_deep_extend("keep", format_opts, client.server_capabilities.documentRangeFormattingProvider and {
            range = {}, -- Defaults to block in VISUAL mode
          } or {})
        )
      end, { noremap = true, silent = true, desc = "Format Document", buffer = bufnr })
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
    --end

    if client.server_capabilities.documentHighlightProvider then
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

    if client.server_capabilities.codeLensProvider then
      vim.api.nvim_create_augroup("lsp_document_codelens", { clear = false })
      vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_codelens" }

      vim.api.nvim_create_autocmd("BufEnter", {
        group = "lsp_document_codelens",
        buffer = bufnr,
        callback = function()
          require("vim.lsp.codelens").refresh()
        end,
        once = true,
      })

      vim.api.nvim_create_autocmd({ "BufEnter, CursorHold" }, {
        group = "lsp_document_codelens",
        buffer = bufnr,
        callback = function()
          require("vim.lsp.codelens").refresh()
        end,
      })
    end

    -- Register lsp-status for updates
    require("lsp-status").on_attach(client)

    -- Register lsp-inlayhints for hints
    require("lsp-inlayhints").on_attach(client, bufnr)

    -- Register nvim-navic for updates
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end

    -- Attach git_signs
    attach_gitsigns(bufnr)
  end
end

return M
