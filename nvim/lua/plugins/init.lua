local function ensure_packer()
  local execute = vim.api.nvim_command
  local fn = vim.fn

  local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }
    execute "packadd packer.nvim"
  end
end

local function packer_setup()
  local packer = require "packer"

  packer.init {
    -- Specify a compile_path for packer_compiled to enable impatient to cache it
    --compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  }

  packer.startup {
    function(use)
      use "wbthomason/packer.nvim"
      use "lewis6991/impatient.nvim"

      use {
        "nathom/filetype.nvim",
        config = function()
          require("filetype").setup {
            overrides = {
              extensions = {
                tf = "terraform",
              },
            },
          }
        end,
      }

      -- Do not source the default filetype.vim
      vim.g.did_load_filetypes = 1

      -- Ensure we source packer_compiled from custom path
      --require("packer_compiled")

      require("plugins.appearance").setup(use)
      require("plugins.navigation").setup(use)
      require("plugins.editing").setup(use)
      require("plugins.lsp").setup(use)
      require("plugins.org").setup(use)
      require("plugins.terminal").setup(use)
    end,
    config = {
      display = {
        open_fn = require("packer.util").float,
      },
      profile = {
        enable = true,
        threshold = 1,
      },
    },
  }
end

local function setup()
  -- Ensure impatient.nvim is setup and profiling enabled
  local impatient = require "impatient"
  impatient.enable_profile()

  -- Autoload changes to plugin files
  vim.cmd([[
    augroup packer_user_config
      autocmd!
		  autocmd BufWritePost ]] .. string.format("%s/**", vim.fn.stdpath "config") .. [[  source <afile> | PackerCompile
    augroup end
  ]])

  -- Ensure packer is installed and load plugins
  ensure_packer()
  packer_setup()
end

return { setup = setup }
