local function config()
  local dap = require "dap"
  local dapui = require "dapui"
  local dapgo = require "dap-go"
  local dappython = require "dap-python"

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
      position = "right", -- Can be "left", "right", "top", "bottom"
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
  -- Let's use whichkey to make our mappings more transparent.
  require("which-key").register({
    ["<F5>"] = { "<cmd>lua require('dap').continue()<CR>", "Run/Continue" },
    ["<F10>"] = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
    ["<F11>"] = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
    ["<F12>"] = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
  }, { prefix = "" })

  require("which-key").register({
    d = {
      name = "Debug",
      c = { "<cmd>lua require('dap').continue()<CR>", "Run/Continue" },
      s = {
        name = "Step",
        c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
        v = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
        i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
        o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
      },
      e = { "<cmd>lua require('dapui').eval()<CR>", "Evaluate", mode = "i" },
      E = { "<cmd>lua require('dapui').eval(vim.fn.input 'Expression expression: ')<CR>", "Evaluate Expression" },
      h = {
        name = "Hover",
        --h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", "Hover" },
        h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Hover" },
        v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "Visual Hover" },
      },
      u = {
        name = "UI",
        h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Hover" },
        f = { "local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", "Float" },
      },
      r = {
        name = "Repl",
        o = { "<cmd>lua require('dap').repl.open()<CR>", "Open" },
        l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run Last" },
      },
      b = {
        "<cmd>lua require('dap').toggle_breakpoint()<CR>",
        "Create Breakpoint",
      },
      B = {
        name = "Breakpoints",
        c = {
          "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
          "Breakpoint Condition",
        },
        m = {
          "<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>",
          "Log Point Message",
        },
        t = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Create" },
      },
      v = { "<cmd>lua require('dap').scopes()<CR>", "Variable Scopes" },
      --i = { "<cmd>lua require('dap').toggle()<CR>", "Toggle Debug" },
    },
  }, { prefix = "<leader>" })

  -- You can set trigger characters OR it will default to '.'
  -- You can also trigger with the omnifunc, <c-x><c-o>
  vim.cmd [[
augroup DanRepl
au!
au FileType dan-repl lua require('dap.ext.autocompl').attach()
augroup END
]]

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
  dap.adapters.codelldb = {
    type = "server",
    host = "127.0.0.1",
    port = 13000,
  }

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

  -- Python configuration using 'dap-python' extension
  dappython.setup "~/.virtualenvs/debugpy/bin/python"
  dappython.test_runner = "pytest"

  -- Javascript configuration is waiting on support for 'vscode-js-debug'
  -- in nvim-dap (as an extension) and for Apple arm64. Given I hate JS
  -- anyway, this shouldn't be any great shakes.
  --
  -- see: https://github.com/mfussenegger/nvim-dap/issues/82

  -- Enable virtual text
  require("nvim-dap-virtual-text").setup()
end

return {
  setup = function(use)
    use {
      "mfussenegger/nvim-dap",
      requires = {
        { "rcarriga/nvim-dap-ui" },
        { "theHamsta/nvim-dap-virtual-text" },
        { "leoluz/nvim-dap-go" },
        { "mfussenegger/nvim-dap-python" },
        { "jbyuki/one-small-step-for-vimkind" },
      },
      after = "which-key.nvim",
      config = config,
    }
  end,
}
