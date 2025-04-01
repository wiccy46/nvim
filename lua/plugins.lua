-- Plugin configuration
return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {}
  },
  { "j-hui/fidget.nvim", opts = {}, },

  { "neovim/nvim-lspconfig" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          local opts = {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              -- Enable inlay hints for Rust
              if client.name == "rust_analyzer" then
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
              end
            end
          }
          
          -- Special configuration for rust-analyzer
          if server_name == "rust_analyzer" then
            opts.settings = {
              ["rust-analyzer"] = {
                checkOnSave = {
                  command = "clippy"
                }
              }
            }
          end
          
          lspconfig[server_name].setup(opts)
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
  -- { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = {}},
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

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
      -- Register Telescope keybindings with simple format
      wk.register({
        ["<leader><leader>"] = { "<cmd>Telescope find_files<CR>", "Find File" },
        ["<leader>f"] = { 
          name = "Find",
          s = { "<cmd>Telescope live_grep<CR>", "Grep in workspace" },
        },
      })
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
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    -- opts = {
    --   -- add any opts here
    --   -- for example
    --   provider = "openai",
    --   openai = {
    --     endpoint = "https://api.openai.com/v1",
    --     model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
    --     timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
    --     temperature = 0,
    --     max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
    --     --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    --   },
    -- },
    opts = {
      provider = "deepseek",
      vendors = {
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          api_key = vim.fn.getenv("DEEPSEEK_API_KEY"),
          endpoint = "https://api.deepseek.com",
          model = "deepseek-coder",
          timeout = 30000,
          temperature = 0,
          max_tokens = 8192,
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
} 
