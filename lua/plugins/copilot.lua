return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Let copilot use its default key mappings
      vim.g.copilot_no_tab_map = false
      vim.g.copilot_assume_mapped = false
      vim.g.copilot_tab_fallback = ""
      -- Enable copilot for specific filetypes
      vim.g.copilot_filetypes = {
        ["*"] = true,
        -- Add any specific filetype configurations if needed
        -- Example: ["markdown"] = true,
      }
    end,
  }
}
