return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
        local cmp = require("cmp")
        opts.mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        })
        return opts
    end,
  },
  {
    "rose-pine/nvim",
    name = "rose-pine",
    config = function()
      vim.cmd("colorscheme rose-pine")
    end
  },

  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      vim.g.copilot_enabled = true
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
	--    config = function ()
	--      local mason_registry = require('mason-registry')
	--      local codelldb = mason_registry.get_package("codelldb")
	--      local extension_path = codelldb:get_install_path() .. "/extension/"
	--      local codelldb_path = extension_path .. "adapter/codelldb"
	--      local liblldb_path = extension_path.. "lldb/lib/liblldb.dylib"
	-- -- If you are on Linux, replace the line above with the line below:
	-- -- local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
	--      local cfg = require('rustaceanvim.config')
	--
	--      vim.g.rustaceanvim = {
	--        dap = {
	--          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
	--        },
	--      }
	--    end
  },
    {
    'mfussenegger/nvim-dap',
    config = function()
			local dap, dapui = require("dap"), require("dapui")

      require("configs.dap")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
		end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
			require("dapui").setup()
		end,
  },

  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        -- Set 'ignore' to false to show files listed in .gitignore
        ignore = false,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    version = "v0.9.3",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleStat" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css"
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true, -- Shows who (Claude!) changed the line in ghost text
      signcolumn = true,
      numhl = true, -- Highlights the line number for changed lines
    }
  },
}
