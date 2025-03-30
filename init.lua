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

require('lazy').setup({
	{ "folke/lazydev.nvim",               opts = {} },
	{ "j-hui/fidget.nvim",     opts = {}, },

	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason-lspconfig.nvim" },
	{
	"williamboman/mason.nvim",
		config = function()
		require("mason").setup()
		require("mason-lspconfig").setup()
		require("mason-lspconfig").setup_handlers({
		  function(server_name)
		    require("lspconfig")[server_name].setup({})
		  end,
		})
		end
	},
	{
	    "nvim-treesitter/nvim-treesitter",
	    build = ":TSUpdate", -- Automatically update parsers on install/update
	    config = function()
	      require("nvim-treesitter.configs").setup({
            -- List of parsers to install (or use "all" for all maintained parsers)
            ensure_installed = { "lua", "python", "javascript", "typescript" , "rust"},
            -- Enable syntax highlighting
            highlight = {
              enable = true,
              -- Disable for large files if performance is an issue
              disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                  return true
                end
              end,
            },
            -- Optional: Enable indentation (experimental, may conflict with LSP)
            indent = { enable = true },
	      })
	    end,
	},
    { "nyoom-engineering/oxocarbon.nvim" },
    { "nvim-lua/plenary.nvim" },
    {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
        },
      })
    end,
    },
      -- Add which-key.nvim
    {
        "folke/which-key.nvim",
        event = "VeryLazy", -- Load after most plugins
        opts = {
          -- Optional configuration
          plugins = { spelling = true }, -- Enable spelling suggestions
          window = { border = "single" }, -- Customize popup border
        },
        config = function()
          local wk = require("which-key")
          -- Register Telescope keybindings
          wk.register({
            ["<leader>"] = { "<cmd>Telescope find_files<CR>", "Quickly open a file" },
            f = {
              name = "Find", -- Group name for <leader>f mappings
              s = { "<cmd>Telescope live_grep<CR>", "Grep in workspace" },
            },
          }, { prefix = "<leader>" })
        end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- Optional but recommended for icons
	"MunifTanjim/nui.nvim",
      },
	lazy = false, -- neo-tree will lazily load itself
	  ---@module "neo-tree"
	  ---@type neotree.Config?
	  opts = {
	    -- fill any relevant options here
	  },
    },

    { "mfussenegger/nvim-dap" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
  { "mfussenegger/nvim-dap-python" },
})

vim.cmd("colorscheme oxocarbon")

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

    local opts = { buffer = buf, noremap = true, silent = true }
    local wk = require("which-key")
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
    }, { prefix = "<leader>", buffer = buf })

    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)          -- Go to definition
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)         -- Go to declaration
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)          -- Find references
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)                -- Show hover documentation
    -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)      -- Rename symbol
    -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code action
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
  d = {
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
}, { prefix = "<leader>" })
