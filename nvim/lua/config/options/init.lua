local M = {}

local defaults = {
  -- icons used by other plugins
  -- stylua: ignore
  icons = {
    misc = {
      dots = "󰇘",
    },
    dap = {
      Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint = " ",
      BreakpointCondition = " ",
      BreakpointRejected = { " ", "DiagnosticError" },
      LogPoint = ".>",
    },
    diagnostics = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " ",
    },
    git = {
      added = " ",
      modified = " ",
      removed = " ",
    },
    kinds = {
      Array = " ",
      Boolean = "󰨙 ",
      Class = " ",
      Codeium = "󰘦 ",
      Color = " ",
      Control = " ",
      Collapsed = " ",
      Constant = "󰏿 ",
      Constructor = " ",
      Copilot = " ",
      Enum = " ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = "󰊕 ",
      Interface = " ",
      Key = " ",
      Keyword = " ",
      Method = "󰊕 ",
      Module = " ",
      Namespace = "󰦮 ",
      Null = " ",
      Number = "󰎠 ",
      Object = " ",
      Operator = " ",
      Package = " ",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      String = " ",
      Struct = "󰆼 ",
      TabNine = "󰏚 ",
      Text = " ",
      TypeParameter = " ",
      Unit = " ",
      Value = " ",
      Variable = "󰀫 ",
    },
    borders = {
      --- @class BorderIcons
      single = {
        top = "─",
        right = "│",
        bottom = "─",
        left = "│",
        top_left = "╭",
        top_right = "╮",
        bottom_right = "╯",
        bottom_left = "╰",
      },
      double = {
        top = "═",
        right = "║",
        bottom = "═",
        left = "║",
        top_left = "╔",
        top_right = "╗",
        bottom_right = "╝",
        bottom_left = "╚",
      },
      --- @class BorderIcons
      thin = {
        top = "▔",
        right = "▕",
        bottom = "▁",
        left = "▏",
        top_left = "🭽",
        top_right = "🭾",
        bottom_right = "🭿",
        bottom_left = "🭼",
      },
      ---@type BorderIcons
      empty = {
        top = " ",
        right = " ",
        bottom = " ",
        left = " ",
        top_left = " ",
        top_right = " ",
        bottom_right = " ",
        bottom_left = " ",
      },
      ---@type BorderIcons
      thick = {
        top = "▄",
        right = "█",
        bottom = "▀",
        left = "█",
        top_left = "▄",
        top_right = "▄",
        bottom_right = "▀",
        bottom_left = "▀",
      },
    },
  },
  ---@type table<string, string[]|boolean>?
  kind_filter = {
    default = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Package",
      "Property",
      "Struct",
      "Trait",
    },
    markdown = false,
    help = false,
    -- you can specify a different filter for each filetype
    lua = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      -- "Package", -- remove package since luals uses it for control flow structures
      "Property",
      "Struct",
      "Trait",
    },
  },
}

---@param buf? number
---@return string[]?
function M.get_kind_filter(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local ft = vim.bo[buf].filetype
  if M.kind_filter == false then
    return
  end
  if M.kind_filter[ft] == false then
    return
  end
  ---@diagnostic disable-next-line: return-type-mismatch
  return type(M.kind_filter) == "table" and type(M.kind_filter.default) == "table" and M.kind_filter.default or nil
end

setmetatable(M, {
  __index = function(_, key)
    return defaults[key]
  end,
})

return M
