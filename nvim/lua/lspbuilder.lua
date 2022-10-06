local M = {}

-- setmetatable(M, {
-- 	__call = function(cls, ...)
-- 		return cls.new(...)
-- 	end,
-- })

function M:init(config, keymaps)
  config = config or {}
  setmetatable(config, self)
  self.__index = self
  self.keymaps = keymaps or {}
  return config
end

function M.new(keymaps)
  local inst = {}
  setmetatable(inst, { __index = M })
  inst:init(nil, keymaps)
  return inst
end

function M:on_attach()
  return function(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

    -- Mappings.
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v<cmd>lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v<cmd>lua.vim.lsp.formatexpr()")

    vim.bo.omnifunc = "v<cmd>lua.vim.lsp.omnifunc"

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

    vim.keymap.set(
      "n",
      "<leader>ca",
      "<CMD>Telescope lsp_code_actions<CR>",
      { noremap = true, silent = true, desc = "Actions", buffer = bufnr }
    )

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
      "<CMD>TroubleToggle lsp_definitions()<CR>",
      { noremap = true, silent = true, desc = "Declaration", buffer = bufnr }
    )

    vim.keymap.set("n", "gD", function()
      vim.lsp.buf.declaration()
    end, { noremap = true, silent = true, desc = "Definition", buffer = bufnr })

    vim.keymap.set(
      "n",
      "gI",
      "<CMD>TroubleToggle lsp_implementations()<CR>",
      { noremap = true, silent = true, desc = "Implementation", buffer = bufnr }
    )

    vim.keymap.set("n", "gl", function()
      local config = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
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
      if require("vim.treesitter.highlighter").active[bufnr] then
        require("telescope.builtin").treesitter(require("telescope.themes").get_ivy {})
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end, { noremap = true, silent = true, desc = "Symbols", buffer = bufnr })

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Hover", buffer = bufnr })

    vim.keymap.set("n", "]d", function()
      require("trouble").next { skip_groups = true, jump = true }
    end, { noremap = true, silent = true, desc = "Diagnostic Next", buffer = bufnr })

    vim.keymap.set("n", "[d]", function()
      require("trouble").previous { skip_groups = true, jump = true }
    end, { noremap = true, silent = true, desc = "Diagnostic Prev", buffer = bufnr })

    -- Load custom keymaps
    --print(require("utils").tprint(self.keymaps))
    for _, keymap in ipairs(self.keymaps) do
      vim.keymap.set(
        keymap.mode,
        keymap.keybinding,
        keymap.action,
        { noremap = true, silent = true, desc = keymap.desc, buffer = bufnr }
      )
    end

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.codeActionProvider then
      vim.api.nvim_exec([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]], false)

      vim.keymap.set(
        "n",
        "<leader>cf",
        "<cmd>lua vim.lsp.buf.format"
          .. (client.server_capabilities.documentRangeFormattingProvider and "expr" or "")
          .. "()<CR>",
        { noremap = true, silent = true, desc = "Format Document", buffer = bufnr }
      )
    end

    -- Set autocommands conditional on server_capabilities (thx teej)
    if client.server_capabilities.documentHighlightProvider then
      vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
    end

    if client.server_capabilities.codeLensProvider then
      vim.cmd [[
      augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufEnter ++once         <buffer> lua require"vim.lsp.codelens".refresh()
        autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
      augroup END
    ]]
    end

    -- Register lsp-status for updates
    require("lsp-status").on_attach(client)

    -- Register nvim-navic for updates
    if client.server_capabilities.documentSymbols then
      require("nvim-navic").attach(client, bufnr)
    end
  end
end

return M
