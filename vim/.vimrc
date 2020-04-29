""""""""""""""""""""
" Key Mappings
""""""""""""""""""""

let mapleader="," " set this before installing plugins

" Overrides
" avoid carpal tunnel in left hand
inoremap jk <Esc>
vnoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>
" TODO: temporarily force new muscle memory
inoremap <Esc> <Nop>
vnoremap <Esc> <Nop>
xnoremap <Esc> <Nop>
cnoremap <C-c> <Nop>
" keep visual selection after indentation
vnoremap > >gv
vnoremap < <gv
vnoremap = =gv
" stay in normal mode when inserting newlines
nnoremap o o<Esc>
nnoremap O O<Esc>
" treat yank like change and delete
nnoremap Y y$

" Complements
" ; for next f{char}, ' for previous
nnoremap ' ,
" home row is faster
noremap H <Home>
noremap L <End>
" TODO: temporarily force new muscle memory
nnoremap $ <Nop>
" qq to record, Q to replay
nnoremap Q @q

" Misc
nnoremap <Leader>= gg=G
" prefer vertical browsing
" FIXME: this is unideal for things like :s/ h //
cnoreabbrev h vertical<Space>botright<Space>help
cnoreabbrev help vertical<Space>botright<Space>help

" FZF
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>hs :History:<CR>
nnoremap <silent> <Leader>rg :Rg<Space>
nnoremap <silent> <Leader>w :Windows<CR>

" Git
nnoremap <silent> <Leader>gb :Gblame<CR>
nnoremap <silent> <Leader>gd :Gdiffsplit<CR>
nnoremap <silent> <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>ggh :GitGutterLineHighlightsToggle<CR>

" Vim Plug
nnoremap <silent> <Leader>pi :PlugInstall<CR>:q<CR>
nnoremap <silent> <Leader>pu :PlugUpdate<CR>:q<CR>
nnoremap <silent> <Leader>pc :PlugClean<CR>

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
" Packages
""""""""""""""""""""

packadd matchit " makes the % command work better

""""""""""""""""""""
" Options
""""""""""""""""""""

colorscheme gruvbox " managed via vim-plug
filetype plugin indent on " source .vim/{ftplugin,indent}/*.vim files
syntax enable " syntax highlighting

" Display
set background=dark " 🧛
set antialias " use smooth fonts
set number relativenumber " hybrid line numbers for easier motions
set noshowmode  " airline shows mode
set cursorline " highlight line containing cursor
set shortmess+=I " hide startup message
set scrolloff=10 " minimum line count to surround curor with
set visualbell " flash screen instead of beeping
set lazyredraw " don't redraw while executing macros

" Editing
set autoindent " use indentation of previous line during line insertion
set copyindent " use existing indent structure with autoindent
set backspace=indent,eol,start " make backspace work everywhere
set tildeop " use ~ as an operator instead of just current character
set matchpairs+=<:> " easier HTML and JSX matching with %
set whichwrap=b,s,h,l " easier navigation of wrapped lines

" External
set autoread " automatically update buffer if unmodified
set autowriteall " always save to disk
set clipboard=unnamed " share OS clipboard with y, d, etc
set mouse=a " enable mouse in all modes
set mousefocus " change windows with mouse
set mousehide " only show mouse when moving
set shell=zsh " shell to use for :shell
set undofile " enable undo after writes

" Navigation
set splitright " sensible split window
set wildmenu " enable tab navigatable menu for command line completion
set wildmode=list:full " 1st tab: show all matches, 2nd tab: show wildmenu

" Search
set magic " no more escaping regexes
set ignorecase " ignore case in search patterns
set smartcase " case sensitive when query includes uppercase
set incsearch " highlight match while typing search pattern
set hlsearch " highlight hits while traversing search matches

""""""""""""""""""""
" Autocommands
""""""""""""""""""""

" consistent formatting for machine-ish files
augroup formatting
  autocmd!
  autocmd BufRead *.json :silent %!jq .
  autocmd BufRead *.{yml,yaml} :silent %!yq --prettyPrint --indent 2 read -
  autocmd BufRead *.xml :silent %!tidy -xml -indent -quiet -
  autocmd BufWritePre * %s/\s\+$//e " trim trailing whitespace
augroup END

" keep git gutter as fresh as possible
augroup gitgutter
  autocmd!
  autocmd TextChanged,TextChangedI,TextChangedP * GitGutterBufferEnable
augroup END

" Create intermediate directories of current file as required
" Credit: https://github.com/DataWraith/auto_mkdir
function <SID>auto_mkdir()
  let l:parent_dir = expand('<afile>:p:h')
  if !isdirectory(l:parent_dir)
    call mkdir(l:parent_dir, 'p')
  endif
endfunction
augroup auto_mkdir
  autocmd!
  autocmd BufWritePre,FileWritePre * call <SID>auto_mkdir()
augroup END

" hot reload vimrc changes
augroup vimrc
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END
