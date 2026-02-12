return {
    'saghen/blink.cmp',
    opts = {
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
    },
    opts_extend = { "sources.default" }
}
