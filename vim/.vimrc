call plug#begin('~/.vim/plugged')

Plug 'KeitaNakamura/neodark.vim'

Plug 'brooth/far.vim'
Plug 'cespare/vim-toml'
Plug 'danro/rename.vim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-sensible'
Plug 'vasconcelloslf/vim-interestingwords'
Plug 'vim-airline/vim-airline'
Plug 'lambdalisue/suda.vim'

Plug 'andys8/vim-elm-syntax'
Plug 'tomasiser/vim-code-dark'

" Experimental
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

call plug#end()

set fileformat=unix
set fileformats=unix,dos,mac
set gdefault
set ignorecase
set list listchars=tab:▸\ ,trail:·
set nobackup
set nohlsearch
set ignorecase
set nowrap
set relativenumber
set pastetoggle=<F7>
set shell=bash
set showmatch

" EXPERIMENTAL --------------------------------------------------
" Required for operations modifying multiple buffers like rename.
set hidden

" Always draw the signcolumn.
set signcolumn=yes

" Avoid showing extra messages when using completion
set shortmess+=c

" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])

let g:LanguageClient_serverCommands = {
    \ 'rust': [ 'rust-analyzer' ],
    \ }

" note that if you are using Plug mapping you should not use `noremap` mappings.
nmap <F6> <Plug>(lcn-menu)
nmap <F5> <Plug>(lcn-code-action)
nmap <F2> <Plug>(lcn-rename)
" Or map each action separately
nmap <silent> <c-space> <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> gr <Plug>(lcn-references)

" Avoid showing extra messages when using completion
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Trigger completion with <Tab>
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ deoplete#can_complete() ? deoplete#complete() : ''

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" reload the file once changed from an external program, see https://github.com/neovim/neovim/issues/1936
set autoread
au FocusGained * :checktime
" EXPERIMENTAL --------------------------------------------------

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h
vnoremap < <gv
vnoremap > >gv

colorscheme neodark

set clipboard=unnamedplus,unnamed

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

nmap <F3> :NERDTreeFind<CR>
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>s :Ag <C-R><C-W><CR>

au Filetype rust set colorcolumn=100

set updatetime=300

let g:interestingWordsRandomiseColors = 1
