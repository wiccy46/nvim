require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls" }
vim.lsp.enable(servers)

-- Configure pyright using the new vim.lsp.config API
vim.lsp.config('pyright', {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
  before_init = function(_, config)
    -- Try to find venv in current directory
    local venv_path = vim.fn.getcwd() .. "/venv/bin/python"
    if vim.fn.filereadable(venv_path) == 1 then
      config.settings.python.pythonPath = venv_path
    else
      -- Try .venv as fallback
      venv_path = vim.fn.getcwd() .. "/.venv/bin/python"
      if vim.fn.filereadable(venv_path) == 1 then
        config.settings.python.pythonPath = venv_path
      end
    end
  end,
})

-- Enable pyright
vim.lsp.enable('pyright')

vim.diagnostic.config({
  virtual_text = true,  -- Show inline diagnostics
  signs = true,         -- Show signs in gutter
  underline = true,     -- Underline problematic code
  update_in_insert = false,  -- Don't update while typing
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",  -- Show source in float
    header = "",
    prefix = "",
  },
})
