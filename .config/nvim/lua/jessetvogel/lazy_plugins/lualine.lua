return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local lualine = require("lualine")

            local conditions = {
                buffer_not_empty = function()
                    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
                end,
                hide_in_width = function()
                    return vim.fn.winwidth(0) > 80
                end,
                check_git_workspace = function()
                    local filepath = vim.fn.expand("%:p:h")
                    local gitdir = vim.fn.finddir(".git", filepath .. ";")
                    return gitdir and #gitdir > 0 and #gitdir < #filepath
                end,
            }

            local colors = {
                bg = "#161b22",
                fg = "#c6cdd5",
                yellow = "#ECBE7B",
                cyan = "#a2d2fb",
                darkblue = "#081633",
                green = "#7ce38b",
                orange = "#faa356",
                violet = "#cea5fb",
                magenta = "#cea5fb",
                blue = "#77bdfb",
                red = "#fa7970",
                gray = "#89929b",
            }

            local function to_lower(s)
                return s:lower()
            end

            local config = {
                options = {
                    -- Disable sections and component separators
                    component_separators = "",
                    section_separators = "",
                    theme = {
                        normal = { a = { bg = colors.blue }, b = { bg = colors.bg }, c = { bg = colors.bg } },
                        insert = { a = { bg = colors.green }, b = { bg = colors.bg }, c = { bg = colors.bg } },
                        visual = { a = { bg = colors.orange }, b = { bg = colors.bg }, c = { bg = colors.bg } },
                        replace = { a = { bg = colors.red }, b = { bg = colors.bg }, c = { bg = colors.bg } },
                        command = { a = { bg = colors.violet }, b = { bg = colors.bg }, c = { bg = colors.bg } },
                        inactive = { a = { bg = colors.gray }, b = { bg = colors.bg }, c = { bg = colors.bg } },
                    },
                },
                sections = {
                    -- These are to remove the defaults
                    lualine_a = {
                        {
                            "mode",
                            fmt = to_lower,
                        },
                    },
                    lualine_b = {
                        {
                            -- Git branch
                            "branch",
                            icon = "",
                            color = { fg = colors.fg, bg = colors.bg, gui = "bold" },
                        },
                    },
                    lualine_y = {},
                    lualine_z = {},
                    -- These will be filled later
                    lualine_c = {
                        {
                            -- Git diff
                            "diff",
                            symbols = { added = " ", modified = " ", removed = " " },
                            diff_color = {
                                added = { fg = colors.green },
                                modified = { fg = colors.orange },
                                removed = { fg = colors.red },
                            },
                            color = { bg = colors.bg },
                            cond = conditions.hide_in_width,
                        },

                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            symbols = { error = " ", warn = " ", info = " " },
                            diagnostics_color = {
                                color_error = { fg = colors.red },
                                color_warn = { fg = colors.yellow },
                                color_info = { fg = colors.blue },
                            },
                            color = { bg = colors.bg },
                        },
                        {
                            function()
                                return "%="
                            end,
                            color = { bg = colors.bg },
                        },
                        {
                            "filetype",
                            icon_only = true,
                            separator = "",
                            padding = { right = 0, left = 0 },
                            color = { fg = colors.fg },
                        },
                        {
                            "filename",
                            padding = { left = 0, right = 0 },
                            file_status = true, -- Displays file status (readonly status, modified status)
                            newfile_status = false, -- Display new file status (new file means no write after created)
                            path = 4, -- 0: Just the filename
                            -- 1: Relative path
                            -- 2: Absolute path
                            -- 3: Absolute path, with tilde as the home directory
                            -- 4: Filename and parent dir, with tilde as the home directory

                            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                            -- for other components. (terrible name, any suggestions?)
                            -- It can also be a function that returns
                            -- the value of `shorting_target` dynamically.
                            symbols = {
                                modified = "[+]", -- Text to show when the file is modified.
                                readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
                                unnamed = "[no file]", -- Text to show for unnamed buffers.
                                newfile = "[new file]", -- Text to show for newly created file before first write
                            },
                            color = { fg = colors.fg, gui = "bold" },
                        },
                    },
                    lualine_x = {
                        {
                            "location",
                            color = { fg = colors.fg },
                            cond = conditions.buffer_not_empty,
                        },
                        {
                            "encoding",
                            color = { fg = colors.fg },
                        },
                        {
                            -- LSP server name
                            function()
                                local msg = ""
                                local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                                local clients = vim.lsp.get_clients()
                                if next(clients) == nil then
                                    return msg
                                end
                                for _, client in ipairs(clients) do
                                    local filetypes = client.config.filetypes
                                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                        return "  " .. client.name
                                    end
                                end
                                return msg
                            end,
                            icon = "",
                            color = { fg = colors.fg, gui = "bold" },
                        },
                    },
                },
                inactive_sections = {
                    -- These are to remove the defaults
                    lualine_a = {},
                    lualine_b = {},
                    lualine_y = {},
                    lualine_z = {},
                    lualine_c = {},
                    lualine_x = {},
                },
            }

            -- Setup lualine
            lualine.setup(config)
        end,
    },
}
