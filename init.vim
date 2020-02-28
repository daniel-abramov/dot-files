call plug#begin('~/.vim/plugged')
 
Plug 'KeitaNakamura/neodark.vim'

Plug 'brooth/far.vim'
Plug 'cespare/vim-toml'
Plug 'danro/rename.vim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-sensible'
Plug 'vasconcelloslf/vim-interestingwords'
Plug 'vim-airline/vim-airline'
 
call plug#end()

set fileformat=unix
set fileformats=unix,dos,mac
set gdefault
set list listchars=tab:▸\ ,trail:·
set nobackup
set nohlsearch
set nowrap
set number
set number
set pastetoggle=<F7>
set shell=bash
set showmatch

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h
vnoremap < <gv
vnoremap > >gv

colorscheme neodark

if has('unnamedplus')
  set clipboard=unnamedplus,unnamed
else
  set clipboard+=unnamed
endif

let g:is_posix = 1

let g:neodark#use_256color = 1

let g:airline_theme = 'neodark'
let g:airline_powerline_fonts = 1

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd BufReadPost fugitive://* set bufhidden=delete
