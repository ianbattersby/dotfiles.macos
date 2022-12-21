local M = {
  "ianbattersby/telescope.nvim",
  branch = "add-ivy-padding",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "natecraddock/telescope-zf-native.nvim" },
    -- { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    { "nvim-telescope/telescope-frecency.nvim", dependencies = { "tami5/sqlite.lua" } },
    { "nvim-telescope/telescope-file-browser.nvim" },
    -- { "nvim-telescope/telescope-packer.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
}

function M.config()
  local telescope = require "telescope"
  local actions = require "telescope.actions"
  local trouble = require "trouble.providers.telescope"
  local dbpath = vim.fn.stdpath "data" .. "/databases/"

  telescope.setup {
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

      prompt_prefix = " ",
      selection_caret = " ",

      winblend = 8,

      layout_strategy = "horizontal",
      layout_config = {
        width = 0.95,
        height = 0.85,
        -- preview_cutoff = 120,
        prompt_position = "top",

        horizontal = {
          preview_width = function(_, cols, _)
            if cols > 200 then
              return math.floor(cols * 0.4)
            else
              return math.floor(cols * 0.6)
            end
          end,
        },

        vertical = {
          width = 0.9,
          height = 0.95,
          preview_height = 0.5,
        },

        flex = {
          horizontal = {
            preview_width = 0.9,
          },
        },
      },

      selection_strategy = "reset",
      sorting_strategy = "ascending",
      scroll_strategy = "cycle",
      color_devicons = true,

      file_sorter = require("telescope.sorters").get_fzy_sorter,
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
          ["<C-t>"] = trouble.open_with_trouble,
          ["<C-h>"] = "which_key",
        },
        n = {
          ["<C-s>"] = actions.cycle_previewers_next,
          ["<C-a>"] = actions.cycle_previewers_prev,
          ["<C-t>"] = trouble.open_with_trouble,
          ["cd"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            require("telescope.actions").close(prompt_bufnr)
            vim.cmd(string.format("silent lcd %s", dir))
          end,
        },
      },
    },

    pickers = {
      find_files = { theme = "ivy", hidden = false, layout_config = { prompt_padding = 1 } },
      git_files = { theme = "ivy", hidden = false, sort_last_used = true, layout_config = { prompt_padding = 1 } },
      live_grep = { theme = "ivy", hidden = false, layout_config = { prompt_padding = 1 } },
      buffers = { theme = "ivy", hidden = false, sort_last_used = true, layout_config = { prompt_padding = 1 } },
      frecency = { theme = "ivy", hidden = false, layout_config = { prompt_padding = 1 } }, -- This doesn't work, but why?
      symbols = { theme = "ivy", hidden = false, layout_config = { prompt_padding = 1 } },
    },

    extensions = {
      -- fzf = {
      --   override_generic_sorter = false,
      --   override_file_sorter = true,
      --   case_mode = "smart_case",
      -- },
      frecency = {
        db_root = dbpath,
        workspaces = {
          ["dot"] = "/home/ian/.dotfiles",
          ["conf"] = "/home/ian/.dotfiles/nvim",
          ["code"] = "/home/ian/code",
        },
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {},
      },
    },
  }

  -- Load extensions
  telescope.load_extension "zf-native"
  -- telescope.load_extension "fzf"
  -- telescope.load_extension "packer"
  telescope.load_extension "file_browser"
  telescope.load_extension "frecency"
  telescope.load_extension "notify"
  telescope.load_extension "ui-select"

  -- Let's use the get_ivy theme in places
  local findfiles_fn = require("telescope.builtin").find_files

  vim.keymap.set("n", "<C-x>", "<CMD>Telescope resume<CR>", { noremap = true, silent = true, desc = "Resume" })
  vim.keymap.set("n", "<C-p>", findfiles_fn, { noremap = true, silent = true, desc = "Find Files" })
  vim.keymap.set("n", "<leader>ff", findfiles_fn, { noremap = true, silent = true, desc = "Files (ascending)" })

  vim.keymap.set(
    "n",
    "<C-s>",
    require("telescope.builtin").live_grep,
    { noremap = true, silent = true, desc = "Search Files" }
  )

  vim.keymap.set("n", "<leader>fr", function()
    require("telescope.builtin").find_files { prompt_title = "Recent Files", sort_last_used = true }
  end, { noremap = true, silent = true, desc = "Files (recent)" })

  vim.keymap.set("n", "<leader>fx", function()
    require("telescope").extensions.frecency.frecency(
      require("telescope.themes").get_ivy { hidden = false, layout_config = { prompt_padding = 1 } }
    )
  end, { noremap = true, silent = true, desc = "Files (frecency)" })

  vim.keymap.set(
    "n",
    "<leader>fg",
    require("telescope.builtin").git_files,
    { noremap = true, silent = true, desc = "Files (git)" }
  )

  vim.keymap.set(
    "n",
    "<leader>fs",
    require("telescope.builtin").live_grep,
    { noremap = true, silent = true, desc = "Files (content)" }
  )

  vim.keymap.set(
    "n",
    "<leader>b",
    require("telescope.builtin").buffers,
    { noremap = true, silent = true, desc = "Buffers" }
  )

  vim.keymap.set(
    "n",
    "<leader>cs",
    require("telescope.builtin").treesitter,
    { noremap = true, silent = true, desc = "Symbols (search)" }
  )
end

return M
