local function config()
	local languages = require("languages")
	local lspconfig = require("lspconfig")
	local lspinstaller_servers = require("nvim-lsp-installer.servers")

	local on_attach = function(client, bufnr)
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end
		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(bufnr, ...)
		end

		-- Mappings.
		local opts = { noremap = true, silent = true } -- Mappings.

		-- Set some keybinds conditional on server capabilities
		if client.resolved_capabilities.document_formatting then
			vim.api.nvim_exec([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]], false)

			buf_set_keymap("n", "<space>fr", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
			buf_set_keymap("n", "<C-k><C-d>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
		end

		if client.resolved_capabilities.document_range_formatting then
			buf_set_keymap("v", "<space>fr", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
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
		buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
		buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
		buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
		buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
		buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
		buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
		buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
		buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
		buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
		buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	end

	local function make_config()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		require("cmp_nvim_lsp").update_capabilities(capabilities)

		return {
			root_dir = function(fname)
				return lspconfig.util.find_git_ancestor(fname) or require("utils").find_session_directory()
			end,
			capabilities = capabilities,
			on_attach = on_attach,
		}
	end

	local function setup_servers()
		local displayinfo = false

		for _, language_impl in pairs(vim.tbl_keys(languages)) do
			local language = languages[language_impl]

			if language then
				local configuration = make_config()
				configuration = vim.tbl_deep_extend("force", configuration, language.config)

				local server_available, requested_server = lspinstaller_servers.get_server(language.server)
				--print("LspInstaller server available for ", language.server, "? ", server_available)

				if server_available then
					--print("Using LspInstaller for: ", language.server)
					requested_server:on_ready(function()
						requested_server:setup(configuration)
					end)
					if not requested_server:is_installed() then
						--print("Installing Lsp server: ", language.server)
						requested_server:install()
						displayinfo = true
					end
				else
					--print("Manually configuring LSP config for: ", language.server)
					lspconfig[language.server].setup(configuration)
					--vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
				end
			end
		end

		if displayinfo == true then
			require("nvim-lsp-installer").info_window.open()
		end
	end

	setup_servers()

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = true,
		signs = true,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
	})
end

return {
	setup = function(use)
		use({
			"neovim/nvim-lspconfig",
			requires = { "williamboman/nvim-lsp-installer", "nvim-lua/lsp_extensions.nvim" },
			config = config,
		})
	end,
}
