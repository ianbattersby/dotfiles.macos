local function config()
  local actions    = require('telescope.actions')

  require('telescope').setup {
      defaults = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
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
          file_sorter      = require('telescope.sorters').get_fzy_sorter,
          prompt_prefix    = '🔍 ',
          color_devicons   = true,

          sorting_strategy = "ascending",

          file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
          grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
          qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

          mappings = {
              i = {
                  ["<esc>"] = actions.close,
                  ["<C-x>"] = false,
                  ["<C-j>"] = actions.move_selection_next,
                  ["<C-k>"] = actions.move_selection_previous,
                  ["<C-q>"] = actions.send_to_qflist,
                  ["<C-s>"] = actions.cycle_previewers_next,
                  ["<C-a>"] = actions.cycle_previewers_prev,
              },
              n = {
                  ["<C-s>"] = actions.cycle_previewers_next,
                  ["<C-a>"] = actions.cycle_previewers_prev,
              }
          }
      },
      extensions = {
          fzf = {
              override_generic_sorter = false,
              override_file_sorter = true,
              case_mode = "smart_case",
          }
      }
  }

  require('telescope').load_extension('fzf')

  vim.api.nvim_set_keymap("n", "<C-p>", "<CMD>lua if not pcall(require'telescope.builtin'.git_files, {}) then require'telescope.builtin'.find_files({}) end<CR>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-s>", "<CMD>Telescope live_grep<CR>", { noremap = true })
end

return {
  setup = function(use)
    use {'nvim-telescope/telescope.nvim',
      config = config,
      requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
      }
    }
  end
}
