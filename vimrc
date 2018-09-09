" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set nobackup
set nowritebackup
set noswapfile
set history=20		" keep 20 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set hls			" highlight all search results
set nojoinspaces	" no extra whitespace after punctation
set colorcolumn=81
set number
set visualbell
set noerrorbells
set tabstop=2
set shiftwidth=2
set expandtab
set showmatch
set ignorecase    " ignore case when searching
" ignore case if search pattern is all lowercase, case-sensitive otherwise
set smartcase
" insert tabs on the start of a line according to shiftwidth, not tabstop
set smarttab
set encoding=utf-8
set splitbelow
set splitright
syntax on

map :Q :q
map :W :w
map :E :e
vnoremap <C-c> "+y
"vnoremap <C-i> "+p
vnoremap // y/<C-R>"<CR>

nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> <cr> :call LanguageClient_textDocument_hover()<cr>

colorscheme Tomorrow-Night

" Enable mouse if it is available "
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

"Whitespace highlighting
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/
highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraLines ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

  autocmd FileType
        \ ruby,vim,eruby,yml,sass,css,javascript,elixir,cucumber,haml,html
        \ autocmd BufWritePre <buffer> %s/\s\+$//e
augroup END

" Special key mappings
let mapleader=" "
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>b :CtrlPBuffer<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>g :Ag!<space>
map <leader>s :Ag! <cword><CR>
nnoremap <silent> <leader>h :nohlsearch<CR>

" Test mappings
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ts :TestSuite<CR>
nnoremap <silent> <leader>tl :TestLast<CR>
nnoremap <silent> <leader>tv :TestVisit<CR>

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fireplace'
"Plug 'https://github.com/guns/vim-clojure-static.git'"
"Plug 'venantius/vim-cljfmt'

Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'kien/ctrlp.vim'

"Plug 'mileszs/ack.vim'
Plug 'rking/ag.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-surround'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'vim-scripts/paredit.vim'

Plug 'ervandew/supertab'

Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

Plug 'tpope/vim-endwise'

Plug 'vim-ruby/vim-ruby'

Plug 'janko-m/vim-test'

Plug 'scrooloose/nerdcommenter'

"--- reason ---
"Plug 'reasonml-editor/vim-reason-plus'

"Plug 'autozimu/LanguageClient-neovim', {
    "\ 'branch': 'next',
    "\ 'do': 'bash install.sh',
    "\ }

"Plug 'junegunn/fzf'

"if has('nvim')
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
  "Plug 'Shougo/deoplete.nvim'
  "Plug 'roxma/nvim-yarp'
  "Plug 'roxma/vim-hug-neovim-rpc'
"endif
"--- reason ---
" Initialize plugin system (:PlugInstall in vim!)
call plug#end()
" clean unused plugins with :PlugClean

" airline config
set laststatus=2
"let g:airline_theme='onedark'
let g:airline_symbols_ascii = 1

" NERDTree should show hidden files
let NERDTreeShowHidden=1

if executable('ag"')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
  " use ag for ack
  "let g:ackprg = 'ag --vimgrep'
endif

" Activation based on file type
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

"--- reason ---
"let g:LanguageClient_serverCommands = {
    "\ 'reason': ['ocaml-language-server', '--stdio'],
    "\ 'ocaml': ['ocaml-language-server', '--stdio'],
    "\ }

"let g:deoplete#enable_at_startup = 1
"--- reason ---
