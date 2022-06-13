local function finalize()
  vim.cmd [[autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll]]
end

return { server = "eslint", config = {}, finalize = finalize }
