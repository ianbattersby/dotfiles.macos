local function config()
	local cmp = require("cmp")
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")

	local kind_icons = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "",
		Variable = "",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
	}

	require("luasnip/loaders/from_vscode").lazy_load({
		paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets" },
		include = { "python", "rust" },
	})

	cmp.setup({
		formatting = {
			format = function(entry, vim_item)
				-- Kind icons
				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
				-- Source
				vim_item.menu = ({
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					latex_symbols = "[LaTeX]",
					neorg = "[Neorg]",
				})[entry.source.name]
				return vim_item
			end,
		},
		completion = {
			completeopt = "menu,menuone,noinsert",
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = {
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-y>"] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<CR>"] = cmp.mapping.confirm({ select = true }),

			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif require("luasnip").expand_or_jumpable() then
					require("luasnip").expand_or_jump()
				else
					local line, col = unpack(vim.api.nvim_win_get_cursor(0))

					if
						col ~= 0
						and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
					then
						cmp.complete()
					else
						--vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n")
						fallback()
					end
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif require("luasnip").jumpable(-1) then
					require("luasnip").jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "neorg" },
		}, {
			{ name = "buffer" },
		}),
	})

	-- Use buffer source for `/`.
	cmp.setup.cmdline("/", {
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':'.
	cmp.setup.cmdline(":", {
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})

	-- Wire-in nvim-autopairs
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

	vim.cmd([[set completeopt=menu,menuone,noselect]])
end

return {
	setup = function(use)
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				{ "hrsh7th/cmp-nvim-lsp", opt = false },
				{ "hrsh7th/cmp-buffer", opt = false },
				{ "hrsh7th/cmp-path", opt = false },
				{ "hrsh7th/cmp-cmdline", opt = false },
				{ "L3MON4D3/LuaSnip", opt = false },
				{ "saadparwaiz1/cmp_luasnip", opt = false },
				{ "rafamadriz/friendly-snippets" },
			},
			after = { "nvim-autopairs", "LuaSnip" },
			config = config,
		})
	end,
}
