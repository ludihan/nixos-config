vim.pack.add({
    'https://github.com/ellisonleao/gruvbox.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/hiphish/rainbow-delimiters.nvim',
    'https://github.com/folke/snacks.nvim',
    'https://github.com/Saghen/blink.cmp',
    -- 'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/windwp/nvim-ts-autotag',
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("EnableTreesitterHighlighting", { clear = true }),
  desc = "Try to enable tree-sitter syntax highlighting",
  pattern = "*",
  callback = function()
    pcall(function() vim.treesitter.start() end)
  end,
})

require('nvim-ts-autotag').setup({
  opts = {
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = true -- Auto close on trailing </
  },
})

require("gruvbox").setup()
vim.cmd.colorscheme('gruvbox')

require("snacks").setup()
require("snacks.bigfile").setup()

require("oil").setup()

require("telescope").setup({
    defaults = {
        border = false,
        layout_config = {
            width = { padding = 0 },
            height = { padding = 0 }
        },
        results_title = false,
        prompt_title = false,
        prompt_prefix = ">>> ",
        sorting_strategy = "ascending",
        layout_strategy = "bottom_pane",
    },
})


require('blink.cmp').setup({
    appearance = {
        nerd_font_variant = 'mono',
        kind_icons = {
            Text = '',
            Method = '',
            Function = '',
            Constructor = '',

            Field = '',
            Variable = '',
            Property = '',

            Class = '',
            Interface = '',
            Struct = '',
            Module = '',

            Unit = '',
            Value = '',
            Enum = '',
            EnumMember = '',

            Keyword = '',
            Constant = '',

            Snippet = '',
            Color = '',
            File = '',
            Reference = '',
            Folder = '',
            Event = '',
            Operator = '',
            TypeParameter = '',
        },
    },

    completion = { documentation = { auto_show = true } },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "lua" }
})
