local M = {
  "nvim-neotest/neotest",
  keys = {
    { "<leader>es",  function() require "neotest" .summary.toggle() end,                                desc = "Summary" },
    { "<leader>em",  function() require "neotest" .summary.run_marked() end,                            desc = "Run (marked)" },
    { "<leader>ef",  function() require "neotest" .run.run(vim.fn.expand "%") end,                      desc = "Run (file)" },
    { "<leader>en",  function() require "neotest" .run.run() end,                                       desc = "Run (nearest)" },
    { "<leader>el",  function() require "neotest" .run.run_last() end,                                  desc = "Run (last)" },
    { "<leader>edn", function() require "neotest" .run.run { strategy = "dap" } end,                    desc = "Nearest" },
    { "<leader>edl", function() require "neotest" .run.run_last { strategy = "dap" } end,               desc = "Last" },
    { "<leader>eda", function() require "neotest" .run.run_last { strategy = "dap" } end,               desc = "Attach" },
    { "<leader>edf", function() require "neotest" .run.run { vim.fn.expand "%", strategy = "dap" } end, desc = "File" },
    { "<leader>ec",  function() require "neotest" .summary.clear_marked() end,                          desc = "Clear (marked)" },
    { "<leader>eo",  function() require "neotest" .output.open { enter = true } end,                    desc = "Output" },
    { "<leader>ex",  function() require "neotest" .output.stop() end,                                   desc = "Stop" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-go",
    "rouge8/neotest-rust",
  },
  event = "VeryLazy",
}

function M.config()
  require "neotest" .setup {
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


  vim.keymap.set("n", "]n", function()
    require "neotest" .jump.prev { status = "failed" }
  end, { noremap = true, silent = true, desc = "Failed Prev" })

  vim.keymap.set("n", "[n", function()
    require "neotest" .jump.next { status = "failed" }
  end, { noremap = true, silent = true, desc = "Failed Next" })
end

return M
