return {
  setup = function()
    require "settings.options" .setup()
    require "settings.keybindings" .setup()
    require "settings.autocmds" .setup()
  end,
}
