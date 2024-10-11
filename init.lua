-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.filetype.add({
  filename = {
    Jenkinsfile = "groovy",
  },
})


vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.Jenkinsfile",
    callback = function()
        vim.bo.filetype = "groovy"
    end,
})
