require("null-ls").setup {
    filetypes = { "lua", "python" }, -- Exclude C/C++ files
    on_attach = function(client, bufnr)
        -- Enable formatting on save if supported
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,
}

require('lspconfig').clangd.setup {
    filetypes = { "c", "cpp" }, -- Limit to C/C++ files
    on_attach = function(client, bufnr)
        -- Enable formatting on save if supported
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,
}

