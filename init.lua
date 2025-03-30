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


vim.cmd("colorscheme gruvbox")

vim.o.number = true
vim.o.signcolumn = "yes"
vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- disable new line auto comment

vim.o.completeopt = "menu,noinsert,popup,fuzzy"

local pumMaps = {
  ['<Tab>'] = '<C-n>',
  ['<S-Tab>'] = '<C-p>',
  ['<Down>'] = '<C-n>',
  ['<Up>'] = '<C-p>',
  ['<CR>'] = '<C-y>',
}

for insertKmap, pumKmap in pairs(pumMaps) do
  vim.keymap.set('i', insertKmap, function()
    return vim.fn.pumvisible() == 1 and pumKmap or insertKmap
  end, { expr = true })
end

vim.lsp.config["lua-language-server"] = {
	cmd = { "lua-language-server" },
	root_markers = { ".luarc.json" },
	filetypes = { "lua" },
}

vim.lsp.enable("lua-language-server")


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    local buffer = ev.buf
    local wk = require("which-key")
    wk.register({
      ["<leader>g"] = { name = "Goto" },
      ["<leader>gd"] = { vim.lsp.buf.definition, "Go to Definition" },
      ["<leader>gD"] = { vim.lsp.buf.declaration, "Go to Declaration" }, 
      ["<leader>gr"] = { vim.lsp.buf.references, "Find References" },
      ["<leader>K"] = { vim.lsp.buf.hover, "Show Hover" },
      ["<leader>r"] = { name = "Refactor" },
      ["<leader>rn"] = { vim.lsp.buf.rename, "Rename" },
      ["<leader>c"] = { name = "Code" },
      ["<leader>ca"] = { vim.lsp.buf.code_action, "Code Action" },
    }, { buffer = buffer })

  end,
})

vim.diagnostic.config({ virtual_lines = { current_line = true } })

vim.o.winborder = 'rounded'

-- Default tab settings: 4 spaces
vim.o.tabstop = 4        -- Number of spaces a tab counts for
vim.o.shiftwidth = 4     -- Number of spaces for indentation
vim.o.expandtab = true   -- Convert tabs to spaces

-- Override for JS and TS: 2 spaces
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
})

-- System clipboard integration
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank selection to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank line to system clipboard' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<leader>P', '"+P', { desc = 'Paste from system clipboard before cursor' })

vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle Neo-tree' })

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

-- DAP UI auto-open/close
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- DAP keybindings
local wk = require("which-key")
wk.register({
  ["<leader>d"] = {
    name = "Debug",
    b = { require("dap").toggle_breakpoint, "Toggle Breakpoint" },
    c = { require("dap").continue, "Continue" },
    o = { require("dap").step_over, "Step Over" },
    i = { require("dap").step_into, "Step Into" },
    u = { require("dap").step_out, "Step Out" },
    r = { require("dap").repl.open, "Open REPL" },
    e = { require("dapui").eval, "Evaluate Expression" },
    q = { require("dap").terminate, "Quit Debugging" },
  },
})
