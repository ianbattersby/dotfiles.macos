local function config()
  require("diffview").setup {}

  local last_tabpage = vim.api.nvim_get_current_tabpage()

  require("which-key").register({
    w = {
      name = "Workspace",
      v = {
        function()
          local lib = require "diffview.lib"
          local view = lib.get_current_view()
          if view then
            vim.api.nvim_set_current_tabpage(last_tabpage)
          else
            last_tabpage = vim.api.nvim_get_current_tabpage()
            if #lib.views > 0 then
              -- An open Diffview exists: go to that one.
              vim.api.nvim_set_current_tabpage(lib.views[1].tabpage)
            else
              -- No open Diffview exists: Open a new one
              vim.cmd ":DiffviewOpen"
            end
          end
        end,
        "Diff view",
      },
    },
  }, { prefix = "<leader>" })
end

return {
  setup = function(use)
    use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim", config = config, after = "focus.nvim" }
  end,
}
