""""""""""""""""""""
" VimPlug
""""""""""""""""""""

call plug#begin('~/.vim/vim-plug')

" Navigation
Plug 'scrooloose/nerdtree'
let g:NERDTreeShowHidden=1
let g:NERDTreeNodeDelimiter="\u00a0"
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeWinSize=50

" Search
Plug '/usr/local/opt/fzf' " Homebrew installation
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
let g:rg_command='rg --hidden --vimgrep --glob !.git'
let g:rg_highlight=1

" Editor
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Colors
Plug 'luochen1990/rainbow'
Plug 'vim-scripts/SyntaxComplete'
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark='hard' " https://github.com/morhetz/gruvbox/wiki/Configuration#ggruvbox_contrast_dark

" TypeScript
Plug 'HerringtonDarkholme/yats.vim' " syntax highlighting
Plug 'Quramy/tsuquyomi' " client for TSServer

call plug#end()

""""""""""""""""""""
" Options
""""""""""""""""""""

set background=dark

set autoindent " take indent for new line from previous line

set cursorline " highlight line containing cursor
set number " print the line number in front of each line
set noshowmode  " redundant given airline
set showcmd " show (partial) command in status line
set wildmenu " use menu for command line completion
set lazyredraw " don't redraw while executing macros
set showmatch " briefly jump to matching bracket if insert one

set ignorecase " ignore case in search patterns
set incsearch " highlight match while typing search pattern
set hlsearch " highlight matches with last search pattern

set clipboard=unnamed " share clipboard with OS

colorscheme gruvbox

""""""""""""""""""""
" Autocommands
""""""""""""""""""""

augroup read_buffer
  autocmd!
  " force syntax highlighting
  autocmd BufRead *Fastfile set filetype=ruby
  " autoformat config and data files
  autocmd BufRead *.json :silent %!jq .
  autocmd BufRead *.{yml,yaml} :silent %!yq -P -I 2 read -
augroup END

augroup write_buffer
  autocmd!
  " trim trailing whitespace
  autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup reload_vimrc
  autocmd!
  autocmd BufWritePost *.vimrc source %
augroup END

""""""""""""""""""""
" Key Mappings
""""""""""""""""""""

let mapleader=","

" convenient buffer switching
nnoremap <leader>bn :write<CR>:buffers<CR>:buffer<space>
" avoid carpal tunnel in left hand
inoremap jk <esc>
vnoremap jk <esc>
" seriously, don't use esc
inoremap <esc> <nop>
vnoremap <esc> <nop>
" jump to previous line
nnoremap <leader>g ``zz

" Fugitive
nnoremap <leader>gb :Git<space>blame<CR>

" FZF
nnoremap <leader>f :write<CR>:FZF!<CR>

" Indentation
" https://vim.fandom.com/wiki/Fix_indentation
nnoremap <leader>i gg=G
" keep visual selection after indentation
vnoremap > >gv
vnoremap < <gv
vnoremap = =gv

" NERDTree
nnoremap <leader>nt :NERDTree<CR>
nnoremap <leader>ntc :NERDTreeClose<CR>
" open nearest git parent directory
nnoremap <leader>ntr :NERDTreeVCS<CR>
" open parent directory of buffer
nnoremap <leader>ntf :NERDTree<space>%<CR>

" Ripgrep
nnoremap <leader>rg :Rg<space>
nnoremap <leader>rgc :cclose<CR>
