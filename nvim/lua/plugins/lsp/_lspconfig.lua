local function config()
	local languages = require("languages")
	local lspconfig = require("lspconfig")

	local lspinstaller_servers = require("nvim-lsp-installer.servers")

	local function make_config()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		require("cmp_nvim_lsp").update_capabilities(capabilities)

		return {
			root_dir = function(fname)
				return lspconfig.util.find_git_ancestor(fname) or require("utils").find_session_directory()
			end,
			capabilities = capabilities,
		}
	end

	local function setup_servers()
		local displayinfo = false

		for _, language_impl in pairs(vim.tbl_keys(languages)) do
			local language = languages[language_impl]

			if language then
				local configuration = vim.tbl_deep_extend("force", make_config(), language.config)

				if configuration.on_attach == nil then
					local lconfig = require("language").new()
					configuration.on_attach = lconfig:on_attach()
				end

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

				if language.finalize ~= nil then
					language.finalize()
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
