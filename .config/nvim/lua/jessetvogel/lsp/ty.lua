-- See: https://docs.astral.sh/ty/editors/#neovim
vim.lsp.config("ty", {
    settings = { ty = {} },
})
vim.lsp.enable("ty")
