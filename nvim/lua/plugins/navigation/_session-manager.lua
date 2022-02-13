local function config()
  require("session_manager").setup {
    sessions_dir = require("plenary.path"):new(vim.fn.stdpath "data", "sessions"), -- The directory where the session files will be saved.
    path_replacer = "__", -- The character to which the path separator will be replaced for session files.
    colon_replacer = "++", -- The character to which the colon symbol will be replaced for session files.
    autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
    autosave_last_session = true, -- Automatically save last session on exit and on session switch.
    autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
    autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
      "gitcommit",
    },
    autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
  }

  -- Key-mapping
  require("which-key").register({
    name = "Session",
    l = { ':lua require("session_manager").load_last_session()<CR>', "Last" },
    o = { ':lua require("session_manager").load_session()<CR>', "Load" },
    d = { ':lua require("session_manager").delete_session()<CR>', "Delete" },
    s = { ':lua require("session_manager").save_session()<CR>', "Save" },
    ["/"] = { ':lua require("session_manager").load_current_dir_session()<CR>', "Directory" },
    ["<leader>"] = { ':lua require("session_manager").load_last_session()<CR>', "Last" },
  }, { prefix = "<leader><leader>" })
end

return {
  setup = function(use)
    use {
      "Shatur/neovim-session-manager",
      requires = { "nvim-lua/plenary.nvim" },
      after = { "plenary.nvim", "which-key.nvim" },
      config = config,
    }
  end,
}
