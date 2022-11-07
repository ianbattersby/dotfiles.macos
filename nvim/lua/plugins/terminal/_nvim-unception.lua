local function config()
  vim.g.unception_enable_flavor_text = false
end

return {
  setup = function(use)
    use {
      "samjwill/nvim-unception",
      config = config,
    }
  end,
}
