local M = {
  "ianbattersby/telescope.nvim",
  branch = "add-ivy-padding",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "natecraddock/telescope-zf-native.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
  keys = {
    -- { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<CR>", desc = "Switch Buffer" },
    -- { "<leader>/", require "telescope.builtin".live_grep,              desc = "Grep (root dir)" },
    { "<leader>:", "<cmd>Telescope command_history<CR>", desc = "Command History" },
    { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Grep (root dir)" },
    {
      "<leader><space>",
      require "telescope.builtin".find_files,
      desc =
      "Find Files (root dir)"
    },
    -- find
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    {
      "<leader>ff",
      require "telescope.builtin".find_files,
      desc =
      "Find Files (root dir)"
    },
    {
      "<leader>fF",
      function()
        require "telescope.builtin".find_files { cwd = false }
      end,
      desc = "Find Files (cwd)"
    },
    { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent" },
    {
      "<leader>fR",
      function()
        require "telescope.builtin".oldfiles { cwd = vim.loop.cwd() }
      end,
      desc = "Recent (cwd)"
    },
    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
    -- search
    { '<leader>s"', "<cmd>Telescope registers<CR>", desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<CR>", desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<CR>", desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<CR>", desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "Document diagnostics" },
    {
      "<leader>sD",
      "<cmd>Telescope diagnostics<CR>",
      desc =
      "Workspace diagnostics"
    },
    {
      "<leader>sg",
      require "telescope.builtin".live_grep,
      desc = "Grep (root dir)"
    },
    {
      "<leader>sG",
      function() require "telescope.builtin".live_grep { cwd = false } end,
      desc = "Grep (cwd)"
    },
    { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "Help Pages" },
    {
      "<leader>sH",
      "<cmd>Telescope highlights<CR>",
      desc = "Search Highlight Groups"
    },
    { "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<CR>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<CR>", desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<CR>", desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<CR>", desc = "Resume" },
    {
      "<leader>sw",
      function()
        require "telescope.builtin".grep_string { word_match = "-w" }
      end,
      desc = "Word (root dir)"
    },
    {
      "<leader>sW",
      function()
        require "telescope.builtin"["grep_string"]({ cwd = false, word_match = "-w" })
      end,
      desc = "Word (cwd)"
    },
    {
      "<leader>sw",
      require "telescope.builtin".grep_string,
      mode = "v",
      desc = "Selection (root dir)"
    },
    {
      "<leader>sW",
      function()
        require "telescope.builtin".grep_string { cwd = false }
      end,
      mode = "v",
      desc = "Selection (cwd)"
    },
    {
      "<leader>uC",
      function()
        require "telescope.builtin".colorscheme { enable_preview = true }
      end,
      desc = "Colorscheme"
    },
    {
      "<leader>ss",
      function()
        require "telescope.builtin".lsp_document_symbols {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          }
        }
      end,
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      function()
        require "telescope.builtin".lsp_dynamic_workspace_symbols {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          }
        }
      end,
      desc = "Goto Symbol (Workspace)",
    },
    {
      "<C-x>",
      "<cmd>Telescope resume<CR>",
      desc = "Resume"
    },
    {
      "<C-p>",
      function() require "telescope.builtin".find_files { theme = "ivy" } end,
      noremap = true,
      silent = true,
      desc = "Find Files"
    },
    {
      "<C-s>",
      require "telescope.builtin".live_grep,
      desc = "Grep"
    },
  },
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
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
      winblend = 8,
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.95,
        height = 0.85,
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
      file_sorter = require "telescope.sorters".get_fzy_sorter,
      file_previewer = require "telescope.previewers".vim_buffer_cat.new,
      grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
      qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
      file_ignore_patterns = { "node%_modules/.*" },
      mappings = {
        i = {
          ["<esc>"] = function(...)
            return require "telescope.actions".close(...)
          end,
          ["<c-t>"] = function(...)
            return require "trouble.providers.telescope".open_with_trouble(...)
          end,
          ["<a-t>"] = function(...)
            return require "trouble.providers.telescope".open_selected_with_trouble(...)
          end,
          ["<a-i>"] = function()
            local action_state = require "telescope.actions.state"
            local line = action_state.get_current_line()
            require "telescope.builtin".find_files { no_ignore = true, default_text = line }
          end,
          ["<a-h>"] = function()
            local action_state = require "telescope.actions.state"
            local line = action_state.get_current_line()
            require "telescope.builtin".find_files { hidden = true, default_text = line }
          end,
          ["<C-Down>"] = function(...)
            return require "telescope.actions".cycle_history_next(...)
          end,
          ["<C-Up>"] = function(...)
            return require "telescope.actions".cycle_history_prev(...)
          end,
          ["<C-f>"] = function(...)
            return require "telescope.actions".results_scrolling_down(...)
          end,
          ["<C-b>"] = function(...)
            return require "telescope.actions".results_scrolling_up(...)
          end,
        },
        n = {
          ["q"] = function(...)
            return require "telescope.actions".close(...)
          end,
        },
      },
    },
    pickers = {
      find_files = { theme = "ivy", hidden = false, layout_config = { prompt_padding = 1 } },
      git_files = { theme = "ivy", hidden = false, sort_last_used = true, layout_config = { prompt_padding = 1 } },
      live_grep = { theme = "ivy", hidden = false, layout_config = { prompt_padding = 1 } },
      buffers = { theme = "ivy", hidden = false, sort_last_used = true, layout_config = { prompt_padding = 1 } },
      symbols = { theme = "ivy", hidden = false, layout_config = { prompt_padding = 1 } },
    },
    extensions = {
      ["ui-select"] = {
        require "telescope.themes".get_dropdown {},
      },
    },
  },
}

function M.config(_, opts)
  local telescope = require "telescope"

  -- Load extensions
  telescope.load_extension "zf-native"
  telescope.load_extension "file_browser"
  telescope.load_extension "notify"
  telescope.load_extension "ui-select"

  -- Initialise
  telescope.setup(opts)
end

return M
