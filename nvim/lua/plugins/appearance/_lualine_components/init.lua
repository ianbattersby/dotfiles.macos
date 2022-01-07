local oldreq = require
local require = function(s)
  return oldreq("plugins.appearance._lualine_components." .. s)
end

return {
  progress_or_filename = require "progress-or-filename",
  diagnostics = require "diagnostics",
}
