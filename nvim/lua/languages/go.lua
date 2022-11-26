local config = {
  hints = {
    assignVariableTypes = true,
    compositeLiteralFields = true,
    constantValues = true,
    functionTypeParameters = true,
    parameterNames = true,
    rangeVariableTypes = true,
  },
}

return { server = "gopls", config = config }
