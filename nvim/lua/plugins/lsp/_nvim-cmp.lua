local function tabnine_config()
  require("cmp_tabnine.config"):setup {
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
    ignored_file_types = { -- default is not to ignore
      -- uncomment to ignore in lua:
      -- lua = true
    },
  }
end

local function config()
  local cmp = require "cmp"
  local cmp_autopairs = require "nvim-autopairs.completion.cmp"

  local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
  }

  require("luasnip/loaders/from_vscode").lazy_load {
    paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets" },
    include = { "python", "rust" },
  }

  cmp.setup {
    formatting = {
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        -- Source
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[LaTeX]",
          neorg = "[Neorg]",
          path = "[Path]",
          cmp_tabnine = "[TN]",
        })[entry.source.name]
        return vim_item
      end,
    },
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    window = {
      completion = cmp.config.window.bordered { border = "single" },
      documentation = cmp.config.window.bordered { border = "single" },
    },
    -- view = {
    --   entries = "native",
    -- },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-y>"] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<CR>"] = cmp.mapping.confirm { select = true },
      ["<C-CR>"] = cmp.mapping.confirm { select = true },
      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require("luasnip").expand_or_jumpable() then
          require("luasnip").expand_or_jump()
        else
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))

          if col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil then
            cmp.complete()
          else
            --vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n")
            fallback()
          end
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<C-j>"] = cmp.mapping(function(fallback)
        cmp.mapping.abort()
        -- local copilot_keys = vim.fn["copilot#Accept"]()
        -- if copilot_keys ~= "" then
        --   vim.api.nvim_feedkeys(copilot_keys, "i", true)
        -- else
        fallback()
        -- end
      end),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "cmp_tabnine" },
    }, {
      { name = "buffer" },
    }),
    matching = {
      disallow_fuzzy_matching = true,
      disallow_partial_matching = false,
      disallow_prefix_unmatching = false,
    },
  }

  -- Use buffer source for `/`.
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline {
      -- ["<Down>"] = { c = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert } },
      -- ["<Up>"] = { c = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert } },
      ["<C-Space>"] = { c = cmp.mapping.complete() },
      ["<C-CR>"] = { c = cmp.mapping.confirm { select = true } },
      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    },
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })

  -- Wire-in nvim-autopairs
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

  vim.cmd [[set completeopt=menu,menuone,noselect]]
end

return {
  setup = function(use)
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        { "L3MON4D3/LuaSnip" },
        { "saadparwaiz1/cmp_luasnip" },
        { "rafamadriz/friendly-snippets" },
        { "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp", config = tabnine_config },
      },
      after = { "nvim-autopairs", "LuaSnip" },
      config = config,
    }
  end,
}
