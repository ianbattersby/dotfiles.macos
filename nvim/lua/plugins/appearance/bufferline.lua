local function config()
  require'nvim-web-devicons'.setup{
    default = true
  }
  require('bufferline').setup{
    options = {
      separator_style = "slant",
      numbers = "buffer_id",
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, _, diagnostics_dict)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " "
            or (e == "warning" and " " or "" )
          s = s .. n .. sym
        end
        return s
      end
    }
  }
end

return {
  setup = function(use)
    use {
      'akinsho/nvim-bufferline.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = config
    }
  end
}
