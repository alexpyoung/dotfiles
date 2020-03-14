set background=dark
colorscheme brogrammer

set tabstop=4 " number of spaces that <Tab> in file uses
set softtabstop=4 " number of spaces that <Tab> uses while editing
set expandtab " use spaces when <Tab> is inserted
set autoindent " take indent for new line from previous line
set shiftwidth=4 " number of spaces to use for (auto)indent step 

set number " print the line number in front of each line
set showcmd " show (partial) command in status line
set wildmenu " use menu for command line completion
set lazyredraw " don't redraw while executing macros
set showmatch " briefly jump to matching bracket if insert one

set ignorecase " ignore case in search patterns
set incsearch " highlight match while typing search pattern
set hlsearch " highlight matches with last search pattern

set clipboard=unnamed " use the clipboard as the unnamed register

autocmd BufWritePre * %s/\s\+$//e " trim trailing whitespace on save

" Highlight statusline of active window
hi StatusLine   ctermfg=15  guifg=#ffffff ctermbg=239 guibg=#4e4e4e cterm=bold gui=bold
hi StatusLineNC ctermfg=249 guifg=#b2b2b2 ctermbg=237 guibg=#3a3a3a cterm=none gui=none

call plug#begin('~/.vim/vim-plug')

" Navigation
Plug 'scrooloose/nerdtree' 

" Search
Plug '/usr/local/opt/fzf' " Homebrew installation
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'

" Git
Plug 'tpope/vim-fugitive'

" Syntax
Plug 'vim-scripts/SyntaxComplete'

" TypeScript
Plug 'HerringtonDarkholme/yats.vim' " syntax highlighting
Plug 'Quramy/tsuquyomi' " client for TSServer

call plug#end()

" Ripgrep
let g:rg_command="rg --vimgrep -C 2"
let g:rg_highlight=1

" NERDTree
cnoreabbrev nt NERDTree
cnoreabbrev ntc NERDTreeClose
cnoreabbrev ntr NERDTreeVCS 

let g:NERDTreeShowHidden=1
let g:NERDTreeNodeDelimiter="\u00a0"
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeWinSize=50

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

" open NERDTree if vim is invoked with no file
autocmd VimEnter * call StartUp()

" FZF
cnoreabbrev f Files

" Quick directories
cnoreabbrev cd cd ~/q/

