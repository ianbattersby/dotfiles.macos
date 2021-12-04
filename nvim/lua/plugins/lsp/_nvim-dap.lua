local function config()
	local dap = require("dap")
	local dapui = require("dapui")
	local dapgo = require("dap-go")

	dap.adapters.lldb = {
		type = "executable",
		command = "/usr/bin/lldb-vscode", -- adjust as needed
		name = "lldb",
	}

	dap.configurations.cpp = {
		{
			name = "Launch",
			type = "lldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},

			-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
			--
			--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
			--
			-- Otherwise you might get the following error:
			--
			--    Error on launch: Failed to attach to the target process
			--
			-- But you should be aware of the implications:
			-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
			runInTerminal = false,
		},
	}

	dap.configurations.c = dap.configurations.cpp
	dap.configurations.rust = dap.configurations.cpp

	vim.api.nvim_set_keymap(
		"n",
		"<leader>b",
		"<CMD>lua require'dap'.toggle_breakpoint()<CR>",
		{ silent = true, noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>B",
		"<CMD>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
		{ silent = true, noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>lp",
		"<CMD>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
		{ silent = true, noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>dr",
		"<CMD>lua require'dap'.repl.open()<CR>",
		{ silent = true, noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>dl",
		"<CMD>lua require'dap'.run_last()<CR>",
		{ silent = true, noremap = true }
	)

	dapgo.setup()

	vim.api.nvim_set_keymap(
		"n",
		"<leader>y",
		"<CMD>lua require'dap-go'.debug_test()<CR>",
		{ silent = true, noremap = true }
	)

	dapui.setup({
		icons = { expanded = "▾", collapsed = "▸" },
		mappings = {
			-- Use a table to apply multiple mappings
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
		},
		sidebar = {
			--open_on_start = false,
			-- You can change the order of elements in the sidebar
			elements = {
				-- Provide as ID strings or tables with "id" and "size" keys
				{
					id = "scopes",
					size = 0.25, -- Can be float or integer > 1
				},
				{ id = "breakpoints", size = 0.25 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 00.25 },
			},
			size = 40,
			position = "left", -- Can be "left", "right", "top", "bottom"
		},
		tray = {
			--open_on_start = true,
			elements = { "repl" },
			size = 10,
			position = "bottom", -- Can be "left", "right", "top", "bottom"
		},
		floating = {
			max_height = nil, -- These can be integers or a float between 0 and 1.
			max_width = nil, -- Floats will be treated as percentage of your screen.
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		windows = { indent = 1 },
	})
end

return {
	setup = function(use)
		use({
			"mfussenegger/nvim-dap",
			requires = { { "rcarriga/nvim-dap-ui" }, { "leoluz/nvim-dap-go" } },
			config = config,
		})
	end,
}
