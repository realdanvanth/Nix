require('lspconfig').clangd.setup {
    cmd = { "clangd", "--offset-encoding=utf-8" },
    on_attach = function(client, bufnr)
        -- Your existing setup for on_attach
    end,
}

