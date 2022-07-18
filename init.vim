 ":Load key mapping and which key.
source $HOME/.config/nvim/keys/mapping.vim
source $HOME/.config/nvim/keys/which-key.vim
if has('win32') || has('win64')
  let g:plugged_home = '~/AppData/Local/nvim/plugged'
else
  let g:plugged_home = '~/.config/nvim/plugged'
endif
" Plugins List
call plug#begin(g:plugged_home)
  " Easy comment
  Plug 'tpope/vim-commentary'
  " UI related
  Plug 'chriskempson/base16-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Better Visual Guide
  Plug 'Yggdroot/indentLine'
  " " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  "" Nord
  Plug 'arcticicestudio/nord-vim'
  " File Explorer
  Plug 'preservim/nerdtree'
  " " syntax check
  " Plug 'w0rp/ale'
  " Formater
  Plug 'Chiel92/vim-autoformat'
  " Control P Fuzzy Find
  Plug 'ctrlpvim/ctrlp.vim'
  " Indentation guide
  Plug 'nathanaelkane/vim-indent-guides'
  " Tmux integration, use vim commands in tmux
  Plug 'christoomey/vim-tmux-navigator'
  " Show key-binding
  Plug 'liuchengxu/vim-which-key'
  " Floatterm, using terminal within vim
  Plug 'voldikss/vim-floaterm'
  " OneDark
  Plug 'joshdick/onedark.vim'
  " Using gruvbox theme
  Plug 'morhetz/gruvbox'
  "
  " Space duck
  Plug 'sheerun/vim-polyglot'
  Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
  " Using Ayu thme
  " Plug 'ayu-theme/ayu-vim'
  " " Use release branch (recommend)
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " YAML support
  Plug 'mrk21/yaml-vim'
  " " C++ syntaxt
  " Plug 'jackguo380/vim-lsp-cxx-highlight'
  " Plug 'vim-syntastic/syntastic'
  " Auto brackets pairing
  Plug 'jiangmiao/auto-pairs'
  " JS highlight
  Plug 'yuezk/vim-js'

  " Run test suites for various languages
  Plug 'janko/vim-test'

  " Debugger
  Plug 'puremourning/vimspector'
  Plug 'szw/vim-maximizer'

  Plug 'hrsh7th/vim-vsnip'
  " Plug 'rafamadriz/friendly-snippets'
  " Prettier
  " post install (yarn install | npm install) then load plugin only for editing supported files
  Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

  " Markdown
  Plug 'godlygeek/tabular'
  Plug 'preservim/vim-markdown'

  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


call plug#end()
filetype plugin indent on
" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif


"--------------------------------------------------------"
"
"
" Configurations dPart
" UI configuration
syntax on
syntax enable
" colorscheme
let base16colorspace=256
" colorscheme base16-gruvbox-dark-hard
" set background=dark
" True Color Support if it's avaiable in terminal
if has("termguicolors")
    set termguicolors
endif
if has("gui_running")
  set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:blocks
endif
" let ayucolor="dark"
colorscheme nord
set number
set relativenumber
set hidden
set mouse=a
set noshowmode
set noshowmatch
set nolazyredraw
" Turn off backup
set nobackup
set noswapfile
set nowritebackup
" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase
set hlsearch
" Let copy paste to external
set clipboard=unnamedplus
" Set cursor color
" " Enable CursorLine
set cursorline

" " Default Colors for CursorLine
" highlight  CursorLine ctermbg=Yellow ctermfg=None

" " Change Color when entering Insert Mode
" autocmd InsertEnter * highlight  CursorLine ctermbg=Green ctermfg=Red

" " Revert Color to default when leaving Insert Mode
" autocmd InsertLeave * highlight  CursorLine ctermbg=Yellow ctermfg=None
" vim-autoformat
noremap <leader>af :Autoformat<CR>


" Tab and Indent configuration
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
" Dont hide quotation marks in json
autocmd Filetype md
  \ let g:indentLine_setConceal = 0 |
  \ let g:vim_json_syntax_conceal = 0
autocmd Filetype json
  \ let g:conceallevel = 2
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

" LineNr Color
hi LineNr guifg=#dbdbdb

" <C-Enter>     Insert single / [count] newline.
nnoremap s i<CR><Esc>

" Allow pasting the previous yanked content
" Pates-gotoprevious-visualmode-yankthat
xnoremap p pgvy


" " Remove trailing whitespaces on save
" autocmd BufWritePre * :%s/\s\+$//e

" tabs control
nnoremap tn :tabnew<CR>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

" This is required by Compe
set completeopt=menuone,noselect
set shortmess+=c

" Vim-test
let test#python#runner = 'pytest'

let g:UltiSnipsExpandTrigger="<c-t>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" Markdown

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 2
let g:vim_markdown_conceal_code_blocks = 0

" ---------LOAD CONFIGS ---------------------------
source $HOME/.config/nvim/plug-config/CtrlP.vim
source $HOME/.config/nvim/plug-config/Airline.vim
source $HOME/.config/nvim/plug-config/floaterm.vim
source $HOME/.config/nvim/plug-config/lsp-config.vim
source $HOME/.config/nvim/plug-config/NERDTree.vim


" -------------LOAD LSP _----------

luafile $HOME/.config/nvim/lua/compe-config.lua
luafile $HOME/.config/nvim/lua/python-lsp.lua
luafile $HOME/.config/nvim/lua/ts-lsp.lua
luafile $HOME/.config/nvim/lua/clang-lsp.lua
luafile $HOME/.config/nvim/lua/html-lsp.lua
luafile $HOME/.config/nvim/lua/tree-sitter.lua
luafile $HOME/.config/nvim/lua/rust.lua

cnoreabbrev RR RustRun





highlight Normal guibg=none
highlight NonText guibg=none

au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead *.Jenkinsfile setf groovy
" let g:syntastic_python_pylint_post_args="--max-line-length=120"

