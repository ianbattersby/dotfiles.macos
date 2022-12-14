local M = {
  "mfussenegger/nvim-dap",
  keys = {
    { "<F5>", function() require("dap").continue() end, mode = { "n", "i" }, desc = "Run/Continue" },
    { "<F10>", function() require("dap").step_over() end, mode = { "n", "i" }, desc = "Step Over" },
    { "<F11>", function() require("dap").step_into() end, mode = { "n", "i" }, desc = "Step Into" },
    { "<F12>", function() require("dap").step_out() end, mode = { "n", "i" }, desc = "Step Out" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>dsc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>dsv", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dsi", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dso", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dhh", function() require("dap.ui.widgets").hover() end, desc = "Hover" },
    { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Hover" },
    { "<leader>dro", function() require("dap").repl.open() end, desc = "Open" },
    { "<leader>drl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },

    { "<leader>dBc", function()
      vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
        require("dap").set_breakpoint(input)
      end)
    end, desc = "Toggle Breakpoint" },

    { "<leader>dBm", function()
      vim.ui.input({ prompt = "Log point message: " }, function(input)
        require("dap").set_breakpoint { nil, nil, input }
      end)
    end, desc = "Log Point Message" },

    {
      "<leader>dBt",
      require("dap").toggle_breakpoint,
      desc = "Toggle"
    },

    { "<leader>dv", function()
      local widgets = require "dap.ui.widgets"
      widgets.centered_float(widgets.scopes)
    end, desc = "Scoped Variables" },

    -- Evaluate expressions
    { "<leader>de", function() require("dapui").eval() end, mode = "v", desc = "Evaluate visual text" },

    { "<leader>dE", function()
      vim.ui.input({ prompt = "Expression > " }, function(input)
        require("dapui").eval(input)
      end)
    end, desc = "Evaluate expression" },
  },
  dependencies = {
    "rcarriga/nvim-dap-ui",
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

  sign("DapBreakpoint", { text = "???", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  sign("DapBreakpointCondition", { text = "???", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
  sign("DapLogPoint", { text = "???", texthl = "DapLogPoint", linehl = "", numhl = "" })

  dapui.setup {
    icons = { expanded = "???", collapsed = "???" },
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
      max_width = nil, -- Floats will be treated as percentage of your screen.
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
      require("dap.ext.autocompl").attach()
    end,
  })

  -- Configure different adapters
  dap.adapters.nlua = function(callback, dapconfig)
    callback { type = "server", host = dapconfig.host or "127.0.0.1", port = dapconfig.port or 8088 }
  end

  -- Downloaded from https://github.com/vadimcn/vscode-lldb/releases
  dap.adapters.lldb = {
    type = "executable",
    command = "/Users/ian/.local/codelldb-aarch64-darwin/extension/adapter/codelldb",
    name = "lldb",
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
  dap.configurations.rust = {
    {
      name = "Rust debug",
      type = "rt_lldb",
      request = "launch",
      program = function()
        return vim.fn.input(
          "Path to executable: ",
          vim.fn.getcwd() .. "/target/debug/" .. string.match(vim.fn.getcwd(), "/([%w_-]+)$"),
          "file"
        )
      end,
      cwd = "${workspaceFolder}",
      terminal = "integrated",
      sourceLanguages = { "rust" },
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
  require("nvim-dap-virtual-text").setup()

  -- Enable Telescope extension
  require("telescope").load_extension "dap"
end

return M
