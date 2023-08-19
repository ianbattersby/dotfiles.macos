local M = {
  "mfussenegger/nvim-dap",
  branch = "master",

  ---@format disable
  keys = {
    {
      "<leader>dB",
      function() require "dap".set_breakpoint(vim.fn.input "Breakpoint condition: ") end,
      desc = "Breakpoint Condition"
    },
    { "<leader>db", function() require "dap".toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require "dap".continue() end, desc = "Continue" },
    { "<leader>dC", function() require "dap".run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require "dap".goto_() end, desc = "Go to line (no execute)" },
    { "<leader>di", function() require "dap".step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require "dap".down() end, desc = "Down" },
    { "<leader>dk", function() require "dap".up() end, desc = "Up" },
    { "<leader>dl", function() require "dap".run_last() end, desc = "Run Last" },
    { "<leader>do", function() require "dap".step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require "dap".step_over() end, desc = "Step Over" },
    { "<leader>dp", function() require "dap".pause() end, desc = "Pause" },
    { "<leader>dr", function() require "dap".repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require "dap".session() end, desc = "Session" },
    { "<leader>dt", function() require "dap".terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require "dap.ui.widgets".hover() end, desc = "Widgets" },
  },

  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      ---@format disable
      keys = {
        { "<leader>du", function() require "dapui".toggle({}) end, desc = "Dap UI" },
        { "<leader>de", function() require "dapui".eval() end, desc = "Eval", mode = { "n", "v" } },
      },
      opts = {},
      config = function(_, opts)
        local dap = require "dap"
        local dapui = require "dapui"
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },
    "theHamsta/nvim-dap-virtual-text",
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
    "jbyuki/one-small-step-for-vimkind",
    "ianbattersby/telescope.nvim",
    "nvim-telescope/telescope-dap.nvim",
  },
}

function M.config()
  local dap = require "dap"
  local dapui = require "dapui"
  local dapgo = require "dap-go"
  local dappython = require "dap-python"

  local sign = vim.fn.sign_define

  sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
  sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

  dapui.setup {
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
    },
    layouts = {
      {
        elements = {
          -- Elements can be strings or table with id and size keys.
          { id = "scopes", size = 0.25 },
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 40, -- 40 columns
        position = "left",
      },
      {
        elements = {
          "repl",
          "console",
        },
        size = 0.25, -- 25% of total lines
        position = "bottom",
      },
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil,  -- Floats will be treated as percentage of your screen.
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
  }

  -- Automatically open UI
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  -- Key mapping

  -- You can set trigger characters OR it will default to '.'
  -- You can also trigger with the omnifunc, <c-x><c-o>
  vim.api.nvim_create_augroup("DanRepl", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = "DanRepl",
    pattern = "dan-repl",
    callback = function()
      require "dap.ext.autocompl".attach()
    end,
  })

  -- Configure different adapters
  local mason_registry = require "mason-registry"

  -- Lua
  dap.adapters.nlua = function(callback, dapconfig)
    callback { type = "server", host = dapconfig.host or "127.0.0.1", port = dapconfig.port or 8088 }
  end

  -- LLDB (Rust/etc)
  dap.adapters.lldb = {
    type = "executable",
    command = mason_registry.get_package "codelldb":get_install_path() .. "/extension/adapter/codelldb",
    name = "lldb",
  }

  -- C# debugging
  dap.adapters.coreclr = {
    type = "executable",
    command = mason_registry.get_package "netcoredbg":get_install_path() .. "/netcoredbg",
    args = { "--interpreter=vscode" }
  }

  -- Requires: while sleep 1; do codelldb --port 13000; done
  -- dap.adapters.codelldb = {
  --   type = "server",
  --   host = "127.0.0.1",
  --   port = 13000,
  -- }

  -- Currently experimental, sourced manually from MS repository:
  -- https://github.com/microsoft/vscode-cpptools/releases/tag/1.7.1
  --
  -- Follow: https://github.com/Pocco81/DAPInstall.nvim/blob/master/lua/dap-install/core/debuggers/ccppr_vsc.lua#L49-L57
  -- dap.adapters.cpptools = {
  -- 	type = "executable",
  -- 	command = "/Users/ian/.local/cpptools-osx-arm64/extension/debugAdapters/bin/OpenDebugAD7",
  -- 	name = "cpptools",
  -- }

  -- Lua configuration using 'one-small-step-for-vimkind'
  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
      host = function()
        local value = vim.fn.input "Host [127.0.0.1]: "
        if value ~= "" then
          return value
        end
        return "127.0.0.1"
      end,
      port = function()
        local val = tonumber(vim.fn.input "Port: ")
        assert(val, "Please provide a port number")
        return val
      end,
    },
  }

  -- Configure CPP to use lldb
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

  -- C and Rust can use CPP configuration
  dap.configurations.c = dap.configurations.cpp
  -- dap.configurations.rust = dap.configurations.cpp

  -- Use this numpty-process version until we can figure out a better way
  -- dap.configurations.rust = {
  --   {
  --     name = "Rust debug",
  --     type = "rt_lldb",
  --     request = "launch",
  --     program = function()
  --       return vim.fn.input(
  --         "Path to executable: ",
  --         vim.fn.getcwd() .. "/target/debug/" .. string.match(vim.fn.getcwd(), "/([%w_-]+)$"),
  --         "file"
  --       )
  --     end,
  --     cwd = "${workspaceFolder}",
  --     terminal = "integrated",
  --     sourceLanguages = { "rust" },
  --   },
  -- }

  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end,
    },
  }

  -- Go configuration using 'dap-go' extension
  dapgo.setup()

  -- 'dap-python' extension expects:
  -- mkdir .virtualenvs
  -- cd .virtualenvs
  -- python -m venv debugpy
  -- debugpy/bin/python -m pip install debugpy
  dappython.setup "~/.virtualenvs/debugpy/bin/python"
  dappython.test_runner = "pytest"

  -- Javascript configuration is waiting on support for 'vscode-js-debug'
  -- in nvim-dap (as an extension) and for Apple arm64. Given I hate JS
  -- anyway, this shouldn't be any great shakes.
  --
  -- see: https://github.com/mfussenegger/nvim-dap/issues/82

  -- Enable virtual text
  require "nvim-dap-virtual-text".setup()

  -- Enable Telescope extension
  require "telescope".load_extension "dap"
end

return M
