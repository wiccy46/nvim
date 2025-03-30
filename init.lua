vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Setting up lazy.nvim ]]
-- Bootstrap lazy.nvim: synchronize if it's not already installed.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  print('Installing lazy.nvim...')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none', -- Use filter for faster clone
    '--branch=stable',    -- Recommended to use the stable branch
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
  print('lazy.nvim installed successfully!')
end
-- Prepend lazy.nvim directory to runtime path to make it discoverable
vim.opt.rtp:prepend(lazypath)

-- Load plugin specifications from separate file
require('lazy').setup(require('plugins'))

-- Load keymaps
require('keymaps').setup()

vim.cmd("colorscheme gruvbox")

vim.o.number = true
vim.o.signcolumn = "yes"
vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- disable new line auto comment
vim.o.completeopt = "menu,noinsert,popup,fuzzy"

vim.lsp.config["lua-language-server"] = {
	cmd = { "lua-language-server" },
	root_markers = { ".luarc.json" },
	filetypes = { "lua" },
}

vim.lsp.enable("lua-language-server")

vim.diagnostic.config({ virtual_lines = { current_line = true } })

vim.o.winborder = 'rounded'

-- Default tab settings: 4 spaces
vim.o.tabstop = 4        -- Number of spaces a tab counts for
vim.o.shiftwidth = 4     -- Number of spaces for indentation
vim.o.expandtab = true   -- Convert tabs to spaces

-- Override for JS and TS: 2 spaces
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "lua" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
})

-- DAP Configuration
local dap = require("dap")
local dapui = require("dapui")

-- Python setup
require("dap-python").setup("python")

-- Rust setup (using codelldb via Mason)
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
    args = { "--port", "${port}" },
  },
}

dap.configurations.rust = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.configurations.python = {
  {
    name = "Launch file",
    type = "python",
    request = "launch",
    program = "${file}",
    pythonPath = function()
      return "python"
    end,
  },
}

require('keymaps').setup_dap()
