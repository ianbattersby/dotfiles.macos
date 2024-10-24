local M = {}

M.init = function()
  local Util = require "util"

  -- Use C-Space to Esc out of any mode
  -- vim.keymap.set("n", "<C-Space>", "<Esc><CMD>noh<CR>", { noremap = true })
  -- vim.keymap.set("v", "<C-Space>", "<Esc>gV", { noremap = true })
  -- vim.keymap.set("o", "<C-Space>", "<Esc>", { noremap = true })
  -- vim.keymap.set("c", "<C-Space>", "<C-c>", { noremap = true })
  -- vim.keymap.set("i", "<C-Space>", "<Esc>", { noremap = true })

  -- Terminal sees <C-@> as <C-space>
  vim.keymap.set("n", "<C-@>", "<Esc><CMD>noh<CR>", { noremap = true })
  vim.keymap.set("v", "<C-@>", "<Esc>gV", { noremap = true })
  vim.keymap.set("o", "<C-@>", "<Esc>", { noremap = true })
  vim.keymap.set("c", "<C-@>", "<C-c>", { noremap = true })
  vim.keymap.set("i", "<C-@>", "<Esc>", { noremap = true })

  -- better up/down
  vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
  vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
  vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

  -- Move to window using the <ctrl> hjkl keys
  vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
  vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
  vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
  vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

  -- Resize window using <ctrl> arrow keys
  vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
  vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
  vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
  vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

  -- Move Lines
  vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
  vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
  vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
  vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
  vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
  vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

  -- Buffers
  vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
  vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
  vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })

  -- Tab to switch buffers in Normal mode
  vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { noremap = true, desc = "Next buffer" })
  vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { noremap = true, desc = "Prev buffer" })

  -- Clear search with <esc>
  vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

  -- Clear search, diff update and redraw
  -- taken from runtime/lua/_editor.lua
  vim.keymap.set(
    "n",
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / Clear hlsearch / Diff Update" }
  )

  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
  vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
  vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
  vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
  vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
  vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

  -- Add undo break-points
  vim.keymap.set("i", ",", ",<c-g>u")
  vim.keymap.set("i", ".", ".<c-g>u")
  vim.keymap.set("i", ";", ";<c-g>u")

  -- save file
  -- vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

  --keywordprg
  vim.keymap.set("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

  -- better indenting
  vim.keymap.set("v", "<", "<gv")
  vim.keymap.set("v", ">", ">gv")

  -- lazy
  vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

  -- new file
  vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

  vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
  vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
  vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
  vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })


  -- toggle options
  --vim.keymap.set("n", "<leader>uf", require "lazyvim.plugins.lsp.format".toggle, { desc = "Toggle format on Save" })
  vim.keymap.set("n", "<leader>us", function() Util.toggle "spell" end, { desc = "Toggle Spelling" })
  vim.keymap.set("n", "<leader>uw", function() Util.toggle "wrap" end, { desc = "Toggle Word Wrap" })
  vim.keymap.set("n", "<leader>ul", function() Util.toggle_number() end, { desc = "Toggle Line Numbers" })
  local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
  vim.keymap.set("n", "<leader>uc", function() Util.toggle("conceallevel", false, { 0, conceallevel }) end,
    { desc = "Toggle Conceal" })
  if vim.lsp.inlay_hint then
    vim.keymap.set("n", "<leader>uh", function() vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle Inlay Hints" })
  end
  vim.keymap.set("n", "<leader>uT",
    function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end,
    { desc = "Toggle Treesitter Highlight" })

  -- lazygit
  vim.keymap.set("n", "<leader>gg",
    function() Util.float_term({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false }) end,
    { desc = "Lazygit (root dir)" })
  vim.keymap.set("n", "<leader>gG", function() Util.float_term({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false }) end,
    { desc = "Lazygit (cwd)" })

  -- quit
  vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

  -- highlights under cursor
  if vim.fn.has "nvim-0.9.0" == 1 then
    vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
  end

  -- Terminal Mappings
  vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
  vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
  vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
  vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
  vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
  vim.keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
  vim.keymap.set("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

  -- windows
  vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
  vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
  vim.keymap.set("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
  vim.keymap.set("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
  vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
  vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

  -- tabs
  vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
  vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
  vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
  vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
  vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
  vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

  -- Quick sourcing of the current file allowing for config testing
  --vim.keymap.set("n", "<leader>sop", "<CMD>source %", { noremap = true })

  -- Quick save
  -- vim.keymap.set("n", "<leader>w", "<CMD>w", { noremap = true, desc = "Quick save" })

  -- Quick buffer switching
  -- vim.keymap.set(
  -- 	"n",
  -- 	"<Tab>",
  -- 	"<CMD>lua require'telescope.builtin'.buffers{ sort_lastused = true }<CR>",
  -- 	{ noremap = true }
  -- )


  -- Switch buffers with <shift> hl
  vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

  -- save in insert mode
  -- vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

  -- new file
  vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

  -- open lists
  vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open Location List" })
  vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })

  -- quit
  -- vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

  -- windows
  vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "other-window" })
  vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "delete-window" })
  vim.keymap.set("n", "<leader>w-", "<C-W>s", { desc = "split-window-below" })
  vim.keymap.set("n", "<leader>w|", "<C-W>v", { desc = "split-window-right" })

  -- tabs
  vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<CR>", { desc = "Last" })
  vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<CR>", { desc = "First" })
  vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "New Tab" })
  vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<CR>", { desc = "Next" })
  vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<CR>", { desc = "Close" })
  vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<CR>", { desc = "Previous" })

  -- buffers
  vim.keymap.set("n", "<leader>b]", "<cmd>:BufferLineCycleNext<CR>", { desc = "Next Buffer" })
  vim.keymap.set("n", "<leader>bb", "<cmd>:e #<cr>", { desc = "Switch to Other Buffer" })
  vim.keymap.set("n", "<leader>b[", "<cmd>:BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
  vim.keymap.set("n", "<leader>`", "<cmd>:e #<cr>", { desc = "Switch to Other Buffer" })

  -- Circumvent OS X hash issue
  vim.keymap.set("i", "<A-3>", "<C-v>035", { silent = true, noremap = false })

  -- Make Y yank to end of the line
  --vim.keymap.set("n", "Y", "y$")

  -- Make visual yanks place the cursor back where started
  vim.keymap.set("v", "y", "ygv<Esc>", { noremap = true })

  -- Move Lines
  vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move down" })
  vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move down" })
  vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move down" })
  vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move up" })
  vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move up" })
  vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move up" })

  -- windows
  vim.keymap.set(
    { "n", "i" },
    "<C-h>",
    "<CMD>wincmd h<CR>",
    { silent = true, noremap = true, desc = "Navigate Left" }
  )

  vim.keymap.set(
    { "n", "i" },
    "<C-j>",
    "<CMD>wincmd j<CR>",
    { silent = true, noremap = true, desc = "Navigate Down" }
  )

  vim.keymap.set({ "n", "i" }, "<C-k>", "<CMD>wincmd k<CR>", { silent = true, noremap = true, desc = "Navigate Up" })

  vim.keymap.set(
    { "n", "i" },
    "<C-l>",
    "<CMD>wincmd l<CR>",
    { silent = true, noremap = true, desc = "Navigate Right" }
  )
  vim.keymap.set(
    { "n", "i" },
    "<C-\\>",
    "<CMD>wincmd p<CR>",
    { silent = true, noremap = true, desc = "Navigate Previous" }
  )

  vim.keymap.set(
    { "n", "i" },
    "<C-W><C-W>",
    "<CMD>wincmd W<CR>",
    { silent = true, noremap = true, desc = "Switch backward" }
  )

  -- Resize window using <ctrl> arrow keys
  vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
  vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
  vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
  vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })
end

return M
