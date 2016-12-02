" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" ====================  Vundle configuration  ====================

" Needed for Vundle, will be turned on after Vundle initializes
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim' " Let Vundle manage Vundle

" Colorschemes
Plugin 'tomasr/molokai'
Plugin 'junegunn/seoul256.vim'

" Appearance, code look and indentations [auxiliary plugins]
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-git'
Plugin 'Valloric/python-indent'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-scripts/python_match.vim'
Plugin 'python.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'

Plugin 'Valloric/ListToggle'
Plugin 'danro/rename.vim'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'vim-scripts/AutoTag'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'vim-scripts/taglist.vim'
Plugin 'wincent/command-t'
Plugin 'ervandew/supertab'
Plugin 'easymotion/vim-easymotion'
Plugin 'junegunn/vim-easy-align'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vasconcelloslf/vim-interestingwords'

call vundle#end()

" We reset the vimrc augroup. Autocommands are added to this group throughout
" the file
augroup vimrc
  autocmd!
augroup END

" Turn on filetype plugin indent after plugin commands
filetype plugin indent on

" ====================  Display settings  ==================== 
set background=dark     " enable for dark terminals
set scrolloff=2         " 2 lines above/below cursor when scrolling
set showmatch           " show matching bracket (moves cursor to matching paren and back to the paren again)
set matchtime=2         " reduces matching paren blink time from the 5[00]ms def
set noshowmode          " don't show how mode in status bar, we already have airline plugin for that :)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set title               " show filename in titlebar
" set cursorline          " highlights the current line
set winaltkeys=no       " turns off the Alt key bindings to the gui menu
set laststatus=2        " the statusline is now always shown

" When you type the first tab, it will complete as much as possible, the second
" tab hit will provide a list, the third and subsequent tabs will cycle through
" completion options so you can complete the file without further keys
set wildmode=longest,list,full
set wildmenu            " completion with menu

" Trailing spaces, tabs highlighting
set list listchars=tab:>-,trail:~
hi SpecialKey ctermfg=017 guifg=#00005f

" The "longest" option makes completion insert the longest prefix of all
" the possible matches; see :h completeopt
set completeopt=menu,menuone,longest
set switchbuf=useopen,usetab

" Sets a font for the GUI on Windows
if has("gui_win32")
  set guifont=Consolas\ For\ Powerline:h11
elseif has("gui_macvim")
  set guifont=Menlo\ for\ Powerline
else
  set guifont=Monaco\ for\ Powerline\ 8
end

" ====================  Editor settings  ==================== 
set ignorecase                  " case insensitive searching
set smartcase                   " but become case sensitive if you type uppercase characters
set autoindent                  " on new lines, match indent of previous line
set copyindent                  " copy the previous indentation on autoindenting
set cindent                     " smart indenting for c-like code
set cino=b1,g0,N-s,t0,(0,W4     " see :h cinoptions-values
set smarttab                    " smart tab handling for indenting
set magic                       " change the way backslashes are used in search patterns
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set nobackup                    " no backup~ files
set tabstop=4                   " number of spaces a tab counts for
set shiftwidth=4                " spaces for autoindents
set softtabstop=4               " hard to explain, read :h softtabstop
set shiftround                  " makes indenting a multiple of shiftwidth
set expandtab                   " turn a tab into spaces
set fileformat=unix             " file mode is unix
set fileformats=unix,dos,mac    " detects unix, dos, mac file formats in that order
set viminfo='20,\"500           " remember copy registers after quitting in the .viminfo file, 20 jump links, regs up to 500 lines
set hidden                      " allows making buffers hidden even with unsaved changes
set history=500                 " remember more commands and search history
set undolevels=500              " use many levels of undo
set autoread                    " auto read when a file is changed from the outside
set mouse=a                     " enables the mouse in all modes
set mousemodel=popup_setpos     " Right-click on selection should bring up a menu
set foldlevelstart=99           " all folds are opened by default
set shortmess=a                 " read :h shortmess
set cmdheight=1                 " number of screen lines to use foe the command-line
set whichwrap+=<,>,h,l          " allow backspace and cursor keys to cross line boundaries
set nohlsearch                  " do not highlight searched-for phrases
set incsearch                   " ...but do highlight-as-I-type the search string
set gdefault                    " this makes search/replace global by default
set textwidth=120               " enforces a specified line-length and auto inserts break when reach the limit; you can reformat the current paragraph with gqap
set colorcolumn=+1              " this makes the color after the textwidth column highlighted
set formatoptions=tcroqnj       " options for formatting text; see :h formatoptions
set number                      " show line numbers
set nowrap                      " disable wrapping by default

set ttyfast                     " Attempt to optimize vim on terminals
set ttyscroll=3                 " Attempt to optimize vim on terminals
set lazyredraw                  " Attempt to optimize vim on terminals

" toggles vim's paste mode; when we want to paste something into vim from a
" different application, turning on paste mode prevents the insertion of extra
" whitespace
set pastetoggle=<F7>

" With this, the gui (gvim and macvm) now doesn't have the toolbar, the left
" and right scrollbars and the menu
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=M

" this makes sure that shell scripts are highlighted as bash scripts and not
" sh scripts
let g:is_posix=1

" Look for tag def in a "tags" file in the dir of the current file, then for
" that same file in every folder above the folder of the current file, until the
" root.
set tags=./tags;/

" turns off all error bells, visual or otherwise
set noerrorbells visualbell t_vb=
autocmd vimrc GUIEnter * set visualbell t_vb=

if has('unnamedplus')
  " By default, Vim will not use the system clipboard when yanking/pasting to
  " the default register. This option makes Vim use the system default
  " clipboard.
  " Note that on X11, there are _two_ system clipboards: the "standard" one, and
  " the selection/mouse-middle-click one. Vim sees the standard one as register
  " '+' (and this option makes Vim use it by default) and the selection one as
  " '*'.
  " See :h 'clipboard' for details.
  set clipboard=unnamedplus,unnamed
else
  " Vim now also uses the selection system clipboard for default yank/paste.
  set clipboard+=unnamed
endif


" TODO: split this into separate plugin
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        execute "Ack " . l:pattern . ' %'
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
vnoremap <silent> gv :call VisualSearch('gv')<CR>

" cindent is a bit too smart for its own good and triggers in text files when
" you're typing inside parens and then hit enter; it aligns the text with the
" opening paren and we do NOT want this in text files!
autocmd vimrc FileType text,markdown,gitcommit set nocindent

" This command will allow us to save a file we don't have permission to save
" *after* we have already opened it. Super useful.
cnoremap w!! w !sudo tee % >/dev/null

" Don't use Ex mode, use Q for formatting
vnoremap Q gq
nnoremap Q gqap

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set t_Co=256

    " Enable in case of using TextMate molokai theme
    let g:molokai_original = 1
    let g:rehash256 = 1
    colorscheme molokai
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" Added from ru.wikibooks.org/wiki/Vim
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]

" Bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w+<movement>
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h

" Easies moving of code blocks
vnoremap < <gv
vnoremap > >gv

" Mappings for cyrillic letters
set langmap=йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э',яz,чx,сc,мv,иb,тn,ьm,ю.,ё',ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х\{,Ъ\},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж\:,Э\",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б\<,Ю\>

" Quick workaround for shell bug
set shell=bash


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" ====================  TagList  ====================

"   :tag getUser => Jump to getUser method
"   :tn (or tnext) => go to next search result
"   :tp (or tprev) => to to previous search result
"   :ts (or tselect) => List the current tags
"   => Go back to last tag location
"   +Left click => Go to definition of a method

" Some settings to vim-taglist
let Tlist_winWidth=50
map <F7> :TlistToggle<CR>

" Building ctags for current directory
map <F8> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Open the definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Open the definition in a vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" g C - ] - opens a quick dialog to select one between multiple definitions


" ====================  Command-T  ====================

set wildignore+=*.o,*.obj,.git,*.pyc,*.so,blaze*,READONLY,llvm,Library*
set wildignore+=CMakeFiles,packages/*,**/packages/*,**/node_modules/*
let g:CommandTWildIgnore=&wildignore

let g:CommandTMaxHeight = 30
let g:CommandTFileScanner = 'find'
let g:CommandTTraverseSCM = 'pwd'

" MacVim doesn't use tab focus to switch from command-t input field to the file
" list, so using j and k for next and prev screws everything up. But it does
" work on linux so let's use it there.
if has("gui_gtk2")
    let g:CommandTSelectNextMap = [ '<down>' ]
    let g:CommandTSelectPrevMap = [ '<up>' ]
endif


" ====================  yankring  ====================

let g:yankring_history_dir = '$HOME/.vim/tmp'
" this is so that single char deletes don't end up in the yankring
let g:yankring_min_element_length = 2
let g:yankring_window_height = 14
nnoremap <leader>r :YRShow<CR>

" this makes Y yank from the cursor to the end of the line, which makes more
" sense than the default of yanking the whole current line (we can use yy for
" that)
function! YRRunAfterMaps()
    nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
endfunction


" ====================  ListToggle  ====================
let g:lt_height = 15
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'


" ====================  fswitch  ====================

" A 'companion' file is a .cpp file to an .h file and vice versa

" Opens the companion file in the current window
nnoremap <F4> :FSHere<cr>

" Opens the companion file in the window to the left (window needs to exist)
" This is actually a duplicate of the :FSLeft command which for some reason
" doesn't work.
nnoremap <Leader>sl :call FSwitch('%', 'wincmd l')<cr>

" Same as above, only opens it in window to the right
nnoremap <Leader>sr :call FSwitch('%', 'wincmd r')<cr>

" Creates a new window on the left and opens the companion file in it
nnoremap <Leader>sv :FSSplitLeft<cr>

" This handles c++ files with the ".cc" extension.
augroup switchfiles
  au!
  au BufEnter *.cc let b:fswitchdst  = 'h,hxx'
  au BufEnter *.cc let b:fswitchlocs = './,reg:/src/include/,reg:|src|include/**|,../include'
  au BufEnter *.h  let b:fswitchdst  = 'cpp,cc,c'
  au BufEnter *.h  let b:fswitchlocs = './,reg:/include/src/,reg:/include.*/src/,../src'
augroup END


" ====================  tagbar  ====================

let g:tagbar_left = 1
let g:tagbar_sort = 0
if has("gui_macvim")
  let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
endif

nnoremap <F6> :TagbarToggle<cr><c-w>=


" ====================  Ack  ====================

if executable('ag')
  let g:ackprg = "ag --nocolor --nogroup --column"
elseif executable('ack-grep')
  let g:ackprg = "ack-grep --nocolor --nogroup --column"
elseif executable('ack')
  let g:ackprg = "ack --nocolor --nogroup --column"
endif


" ====================  Airline  ====================
let g:airline_theme = 'tomorrow'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" ====================  YouCompleteMe  ====================
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_filetype_specific_completion_to_disable = {'javascript': 1}

" let g:ycm_extra_conf_globlist = ['~/repos/*']

nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>
nnoremap <leader>g :YcmCompleter GoTo<CR>
" nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>


" ====================  Vim-cpp-enhanced-highlight  ====================
" let g:cpp_class_scope_highlight = 1
let c_no_curly_error=1


" ====================  tpope/vim-fugitive  ====================

" Remove temporary created buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

let g:seoul256_background = 233
colo seoul256

let g:netrw_liststyle=3

set directory=$HOME/.vim/tmp
" temp
