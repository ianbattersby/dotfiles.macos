local o_s = vim.o
local map_key = vim.api.nvim_set_keymap

local function opt(o, v, scopes)
  scopes = scopes or {o_s}
  for _, s in ipairs(scopes) do s[o] = v end
end

local function set_opts(kvs, scopes)
  for k, v in pairs(kvs) do
    opt(k, v, scopes)
  end
end

local function map(modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then modes = {modes} end
  for _, mode in ipairs(modes) do map_key(mode, lhs, rhs, opts) end
end

local function find_session_directory()
  local file = vim.v.argv[2]
  if file then
    return vim.fn.fnamemodify(file, ':p:h')
  end
  return vim.fn.getcwd()
end

return {opts = set_opts, opt = opt, map = map, find_session_directory = find_session_directory}
