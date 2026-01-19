return {
    -- Highlight, edit, and navigate code
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "bash",
                "diff",
                "html",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "rust",
                "python",
            },
            auto_install = true, -- auto-install languages that are not installed
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
}
