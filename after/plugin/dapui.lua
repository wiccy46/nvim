require("dapui").setup()
require("nvim-dap-virtual-text").setup()
require("dap-go").setup()
require("dap-python").setup()

-- Set keymaps to control the debugger
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)


vim.api.nvim_set_keymap("n", "<leader>dt", ":DapUiToggle<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", {noremap = true})

-- Initialize a global variable
_G.dapui_state = _G.dapui_state or false

function ToggleDapUI()
    local dapui = require('dapui')
    if _G.dapui_state then
        dapui.close()
        _G.dapui_state = false
    else
        dapui.open()
        _G.dapui_state = true
    end
end

vim.api.nvim_set_keymap("n", "<leader>do", ":lua ToggleDapUI()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", {noremap = true})
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint'})
