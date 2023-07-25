vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move half page but keep cursor in mid
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


vim.keymap.set("n", "<leader>e", ":NERDTreeToggle<CR>")

vim.api.nvim_set_keymap('n', '<leader>', ':WhichKey \'<Space>\'<CR>', {noremap = true, silent = true})

