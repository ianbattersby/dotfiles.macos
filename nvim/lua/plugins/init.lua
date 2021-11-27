local function ensure_packer()
  local execute = vim.api.nvim_command
  local fn = vim.fn

  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
  end
end

local function packer_setup()
  require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'
    use 'nathom/filetype.nvim'

    -- Do not source the default filetype.vim
    vim.g.did_load_filetypes = 1

    require'plugins.appearance'.setup(use)
    require'plugins.editing'.setup(use)
    require'plugins.lsp'.setup(use)
    require'plugins.navigation'.setup(use)
    require'plugins.terminal'.setup(use)
  end)
end

local function setup()
  ensure_packer()
  packer_setup()
end

return { setup = setup }
