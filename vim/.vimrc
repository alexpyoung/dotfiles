""""""""""""""""""""
" Key Mappings
""""""""""""""""""""

let mapleader="," " set this before installing plugins

" Recording
" qq to record, Q to replay
nnoremap Q @q

" Modes
" avoid carpal tunnel in left hand
inoremap jk <esc>
vnoremap jk <esc>
xnoremap jk <esc>
cnoremap jk <C-c>
" force new muscle memory
inoremap <esc> <nop>
vnoremap <esc> <nop>
xnoremap <esc> <nop>
cnoremap <C-c> <nop>

" FZF
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>h :History:<CR>
nnoremap <leader>rg :Rg<space>
nnoremap <leader>w :Windows<CR>

" Git
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>ggh :GitGutterLineHighlightsToggle<CR>

" Indentation
nnoremap <leader>i gg=G
" keep visual selection after indentation
vnoremap > >gv
vnoremap < <gv
vnoremap = =gv

" Newlines
nnoremap o o<esc>
nnoremap O O<esc>

" Vim Plug
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pu :PlugUpdate<CR>

""""""""""""""""""""
" Plugins
""""""""""""""""""""

call plug#begin('~/.vim/vim-plug')

" Navigation
Plug 'jremmen/vim-ripgrep' " respect .gitignore
let g:rg_command='rg --hidden --vimgrep --glob !.git'
let g:rg_highlight=1
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " fuzzy finder
let g:fzf_preview_window = ''
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb' " git commands
Plug 'tpope/vim-vinegar' " enhance netrw
let g:netrw_bufsettings='noma nomod rnu nowrap ro nobl'

" Editor
Plug 'quramy/tsuquyomi', { 'for': ['typescript', 'typecriptreact'] } " tsserver client
Plug 'terryma/vim-multiple-cursors' " sublime style selection
Plug 'tpope/vim-commentary' " polyglot commenting
Plug 'tpope/vim-eunuch' " unix commands
Plug 'tpope/vim-sleuth' " indentation
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat' " quotes and parentheses

" Display
Plug 'airblade/vim-gitgutter' " show patches
Plug 'morhetz/gruvbox' " colors
let g:gruvbox_contrast_dark='hard'
Plug 'sheerun/vim-polyglot' " syntax and indentation
Plug 'vim-airline/vim-airline' " easy status line

call plug#end()

""""""""""""""""""""
" Options
""""""""""""""""""""

colorscheme gruvbox
filetype plugin indent on
syntax enable

set background=dark

set autoindent " take indent for new line from previous line
set copyindent " use existing indent structure with autoindent
set autoread " automatically update buffer if unmodified
set autowriteall " always save to disk

set cursorline " highlight line containing cursor
set number relativenumber " hybrid line numbers
set noshowmode  " redundant given airline
set showcmd " show (partial) command in status line
set wildmenu " use menu for command line completion
set lazyredraw " don't redraw while executing macros
set showmatch " briefly jump to matching bracket if insert one

set ignorecase " ignore case in search patterns
set smartcase " case sensitive when query includes uppercase
set incsearch " highlight match while typing search pattern
set hlsearch " highlight matches with last search pattern

set shell=zsh " shell to use for :!
set clipboard=unnamed " share clipboard with OS

""""""""""""""""""""
" Autocommands
""""""""""""""""""""

augroup committing
  autocmd!
  autocmd BufRead */.git/{*,**/*} inoremap wq <esc>:wq<CR>
augroup END

augroup filetypes
  autocmd!
  autocmd BufRead Fastfile set filetype=ruby
augroup END

augroup formatting
  autocmd!
  autocmd BufRead *.json :silent %!jq .
  autocmd BufRead *.{yml,yaml} :silent %!yq --prettyPrint --indent 2 read -
  autocmd BufRead *.xml :silent %!tidy -xml -indent -quiet -
  autocmd BufWritePre * %s/\s\+$//e " trim trailing whitespace
augroup END

augroup gitgutter
  autocmd!
  autocmd TextChanged,TextChangedI,TextChangedP * GitGutterBufferEnable
augroup END

augroup vimrc
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END
