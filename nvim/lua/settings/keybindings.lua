return {
	setup = function()
		-- Use C-Space to Esc out of any mode
		vim.api.nvim_set_keymap("n", "<C-Space>", "<Esc><CMD>noh<CR>", { noremap = true })
		vim.api.nvim_set_keymap("v", "<C-Space>", "<Esc>gV", { noremap = true })
		vim.api.nvim_set_keymap("o", "<C-Space>", "<Esc>", { noremap = true })
		vim.api.nvim_set_keymap("c", "<C-Space>", "<C-c>", { noremap = true })
		vim.api.nvim_set_keymap("i", "<C-Space>", "<Esc>", { noremap = true })

		-- Terminal sees <C-@> as <C-space>
		vim.api.nvim_set_keymap("n", "<C-@>", "<Esc><CMD>noh<CR>", { noremap = true })
		vim.api.nvim_set_keymap("v", "<C-@>", "<Esc>gV", { noremap = true })
		vim.api.nvim_set_keymap("o", "<C-@>", "<Esc>", { noremap = true })
		vim.api.nvim_set_keymap("c", "<C-@>", "<C-c>", { noremap = true })
		vim.api.nvim_set_keymap("i", "<C-@>", "<Esc>", { noremap = true })

		-- Quick sourcing of the current file allowing for config testing
		vim.api.nvim_set_keymap("n", "<leader>sop", "<CMD>source %", { noremap = true })

		-- Quick save
		vim.api.nvim_set_keymap("n", "<leader>w", "<CMD>w", { noremap = true })

		-- Quick buffer switching
		-- vim.api.nvim_set_keymap(
		-- 	"n",
		-- 	"<Tab>",
		-- 	"<CMD>lua require'telescope.builtin'.buffers{ sort_lastused = true }<CR>",
		-- 	{ noremap = true }
		-- )

		-- Tab to switch buffers in Normal mode
		vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<CR>", { noremap = true })
		vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprevious<CR>", { noremap = true })

		-- Circumvent OS X hash issue
		vim.api.nvim_set_keymap("i", "<A-3>", "<C-v>035", { silent = true, noremap = false })

		-- Make Y yank to end of the line
		--vim.api.nvim_set_keymap("n", "Y", "y$")

		-- Make visual yanks place the cursor back where started
		vim.api.nvim_set_keymap("v", "y", "ygv<Esc>", { noremap = true })

		-- Shift + J/K moves selected lines down/up in visual mode
		vim.api.nvim_set_keymap("n", "<c-j>", "<cmd>m .+1<CR>==", { silent = true })
		vim.api.nvim_set_keymap("n", "<c-k>", "<cmd>m .-2<CR>==", { silent = true })
		vim.api.nvim_set_keymap("v", "<c-j>", ":m '>+1<CR>==gv=gv", { silent = true })
		vim.api.nvim_set_keymap("v", "<c-k>", ":m '<-2<CR>==gv=gv", { silent = true })

		--After searching, pressing escape stops the highlight
		--vim.api.nvim_set_keymap("n", "<esc>", ":noh<cr><esc>", { silent = true })
	end,
}
