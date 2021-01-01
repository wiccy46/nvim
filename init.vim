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
  " Better Visual Guide
  Plug 'Yggdroot/indentLine'
  " syntax check
  Plug 'w0rp/ale'
  " Formater
  Plug 'Chiel92/vim-autoformat'
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
  " Using Ayu thme
  " Plug 'ayu-theme/ayu-vim'
  " Use release branch (recommend)
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'davidhalter/jedi-vim'
  " YAML support
  Plug 'mrk21/yaml-vim'
  " C++ syntaxt
  Plug 'jackguo380/vim-lsp-cxx-highlight'
  Plug 'vim-syntastic/syntastic'

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
" let ayucolor="dark"
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

" LineNr Color
hi LineNr guifg=#dbdbdb

" <C-Enter>     Insert single / [count] newline.
nnoremap s i<CR><Esc>

" Remove trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" tabs control
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

" c++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_c_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
" The following two lines are optional. Configure it to your liking!
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ---------LOAD CONFIGS ---------------------------
source $HOME/.config/nvim/plug-config/CtrlP.vim
source $HOME/.config/nvim/plug-config/Airline.vim
source $HOME/.config/nvim/plug-config/Ale.vim
source $HOME/.config/nvim/plug-config/floaterm.vim
source $HOME/.config/nvim/plug-config/Coc.vim


highlight Normal guibg=none
highlight NonText guibg=none

au BufNewFile,BufRead Jenkinsfile setf groovy
let g:syntastic_python_pylint_post_args="--max-line-length=120"
