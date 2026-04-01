require "nvchad.mappings"

-- Remove NvChad's window navigation to let tmux-navigator handle it
vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")

-- Set up tmux-navigator keybindings
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")

local map = vim.keymap.set
local wk = require("which-key")
wk.add({
  { "<leader>d", group = "Debugger" },
  { "<leader>r", group = "Renamer" },
  { "<leader>l", group = "Diagnostics" },
  { "<leader>h", group = "Harpoon" },
})

map("n", "<leader>ha", function() require("harpoon"):list():add() end, { desc = "Harpoon Add" })
map("n", "<leader>he", function()
  local harpoon = require("harpoon")
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Menu" })
map("n", "<C-e>", function()
  local harpoon = require("harpoon")
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Menu" })
map("n", "<leader>h1", function() require("harpoon"):list():select(1) end, { desc = "Harpoon 1" })
map("n", "<leader>h2", function() require("harpoon"):list():select(2) end, { desc = "Harpoon 2" })
map("n", "<leader>h3", function() require("harpoon"):list():select(3) end, { desc = "Harpoon 3" })
map("n", "<leader>h4", function() require("harpoon"):list():select(4) end, { desc = "Harpoon 4" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Diagnostics
map("n", "<leader>lx", "<cmd>Telescope diagnostics<cr>", { desc = "Show all diagnostics" })
map("n", "<leader>lf", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Show file diagnostics" })
map("n", "<leader>lo", function()
  vim.diagnostic.open_float()
end, { desc = "Open diagnostic float" })
map("n", "<leader>lc", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
  if #diagnostics > 0 then
    local message = diagnostics[1].message
    vim.fn.setreg('+', message)
    vim.notify("Copied: " .. message, vim.log.levels.INFO)
  else
    vim.notify("No diagnostic on this line", vim.log.levels.WARN)
  end
end, { desc = "Copy diagnostic message" })
map("n", "<leader>lq", function()
  vim.diagnostic.setqflist()
  vim.cmd("copen")
end, { desc = "Diagnostics to quickfix" })
map("n", "[d", function()
  vim.diagnostic.goto_prev()
end, { desc = "Previous diagnostic" })
map("n", "]d", function()
  vim.diagnostic.goto_next()
end, { desc = "Next diagnostic" })
map("n", "gl", function()
  vim.diagnostic.open_float()
end, { desc = "Show diagnostic" })

map("n", "<Leader>ff", function()
  require('telescope.builtin').find_files({ previewer = false })
end, { desc = "Telescope Find Files (no preview)" })

-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
	"n",
	"<Leader>dd",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })
-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })


-- Copy current line's diagnostic to clipboard
vim.keymap.set('n', '<leader>cp', function()
  local diagnostics = vim.diagnostic.get_curr_pos()
  if #diagnostics > 0 then
    vim.fn.setreg('+', diagnostics[1].message)
    print("Diagnostic copied to clipboard!")
  end
end, { desc = "Copy diagnostic to clipboard" })


require("tabme").setup({
    keybindings = {
        pin = "<leader>tp",
        focus = "<leader>tf",
    },
    tabline = false, -- Whether to override the tabline
    highlight = {
        link = "Title", -- Highlight group for the pinned tab
        bold = true,
    },
})
