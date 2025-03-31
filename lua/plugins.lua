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
} 
