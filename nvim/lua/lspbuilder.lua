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
    -- Mappings.
    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      vim.api.nvim_exec([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]], false)

      require("which-key").register({
        c = {
          f = {
            ":lua vim.lsp.buf."
              .. (client.resolved_capabilities.document_range_formatting and "range_" or "")
              .. "formatting()<CR>",
            "Format Document",
          },
        },
      }, { prefix = "<leader>", buffer = bufnr })
    end

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    require("which-key").register({
      g = {
        name = "Goto",
        d = { ":lua vim.lsp.buf.declaration()<CR>", "Declaration" },
        D = { ":TroubleToggle lsp_definitions<CR>", "Definition" },
        i = { ":TroubleToggle lsp_implementations<CR>", "Implementation" },
        r = { ":Telescope lsp_references<CR>", "References" },
        s = {
          ":Telescope "
            .. (require("vim.treesitter.highlighter").active[bufnr] and "treesitter" or "lsp_document_symbols")
            .. "<CR>",
          "Symbols",
        },
      },
      D = { ":TroubleToggle lsp_type_definitions<CR>", "Type Definition" },
      K = { ":lua vim.lsp.buf.hover()<CR>", "Hover" },
      q = { ":TroubleToggle document_diagnostics<CR>", "Diagnotics" },
      w = {
        name = "Workspace",
        l = { ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Folders" },
        a = { ":lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Folder" },
        r = { ":lua vim.l;sp.buf.remove_workspace_folder()<CR>", "Remove Folder" },
        d = { ":TroubleToggle workspace_diagnostics<CR>", "Diagnotics" },
      },
      r = {
        name = "Refactor",
        r = { ":lua vim.lsp.buf.rename()<CR>", "Rename" },
      },
      c = {
        name = "Code",
        a = { ":Telescope lsp_code_actions<CR>", "Action (Cursor)" },
        d = { ":Telescope lsp_range_code_actions<CR>", "Action (Document)" },
      },
    }, { prefix = "<leader>", buffer = bufnr })

    require("which-key").register({
      ["C-k"] = { ":lua vim.lsp.buf.signature_help()<CR>", "Signature" },
      ["]d"] = { ':lua require("trouble").next({skip_groups = true, jump = true})<CR>', "Diagnostic Next" },
      ["[d"] = { ':lua require("trouble").previous({skip_groups = true, jump = true})<CR>', "Diagnostic Previous" },
    }, { buffer = bufnr })

    -- Load custom keymaps
    --print(require("utils").tprint(self.keymaps))
    for _, keymap in ipairs(self.keymaps) do
      require("which-key").register(
        { [keymap.keybinding] = { keymap.action, keymap.desc } },
        { mode = keymap.mode, buffer = bufnr }
      )
    end

    -- Register lsp-status for updates
    require("lsp-status").on_attach(client)

    -- Register lsp_signature for signature help
    require("lsp_signature").on_attach({
      bind = true,
      doc_lines = 0,
      floating_window = true,
      fix_pos = true,
      hint_enable = true,
      hint_prefix = " ",
      hint_scheme = "String",
      hi_parameter = "Search",
      max_height = 22,
      max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
      handler_opts = {
        border = "rounded", -- double, rounded, single, shadow, none
      },
      zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
      padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
    }, bufnr)
  end
end

return M
