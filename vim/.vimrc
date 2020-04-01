set background=dark
colorscheme brogrammer

set tabstop=4 " number of spaces that <Tab> in file uses
set softtabstop=4 " number of spaces that <Tab> uses while editing
set expandtab " use spaces when <Tab> is inserted
set autoindent " take indent for new line from previous line
set shiftwidth=4 " number of spaces to use for (auto)indent step

set number " print the line number in front of each line
set noshowmode  " redundant given airline
set showcmd " show (partial) command in status line
set wildmenu " use menu for command line completion
set lazyredraw " don't redraw while executing macros
set showmatch " briefly jump to matching bracket if insert one

set ignorecase " ignore case in search patterns
set incsearch " highlight match while typing search pattern
set hlsearch " highlight matches with last search pattern

set clipboard=unnamed " use the clipboard as the unnamed register

autocmd BufWritePre * %s/\s\+$//e " trim trailing whitespace on save

call plug#begin('~/.vim/vim-plug')

" Navigation
Plug 'scrooloose/nerdtree'

" Search
Plug '/usr/local/opt/fzf' " Homebrew installation
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'

" Editor
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Syntax
Plug 'luochen1990/rainbow'
Plug 'vim-scripts/SyntaxComplete'

" TypeScript
Plug 'HerringtonDarkholme/yats.vim' " syntax highlighting
Plug 'Quramy/tsuquyomi' " client for TSServer

call plug#end()

let g:airline_theme='dark'

cnoreabbrev ss set syntax=

" Ripgrep
let g:rg_command='rg --hidden --vimgrep --glob !.git'
let g:rg_highlight=1
cnoreabbrev rg Rg
cnoreabbrev rgc cclose

" NERDTree
cnoreabbrev nt NERDTree
cnoreabbrev ntc NERDTreeClose
cnoreabbrev ntr NERDTreeVCS " nearest parent directory containing .git
cnoreabbrev ntf NERDTree % " parent directory of current buffer

let g:NERDTreeShowHidden=1
let g:NERDTreeNodeDelimiter="\u00a0"
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeWinSize=50

" FZF
cnoreabbrev f FZF!

" Git
cnoreabbrev gb Git blame
