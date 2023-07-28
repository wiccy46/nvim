local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
  }
})

-- local cmp = require('cmp')
-- local cmp_action = require('lsp-zero').cmp_action()

-- cmp.setup({
--   mapping = {
--     ['<Tab>'] = cmp_action.tab_complete(),
--     ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
--   }
-- })
