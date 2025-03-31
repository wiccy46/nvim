-- Key mappings configuration

-- System clipboard integration
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank selection to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank line to system clipboard' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<leader>P', '"+P', { desc = 'Paste from system clipboard before cursor' })

-- Neo-tree
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle Neo-tree' })

-- Popup completion mappings
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

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local buffer = ev.buf

    -- Enable inlay hints for Rust
    if client.name == "rust_analyzer" then
      print("the buffer is " .. buffer)
      vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
    end

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    local wk = require("which-key")
    
    -- Use a simpler registration format
    wk.register({
      g = {
        name = "Goto",
        d = { vim.lsp.buf.definition, "Go to Definition" },
        D = { vim.lsp.buf.declaration, "Go to Declaration" },
        r = { vim.lsp.buf.references, "Find References" },
      },
      K = { vim.lsp.buf.hover, "Show Hover" },
      r = {
        name = "Refactor",
        n = { vim.lsp.buf.rename, "Rename" },
      },
      c = {
        name = "Code",
        a = { vim.lsp.buf.code_action, "Code Action" },
      },
    }, { buffer = buffer, prefix = "<leader>" })
  end,
})

-- DAP keybindings setup
local function setup_dap_keymaps()
  local dap = require("dap")
  local dapui = require("dapui")
  
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
  
  -- Simpler which-key registration
  local wk = require("which-key")
  wk.register({
    d = {
      name = "Debug",
      b = { dap.toggle_breakpoint, "Toggle Breakpoint" },
      c = { dap.continue, "Continue" },
      o = { dap.step_over, "Step Over" },
      i = { dap.step_into, "Step Into" },
      u = { dap.step_out, "Step Out" },
      r = { dap.repl.open, "Open REPL" },
      e = { dapui.eval, "Evaluate Expression" },
      q = { dap.terminate, "Quit Debugging" },
    }
  }, { prefix = "<leader>" })
end

-- Tab management keybindings
local function setup_tab_keymaps()
  local wk = require("which-key")
  wk.register({
    t = {
      name = "Tabs",
      n = { "<cmd>tabnew<CR>", "New Tab" },
      c = { "<cmd>tabclose<CR>", "Close Tab" },
      o = { "<cmd>tabonly<CR>", "Close Other Tabs" },
      l = { "<cmd>tabnext<CR>", "Next Tab" },
      h = { "<cmd>tabprevious<CR>", "Previous Tab" },
      f = { "<cmd>tabfirst<CR>", "First Tab" },
      L = { "<cmd>tablast<CR>", "Last Tab" },
      m = { "<cmd>tab split<CR>", "Move Buffer to New Tab" },
      r = { "<cmd>tabmove +1<CR>", "Move Tab Right" },
      R = { "<cmd>tabmove -1<CR>", "Move Tab Left" },
    }
  }, { prefix = "<leader>" })
end

-- Initialize keymap modules
local M = {}

M.setup = function()
  -- Set up tab keymaps immediately
  setup_tab_keymaps()
  
  -- Load DAP keymaps only when needed
  M.setup_dap = setup_dap_keymaps
end

return M 