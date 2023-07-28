vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move half page but keep cursor in mid
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


vim.keymap.set("n", "<leader>e", ":NERDTreeToggle<CR>")

local map = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

map('n', '<leader>', ':WhichKey \'<Space>\'<CR>', {noremap = true, silent = true})

map('v', '<leader>y', '"+y', opts)
map('n', '<leader>Y', '"+yg_', opts)
map('n', '<leader>y', '"+y', opts)
map('n', '<leader>yy', '"+yy', opts)


-- -- Copilot
-- vim.g.copilot_no_tab_map = true
-- vim.api.nvim_set_keymap("i", "<Right>", "copilot#Accept('<CR>')", {expr = true, noremap = true})
