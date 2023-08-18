local config = {
  enable = true,
  format = { enable = true }, -- this will enable formatting
  packageManager = "npm",
  autoFixOnSave = true,
  codeActionsOnSave = {
    mode = "all",
    rules = { "!debugger", "!no-only-tests/*" },
  },
  lintTask = {
    enable = true,
  },
  workingDirectory = { mode = "auto" },
}

local function finalize()
  vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(event)
      -- exit early if autoformat is not enabled
      return
    end
  })
end

return { server = "eslint", config = config, finalize = finalize }
