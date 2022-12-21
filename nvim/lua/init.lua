local function ensure_lazy()
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
    }
  end
  vim.opt.runtimepath:prepend(lazypath)
end

local function setup_lazy()
  require("lazy").setup("plugins", {
    defaults = {
      lazy = false,
      version = "*",
    },
    dev = {
      path = "~/code",
      patterns = { "notyet" },
    },
    install = {
      missing = true,
      colorscheme = { "catpuccin" },
    },
  })
end

require("settings").setup()

ensure_lazy()
setup_lazy()
