" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.  Use the default filetype settings, so that
  " mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


" Added by Daniel Abramov

set tabstop=4
set shiftwidth=4
set expandtab
set number

set mouse=a
set bg=dark
set t_Co=256

" ====================================================================================================================================================
" Added from ru.wikibooks.org/wiki/Vim
set laststatus=2
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]

" ========== Uncomment for enabling pathogen ========== 
" execute pathogen#infect()
" syntax on
" filetype plugin indent on

" Configure bundles for use of Vundle ======
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

Plugin 'mileszs/ack.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'wincent/Command-T'
Plugin 'LustyExplorer'
Plugin 'taglist.vim'
Plugin 'tpope/vim-surround'
Plugin 'AutoTag'
Plugin 'tomasr/molokai'

call vundle#end()

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.
" ===========================================


colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1

" Rebind <Leader> key
" let mapleader=","

nnoremap <Leader>s :w<CR>

" Bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w+<movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Easies moving of code blocks
vnoremap < <gv
vnoremap < >gv

" Some settings to vim-taglist
let Tlist_winWidth=50
map <F4> :TlistToggle<CR>

" Building ctags for current directory
map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fileds=+iaS --extra=+q .<CR>

" Tempoprary enabled for LustyExplorer
set hidden

" Open the definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Open the definition in a vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" g C - ] - opens a quick dialog to select one between multiple definitions

" Open a new tab and search for something
nmap <Leader>a :tab split<CR>:Ack ""<Left>

" Immediately search for the word under the cursor in a new tab
nmap <Leader>A :tab split<CR>:Ack <C-r><C-w><CR>

" ========= TagList =========
"   :tag getUser => Jump to getUser method
"   :tn (or tnext) => go to next search result
"   :tp (or tprev) => to to previous search result
"   :ts (or tselect) => List the current tags
"   => Go back to last tag location
"   +Left click => Go to definition of a method

