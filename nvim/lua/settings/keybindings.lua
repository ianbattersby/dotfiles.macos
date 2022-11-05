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
    vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, desc = "Next tab" })
    vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, desc = "Previous tab" })

    -- Circumvent OS X hash issue
    vim.keymap.set("i", "<A-3>", "<C-v>035", { silent = true, noremap = false })

    -- Make Y yank to end of the line
    --vim.keymap.set("n", "Y", "y$")

    -- Make visual yanks place the cursor back where started
    vim.keymap.set("v", "y", "ygv<Esc>", { noremap = true })

    -- Shift + J/K moves selected lines down/up in visual mode
    -- vim.keymap.set("n", "<C-j>", "<cmd>m .+1<CR>==", { silent = true })
    -- vim.keymap.set("n", "<C-k>", "<cmd>m .-2<CR>==", { silent = true })
    -- vim.keymap.set("v", "<C-j>", ":m '>+1<CR>==gv=gv", { silent = true })
    -- vim.keymap.set("v", "<C-k>", ":m '<-2<CR>==gv=gv", { silent = true })

    --After searching, pressing escape stops the highlight
    --vim.keymap.set("n", "<esc>", ":noh<cr><esc>", { silent = true })

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
  end,
}
