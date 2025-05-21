require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
map("v", "<C-c>", '"+y', { desc = "Copy selection to system clipboard" })

-- Map Ctrl+V to paste from system clipboard
map("n", "<C-v>", '"+p', { desc = "Paste from system clipboard" })
map("i", "<C-v>", '<C-r>+', { desc = "Paste from system clipboard" })

-- Map Ctrl+Z to undo
map("n", "<C-z>", "u", { desc = "Undo" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo in insert mode" })
map("n", "<C-a>", "ggVG", { desc = "Select all text" })

-- Format code with LSP when Ctrl+Shift+I is pressed
vim.keymap.set("n", "<C-S-i>", function()
    vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true })

