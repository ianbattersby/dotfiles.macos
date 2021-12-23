local function config()
  local actions = require "telescope.actions"
  local trouble = require "trouble.providers.telescope"

  require("telescope").setup {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim",
      },
      layout_strategy = "flex",
      layout_config = {
        horizontal = {
          preview_width = 0.65,
          mirror = false,
        },
        vertical = {
          mirror = false,
        },
        prompt_position = "top",
      },
      file_sorter = require("telescope.sorters").get_fzy_sorter,
      prompt_prefix = " 🔍 ",
      color_devicons = true,

      sorting_strategy = "ascending",

      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

      file_ignore_patterns = { "node%_modules/.*" },

      mappings = {
        i = {
          ["<esc>"] = actions.close,
          --["<C-x>"] = false,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-b>"] = actions.results_scrolling_up,
          ["<C-f>"] = actions.results_scrolling_down,
          ["<C-q>"] = actions.send_to_qflist,
          ["<C-s>"] = actions.cycle_previewers_next,
          ["<C-a>"] = actions.cycle_previewers_prev,
          ["<c-t>"] = trouble.open_with_trouble,
          ["<C-h>"] = "which_key",
        },
        n = {
          ["<C-s>"] = actions.cycle_previewers_next,
          ["<C-a>"] = actions.cycle_previewers_prev,
          ["<c-t>"] = trouble.open_with_trouble,
          ["cd"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            require("telescope.actions").close(prompt_bufnr)
            vim.cmd(string.format("silent lcd %s", dir))
          end,
        },
      },
    },
    extensions = {
      fzf = {
        override_generic_sorter = false,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  }

  -- Load extensions
  require("telescope").load_extension "fzf"
  require("telescope").load_extension "dap"

  -- Key mapping
  vim.api.nvim_set_keymap("n", "<C-p>", "<CMD>lua require'telescope.builtin'.find_files({})<CR>", { noremap = true })

  vim.api.nvim_set_keymap(
    "n",
    "<leader>ff",
    "<CMD>lua require'telescope.builtin'.find_files({})<CR>",
    { noremap = true }
  )

  vim.api.nvim_set_keymap(
    "n",
    "<leader>fg",
    "<CMD>lua if not pcall(require'telescope.builtin'.git_files, { sort_last_used = true }) then require'telescope.builtin'.find_files({}) end<CR>",
    { noremap = true }
  )

  vim.api.nvim_set_keymap(
    "n",
    "<leader>fl",
    "<CMD>lua require'telescope.builtin'.find_files({ sort_last_used = true })<CR>",
    { noremap = true }
  )

  vim.api.nvim_set_keymap(
    "n",
    "<leader>fb",
    "<CMD>lua require'telescope.builtin'.buffers({ sort_last_used = true })<CR>",
    { noremap = true }
  )

  vim.api.nvim_set_keymap("n", "<C-s>", "<CMD>Telescope live_grep<CR>", { noremap = true })
end

return {
  setup = function(use)
    use {
      "nvim-telescope/telescope.nvim",
      config = config,
      after = { "trouble.nvim" },
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "nvim-telescope/telescope-dap.nvim" },
      },
    }
  end,
}
