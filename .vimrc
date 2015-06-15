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

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


" ==================  Added by Daniel Abramov ================== 
set tabstop=4
set shiftwidth=4
set expandtab
set number
set mouse=a
set bg=dark
set t_Co=256
set nowrap

map <F3> :nohl<CR>
imap <F3> <C-O>:nohl<CR>

" Trailing spaces, tabs highlighting
set list listchars=tab:>-,trail:~
hi SpecialKey ctermfg=017 guifg=#00005f

" Added from ru.wikibooks.org/wiki/Vim
set laststatus=2
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]

" ========= Configure bundles for use of Vundle ========= 
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

Plugin 'mileszs/ack.vim'            " Allows to search grep-like (Find All References)
Plugin 'bling/vim-airline'          " Vim status line
Plugin 'wincent/Command-T'          " Fuzzy-mathing file navigator inside the project
Plugin 'LustyExplorer'              " Fuzzy-mathing buffer navigator (quick search inside opened buffers)
Plugin 'taglist.vim'                " One of the most vim popular plugins, provides taglist window to show all functions etc. using ctags
Plugin 'tpope/vim-surround'         " Surrounds some block of code with brackets etc.
Plugin 'AutoTag'                    " Updates tags files whenever file gets saved
Plugin 'tomasr/molokai'             " TextMate like and Sublime Text like dark colorscheme for vim
Plugin 'Lokaltog/vim-easymotion'    " Fast navigate among the code on your visible page
Plugin 'godlygeek/tabular'          " Tabularize your code ;)

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
"
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1

" Bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w+<movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Easies moving of code blocks
vnoremap < <gv
vnoremap < >gv


" ========= TagList =========
"   :tag getUser => Jump to getUser method
"   :tn (or tnext) => go to next search result
"   :tp (or tprev) => to to previous search result
"   :ts (or tselect) => List the current tags
"   => Go back to last tag location
"   +Left click => Go to definition of a method

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


" ========= Ack Vim Configuration ========= 
" Open a new tab and search for something
nmap <Leader>a :tab split<CR>:Ack ""<Left>

" Immediately search for the word under the cursor in a new tab
nmap <Leader>A :tab split<CR>:Ack <C-r><C-w><CR>


" ========= CtrlP options (if installed) ========= 
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'


" ========= EasyMotion options ========= 
let g:EasyMotion_smartcase = 1
map <Leader> <Plug>(easymotion-prefix)
map <Leader>/ <Plug>(easymotion-sn)
omap <Leader>/ <Plug>(easymotion-tn)


" ========= YouCompleteMe options (if installed) ========= 
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_enable_diagnostic_signs = 0

" ========= Additional options =========
" Uncomment the line below if you have problems with matching parenthesis highlight
" hi MatchParen ctermbg=none ctermfg=red
