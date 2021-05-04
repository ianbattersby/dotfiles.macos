local function config()
  require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;
    source = {
      path = true;
      buffer = true;
      calc = true;
      nvim_lsp = true;
      nvim_lua = true;
      vsnip = true;
    };
  }

  vim.cmd("set completeopt=menuone,noinsert,noselect,preview")
  vim.cmd("set shortmess+=c")
end


return {
  setup = function(use)
    use {
      'hrsh7th/nvim-compe',
      config = config
    }
  end
}
