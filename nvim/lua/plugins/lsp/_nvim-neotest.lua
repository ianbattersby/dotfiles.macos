local function config()
  require("neotest").setup {
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false },
      },
      require "neotest-plenary",
      require "neotest-rust" {
        args = { "--no-capture" },
      },
      require "neotest-go",
    },
  }

  vim.keymap.set("n", "<leader>cts", function()
    require("neotest").summary.toggle()
  end, { noremap = true, silent = true, desc = "Summary" })

  vim.keymap.set("n", "<leader>ctm", function()
    require("neotest").summary.run_marked()
  end, { noremap = true, silent = true, desc = "Run (marked)" })

  vim.keymap.set("n", "<leader>ctf", function()
    require("neotest").run.run(vim.fn.expand "%")
  end, { noremap = true, silent = true, desc = "Run (file)" })

  vim.keymap.set("n", "<leader>ctn", function()
    require("neotest").run.run()
  end, { noremap = true, silent = true, desc = "Run (nearest)" })

  vim.keymap.set("n", "<leader>ctl", function()
    require("neotest").run.run_last()
  end, { noremap = true, silent = true, desc = "Run (last)" })

  vim.keymap.set("n", "<leader>ctdn", function()
    require("neotest").run.run { strategy = "dap" }
  end, { noremap = true, silent = true, desc = "Nearest" })

  vim.keymap.set("n", "<leader>ctdl", function()
    require("neotest").run.run_last { strategy = "dap" }
  end, { noremap = true, silent = true, desc = "Last" })

  vim.keymap.set("n", "<leader>ctda", function()
    require("neotest").run.run_last { strategy = "dap" }
  end, { noremap = true, silent = true, desc = "Attach" })

  vim.keymap.set("n", "<leader>ctdf", function()
    require("neotest").run.run { vim.fn.expand "%", strategy = "dap" }
  end, { noremap = true, silent = true, desc = "File" })

  vim.keymap.set("n", "<leader>ctc", function()
    require("neotest").summary.clear_marked()
  end, { noremap = true, silent = true, desc = "Clear (marked)" })

  vim.keymap.set("n", "<leader>cto", function()
    require("neotest").output.open { enter = true }
  end, { noremap = true, silent = true, desc = "Output" })

  vim.keymap.set("n", "<leader>ctx", function()
    require("neotest").output.stop()
  end, { noremap = true, silent = true, desc = "Stop" })

  vim.keymap.set("n", "]n", function()
    require("neotest").jump.prev { status = "failed" }
  end, { noremap = true, silent = true, desc = "Failed Prev" })

  vim.keymap.set("n", "[n", function()
    require("neotest").jump.next { status = "failed" }
  end, { noremap = true, silent = true, desc = "Failed Next" })
end

return {
  setup = function(use)
    use {
      "nvim-neotest/neotest",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-plenary",
        "nvim-neotest/neotest-go",
        "rouge8/neotest-rust",
      },
      config = config,
    }
  end,
}
