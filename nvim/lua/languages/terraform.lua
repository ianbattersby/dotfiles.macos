local function initialize()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "hcl", "terraform" },
    desc = "terraform/hcl commentstring configuration",
    command = "setlocal commentstring=#\\ %s",
  })
end

return { server = "terraformls", config = {}, initialize = initialize }
