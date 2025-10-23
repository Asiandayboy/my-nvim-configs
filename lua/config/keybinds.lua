vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("n", "<leader>cd", function()
  require("oil").open()
end, { desc = "Go up one directory in Oil" })


-- F2 to rename a symbol, like VSCode :]
vim.keymap.set('n', "<F2>", function()
	vim.lsp.buf.rename(nil)
end, { desc = "Rename symbol" })


-- Normal mode: Tab goes to next tab
vim.keymap.set('n', '<Tab>', 'gt', { noremap = true, silent = true })

-- Normal mode: Shift-Tab goes to previous tab
vim.keymap.set('n', '<S-Tab>', 'gT', { noremap = true, silent = true })

vim.keymap.set('n', "<C-Up>", "<C-u>", { noremap = true, silent = true })
vim.keymap.set('n', "<C-Down>", "<C-d>", { noremap = true, silent = true })

vim.keymap.set('n', "tt", function()
	vim.cmd("tabnew | term")
end, { desc = "Open a new terminal tab page" })
