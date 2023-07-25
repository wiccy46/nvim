vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.encoding = 'utf-8'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 50

-- For equivalent of autocmd you should use augroup in vim.cmd
vim.cmd [[
  autocmd Filetype md let g:indentLine_setConceal = 0 | let g:vim_json_syntax_conceal = 0
  autocmd Filetype json let g:conceallevel = 2
  augroup FileTypeSpecificAutocommands
      autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
      autocmd FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2
      autocmd FileType ts setlocal tabstop=2 softtabstop=2 shiftwidth=2
      autocmd FileType php setlocal tabstop=2 softtabstop=2 shiftwidth=2
      autocmd FileType jsx setlocal tabstop=2 softtabstop=2 shiftwidth=2
      autocmd FileType vue setlocal tabstop=2 softtabstop=2 shiftwidth=2
      autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2
      autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2
  augroup END
]]
