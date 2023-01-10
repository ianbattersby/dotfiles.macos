return {
  setup = function()
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

    -- Quick sourcing of the current file allowing for config testing
    --vim.keymap.set("n", "<leader>sop", "<CMD>source %", { noremap = true })

    -- Quick save
    vim.keymap.set("n", "<leader>w", "<CMD>w", { noremap = true, desc = "Quick save" })

    -- Quick buffer switching
    -- vim.keymap.set(
    -- 	"n",
    -- 	"<Tab>",
    -- 	"<CMD>lua require'telescope.builtin'.buffers{ sort_lastused = true }<CR>",
    -- 	{ noremap = true }
    -- )

    -- Tab to switch buffers in Normal mode
    vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { noremap = true, desc = "Next buffer" })
    vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { noremap = true, desc = "Prev buffer" })

    -- Switch buffers with <shift> hl
    vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
    vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

    -- save in insert mode
    vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

    -- new file
    vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

    -- open lists
    vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open Location List" })
    vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })

    -- quit
    vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

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
  end,
}
