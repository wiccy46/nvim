" Load key mapping and which key. 

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
  Plug 'herrbischoff/cobalt2.vim'
  " Plug 'joshdick/onedark.vim'
  " Better Visual Guide
  Plug 'Yggdroot/indentLine'
  " syntax check
  Plug 'w0rp/ale'
  " " Autocomplete
  Plug 'ncm2/ncm2'
  Plug 'roxma/nvim-yarp'
  Plug 'ncm2/ncm2-bufword'
  Plug 'ncm2/ncm2-path'
  " Python completion, commented since I started using kite
  " Plug 'ncm2/ncm2-jedi'
  " vim script completion
  Plug 'ncm2/ncm2-vim'
  " Subscope detection: markdown
  Plug 'ncm2/ncm2-markdown-subscope'
  " ---------- End Autocomplete here "
  " Formater
  Plug 'Chiel92/vim-autoformat'
  " File explorer
  Plug 'preservim/nerdtree'
  " Markdown syntax highlighting, matching rules
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
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
  " Using gruvbox theme
  Plug 'morhetz/gruvbox' 

call plug#end()
filetype plugin indent on
" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Configurations Part
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
colorscheme gruvbox
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

" vim-autoformat
noremap <leader>af :Autoformat<CR>

if exists('g:vscode')
    " VSCode extension
else
    " ordinary neovim
endif

" Tab and Indent configuration
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" <C-Enter>     Insert single / [count] newline.
nnoremap s i<CR><Esc>

" ---------LOAD CONFIGS ---------------------------
source $HOME/.config/nvim/plug-config/CtrlP.vim
source $HOME/.config/nvim/plug-config/Airline.vim
source $HOME/.config/nvim/plug-config/Ale.vim
source $HOME/.config/nvim/plug-config/NERDTree.vim
source $HOME/.config/nvim/plug-config/ncm2.vim
source $HOME/.config/nvim/plug-config/floaterm.vim

