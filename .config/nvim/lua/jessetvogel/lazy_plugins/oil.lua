return {
    {
        "stevearc/oil.nvim",
        lazy = false, -- lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        config = function()
            -- Set hidden files
            local is_hidden = {}
            is_hidden[".."] = true
            is_hidden[".git"] = true
            is_hidden[".DS_Store"] = true

            require("oil").setup({
                view_options = {
                    show_hidden = false,
                    is_hidden_file = function(name, _)
                        return is_hidden[name]
                    end,
                },
            })
        end,
    },
}
