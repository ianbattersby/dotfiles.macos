-- Inspiration from the great folke at:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/init.lua

local LazyUtil = require "lazy.core.util"

---@class util: UtilCore
---@field lsp util.lsp
---@field root util.root
local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("util." .. k)
    return t[k]
  end,
})

---@param plugin string
function M.has(plugin)
  return require "lazy.core.config".spec.plugins[plugin] ~= nil
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return LazyUtil.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      LazyUtil.info("Enabled " .. option, { title = "Option" })
    else
      LazyUtil.warn("Disabled " .. option, { title = "Option" })
    end
  end
end

local nu = { number = true, relativenumber = true }
function M.toggle_number()
  if vim.opt_local.number:get() or vim.opt_local.relativenumber:get() then
    nu = { number = vim.opt_local.number:get(), relativenumber = vim.opt_local.relativenumber:get() }
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    LazyUtil.warn("Disabled line numbers", { title = "Option" })
  else
    vim.opt_local.number = nu.number
    vim.opt_local.relativenumber = nu.relativenumber
    LazyUtil.info("Enabled line numbers", { title = "Option" })
  end
end

---@param name string
function M.opts(name)
  local plugin = require "lazy.core.config".plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require "lazy.core.plugin"
  return Plugin.values(plugin, "opts", false)
end

--- @param type "thin" | "thick" | "double" | "single" | "empty" | nil
--- @param order "t-r-b-l-tl-tr-br-bl" | "tl-t-tr-r-br-b-bl-l" | nil
--- @param opts BorderIcons | nil
M.generate_borderchars = function(type, order, opts)
  if order == nil then
    order = "t-r-b-l-tl-tr-br-bl"
  end
  local border_icons = require "config.options".icons.borders
  --- @type BorderIcons
  local border = vim.tbl_deep_extend("force", border_icons[type or "empty"], opts or {})

  local borderchars = {}

  local extractDirections = (function()
    local index = 1
    return function()
      if index == nil then
        return nil
      end
      -- Find the next occurence of `char`
      local nextIndex = string.find(order, "-", index)
      -- Extract the first direction
      local direction = string.sub(order, index, nextIndex and nextIndex - 1)
      -- Update the index to nextIndex
      index = nextIndex and nextIndex + 1 or nil
      return direction
    end
  end)()

  local mappings = {
    t = "top",
    r = "right",
    b = "bottom",
    l = "left",
    tl = "top_left",
    tr = "top_right",
    br = "bottom_right",
    bl = "bottom_left",
  }
  local direction = extractDirections()
  while direction do
    if mappings[direction] == nil then
      LazyUtil.error(string.format("Invalid direction '%s'", direction), "error")
    end
    borderchars[#borderchars + 1] = border[mappings[direction]]
    direction = extractDirections()
  end

  if #borderchars ~= 8 then
    LazyUtil.error(string.format("Invalid order '%s'", order), "error")
  end

  return borderchars
end

M.augroup = function(name)
  return vim.api.nvim_create_augroup("ib_" .. name, { clear = true })
end

return M
