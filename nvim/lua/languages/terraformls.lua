local settings = {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform", "tf", "hcl" },
  root_dir = require'lspconfig/util'.root_pattern(".terraform", ".git")
}

return {name = "terraform", config = { settings = settings}}
