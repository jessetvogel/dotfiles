-- Oil
vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Go to parent directory" })

-- Quickfix next and previous
vim.keymap.set("n", "<C-[>", "<cmd>cprev<CR>", { desc = "Go to previous quickfix item" })
vim.keymap.set("n", "<C-]>", "<cmd>cnext<CR>", { desc = "Go to next quickfix item" })

-- Diagnostic
local function diagnostic_prev()
    vim.diagnostic.jump({ count = -1, float = true })
end

local function diagnostic_next()
    vim.diagnostic.jump({ count = 1, float = true })
end

vim.keymap.set("n", "[d", diagnostic_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", diagnostic_next, { desc = "Go to next [D]iagnostic message" })
