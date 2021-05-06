local function config()
  local languages = require'languages'
  local lspconfig = require'lspconfig'
  local lspinstall = require'lspinstall'

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<space>fr", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      buf_set_keymap("n", "<C-k><C-d>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end
    if client.resolved_capabilities.document_range_formatting then
      buf_set_keymap("v", "<space>fr", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
      buf_set_keymap("v", "<C-k><C-d>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
  end

  function dump(o)
     if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
           if type(k) ~= 'number' then k = '"'..k..'"' end
           s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
     else
        return tostring(o)
     end
  end

  local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname)
        or require'utils'.find_session_directory()
      end,
      capabilities = capabilities,
      on_attach = on_attach
    }
  end

  local function install_missing_servers()
    local installed_servers = lspinstall.installed_servers()
    for _, server in pairs(vim.tbl_keys(languages)) do
      if not vim.tbl_contains(installed_servers, server) then
        if not lspinstall.install_server(server) then
          print([[Server ]] .. server .. [[ not available for installation.]])
        end
      end
    end
  end

  local function setup_servers()
    lspinstall.setup()
    local servers = lspinstall.installed_servers()
    for _, server in pairs(servers) do
      local configuration = make_config()
      if languages[server] then
        configuration = vim.tbl_deep_extend("force", configuration, languages[server].config)
      end
      lspconfig[server].setup(configuration)
    end
  end


  setup_servers()
  --install_missing_servers()

  -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
  lspinstall.post_install_hook = function ()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
  end

  vim.cmd[[inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"]]
  vim.cmd[[inoremap <expr> <S-Tab> pumvisible() ? "\<C-n>" : "\<S-Tab>"]]
end

return {
  setup = function(use)
    use {
      'neovim/nvim-lspconfig',
      requires = {'kabouzeid/nvim-lspinstall', 'nvim-lua/lsp_extensions.nvim'},
      config = config
    }
  end
}
