local M = {}

-- setmetatable(M, {
-- 	__call = function(cls, ...)
-- 		return cls.new(...)
-- 	end,
-- })

function M:init(config, keymaps)
	config = config or {}
	setmetatable(config, self)
	self.__index = self
	self.keymaps = keymaps or {}
	return config
end

function M.new(keymaps)
	local inst = {}
	setmetatable(inst, { __index = M })
	inst:init(nil, keymaps)
	return inst
end

function M:on_attach()
	return function(client, bufnr)
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end

		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(bufnr, ...)
		end

		-- Mappings.
		local opts = { noremap = true, silent = true } -- Mappings.
		--
		-- Set some keybinds conditional on server capabilities
		if client.resolved_capabilities.document_formatting then
			vim.api.nvim_exec([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]], false)

			buf_set_keymap("n", "<leader>fr", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
			buf_set_keymap("n", "<C-k><C-d>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
		end

		if client.resolved_capabilities.document_range_formatting then
			buf_set_keymap("v", "<leader>fr", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
			buf_set_keymap("v", "<C-k><C-d>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
		end

		-- Enable completion triggered by <c-x><c-o>
		buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

		-- See `:help vim.lsp.*` for documentation on any of the below functions
		buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
		buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
		buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
		buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
		buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
		buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
		buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
		buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
		buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
		buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

		-- Load custom keymaps
		for _, keymap in ipairs(self.keymaps) do
			buf_set_keymap(keymap.mode, keymap.keybinding, keymap.action, opts)
		end
	end
end

return M
