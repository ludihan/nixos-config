vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method('textDocument/formatting') then
            vim.keymap.set("n", "<F3>",
                "<cmd>lua vim.lsp.buf.format({async = true})<cr>"
            )
        end
    end,
})
